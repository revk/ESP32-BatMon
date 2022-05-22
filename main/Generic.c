/* Generic app */
/* Copyright ©2019 - 2022 Adrian Kennard, Andrews & Arnold Ltd.See LICENCE file for details .GPL 3.0 */
/* This has a wide range of example stuff in it that does not in itself warrant a separate project */
/* Including UART logging and debug for Daikin air-con */
/* Including display text and QR code */
/* Including SolarEdge monitor */

static const char TAG[] = "Generic";

#include "revk.h"
#include "esp_sleep.h"
#include "esp_task_wdt.h"
#include "esp_http_client.h"
#include "esp_crt_bundle.h"
#include "vl53l0x.h"
#include "vl53l1x.h"
#include "gfx.h"
#include "iec18004.h"
#include <hal/spi_types.h>
#include <driver/gpio.h>
#include <driver/uart.h>
#include <driver/adc.h>
#include <driver/ledc.h>
#include <esp_adc_cal.h>

#ifdef	CONFIG_LWIP_DHCP_DOES_ARP_CHECK
#warning CONFIG_LWIP_DHCP_DOES_ARP_CHECK means DHCP is slow
#endif
#ifndef	CONFIG_LWIP_DHCP_RESTORE_LAST_IP
#warning CONFIG_LWIP_DHCP_RESTORE_LAST_IP may improve speed
#endif
#ifndef	CONFIG_BOOTLOADER_SKIP_VALIDATE_IN_DEEP_SLEEP
#warning CONFIG_BOOTLOADER_SKIP_VALIDATE_IN_DEEP_SLEEP may speed boot
#endif
#if	CONFIG_BOOTLOADER_LOG_LEVEL > 0
#warning CONFIG_BOOTLOADER_LOG_LEVEL recommended to be no output
#endif

#define	MAXGPIO	36
#define BITFIELDS "-"
#define PORT_INV 0x40
#define port_mask(p) ((p)&63)
static uint8_t input[MAXGPIO];  //Input GPIOs
static uint8_t output[MAXGPIO]; //Output GPIOs
static uint32_t outputmark[MAXGPIO];    //Output mark time(ms)
static uint32_t outputspace[MAXGPIO];   //Output mark time(ms)
static uint8_t power[MAXGPIO];  //Fixed output GPIOs
int holding = 0;

// Dynamic
static uint64_t volatile outputbits = 0;        // Requested output
static uint64_t volatile outputraw = 0; // Current output
static uint64_t volatile outputoverride = 0;    // Override output (e.g. PWM)
static uint32_t outputremaining[MAXGPIO] = { }; //Output remaining time(ms)
static uint32_t outputcount[MAXGPIO] = { };     //Output count

#define	settings		\
	u32(period,0)	\
	u32(awake,0)	\
	io(usb,)	\
	io(charger,)	\
	io(adcon,)	\
	u8(adc,)		\
	u32(adcr1,18000)	\
	u32(adcr2,1000)	\
	b(ranger0x)	\
	io(rangergnd,)	\
	io(rangerpwr,)	\
	io(rangerscl,)	\
	io(rangersda,)	\
        u8(rangeraddress,0x29)  \
	io(gfxcs,)	\
	io(gfxsck,)	\
	io(gfxmosi,)	\
	io(gfxdc,)	\
	io(gfxrst,)	\
	io(gfxbusy,)	\
	io(gfxena,)	\
	u8(gfxflip,)	\
	io(uart1rx,)	\
	io(uart2rx,)	\
	u8(defcon,0)	\
	b(s21)		\
	b(daikin)	\
	s(sekey)	\
	u32(sesite,0)	\

#define u32(n,d)        uint32_t n;
#define s8(n,d) int8_t n;
#define u8(n,d) uint8_t n;
#define b(n) uint8_t n;
#define s(n) char * n;
#define io(n,d)           uint8_t n;
settings
#undef io
#undef u32
#undef s8
#undef u8
#undef b
#undef s
    uint64_t busy = 0;
char usb_present = 0;
char charger_present = 0;
const char *rangererr = NULL;
uint16_t range = 0;
uint32_t voltage = 0;
httpd_handle_t webserver = NULL;
int8_t defcon_level = -1;

volatile uint8_t uarts = 1;
void uart_task(void *arg)
{
   uint8_t rx = *(uint8_t *) arg;
   uint8_t uart = uarts++;
   esp_err_t err = 0;
   uart_config_t uart_config = {
      .baud_rate = s21 ? 2400 : 9600,
      .data_bits = UART_DATA_8_BITS,
      .parity = UART_PARITY_DISABLE,
      .stop_bits = UART_STOP_BITS_1,
      .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
   };
   if (!err)
      err = uart_param_config(uart, &uart_config);
   if (!err)
      err = uart_set_pin(uart, -1, port_mask(rx), -1, -1);
   if (!err)
      err = uart_driver_install(uart, 1024, 0, 0, NULL, 0);
   if (err)
   {
      jo_t j = jo_object_alloc();
      jo_string(j, "error", "Failed to uart");
      jo_int(j, "uart", uart);
      jo_int(j, "gpio", port_mask(rx));
      jo_string(j, "description", esp_err_to_name(err));
      revk_error("uart", &j);
      return;
   }
   while (1)
   {
      uint8_t buf[256];
      int len = 0;
      if (s21)
      {
         len = uart_read_bytes(uart, buf, 1, 10 / portTICK_PERIOD_MS);
         if (len == 1)
         {                      // Start
            if (*buf == 6)
               len = 0;         // ACK
            else
               while (len < sizeof(buf))
               {
                  if (uart_read_bytes(uart, buf + len, 1, 100 / portTICK_PERIOD_MS) <= 0)
                     break;
                  len++;
                  if (buf[len - 1] == 3)
                     break;     // End
               }
         }
      } else
         len = uart_read_bytes(uart, buf, sizeof(buf), 10 / portTICK_PERIOD_MS);
      if (len <= 0)
         continue;
      jo_t j = jo_object_alloc();
      if (daikin)
      {                         // Daikin debug
         if (s21)
         {
            uint8_t c = 0;
            for (int i = 1; i < len - 2; i++)
               c += buf[i];
            if (buf[len - 2] != c)
            {
               jo_stringf(j, "badsum", "%02X", c);
               jo_base16(j, "raw", buf, len);
            }
            if (len < 5)
            {
               jo_bool(j, "badlen", 1);
               jo_base16(j, "raw", buf, len);
            }
            jo_stringf(j, uart == 1 ? "tx" : "rx", "%c", buf[1]);
            jo_stringf(j, "cmd", "%c", buf[2]);
            if (len > 5)
            {
               int i;
               for (i = 3; i < len - 2 && ((buf[i] >= 0x20 && buf[i] <= 0x7E) || buf[i] == 0xFF); i++);
               if (i < len - 2)
                  jo_base16(j, "data", buf + 3, len - 5);
               else
                  jo_stringn(j, "value", (char *) buf + 3, len - 5);
            }
         } else
         {
            uint8_t c = 0;
            for (int i = 0; i < len; i++)
               c += buf[i];
            if (c != 0xFF)
               jo_bool(j, "badsum", 1);
            if (len < 6 || buf[2] != len)
               jo_bool(j, "badlen", 1);
            if (buf[0] != 6 || buf[3] != 1)
               jo_bool(j, "badhead", 1);
            jo_stringf(j, uart == 1 ? "tx" : "rx", "%02X", buf[1]);
            if (buf[4] != (uart == 1 ? 0 : 6))
               jo_stringf(j, "tag", "%02X", buf[4]);
            if (len > 6)
               jo_base16(j, "data", buf + 5, len - 6);
         }
      } else
      {
         jo_int(j, "uart", uart);
         jo_int(j, "gpio", port_mask(rx));
         jo_int(j, "len", len);
         jo_base16(j, "data", buf, len);
      }
      revk_info("uart", &j);
   }
}

void defcon_task(void *arg)
{
   // Expects outputs to be configured
   // 0=Beep - set mark/space
   // 1-5=DEFCON lights White/Red/Yellow/Green/Blue
   // 6=Click
   // 7=Blink - set mark/space
   // The defcon setting is lowest DEFCON setting that we don't beep for, e.g. 5 would be good not to beep when going to DEFCON 5 or above
   outputcount[7] = -1;         // Blinking forever - set mark/space
   outputbits |= (1 << 7);      // Start blinking
   int8_t level = -1;           // Current DEFCON level
   while (1)
   {
      usleep(10000);
      if (level != defcon_level)
      {
         usleep(100000);
         if (level != defcon_level)
         {
            int8_t waslevel = level;
            level = defcon_level;
            // Off existing
            outputbits = (outputbits & ~0x7F) | (1 << 6) | (1 << 7);
            usleep(500000);
            // Report
            jo_t j = jo_object_alloc();
            jo_int(j, "level", level);
            revk_info("defcon", &j);
            // Beep count
            if (level < defcon)
               outputcount[0] = waslevel < level ? 1 : level ? 2 : 3;
            // On new
            outputbits = (outputbits & ~0x7F) | (level > 5 ? 0 : level ? (1 << level) : (1 << 1)) | (outputcount[0] ? (1 << 0) : 0);
            if (!level)
               for (int i = 2; i <= 5; i++)
               {
                  usleep(100000);
                  outputbits = (outputbits ^ (1 << 6)) | (1 << i);
               }
            sleep(1);
         }
      }
   }
}


void se_task(void *arg)
{                               // Solar edge monitor
   char *url = NULL;
   int max = 5000;
   char *buf = malloc(max);
   jo_t fetch(const char *url) {
      jo_t j = NULL;
      esp_http_client_config_t config = {
         .url = url,
         .crt_bundle_attach = esp_crt_bundle_attach,
      };
      esp_http_client_handle_t client = esp_http_client_init(&config);
      if (!client)
         return NULL;
      if (!esp_http_client_open(client, 0))
      {
         if (esp_http_client_fetch_headers(client) >= 0)
         {
            int len = esp_http_client_read_response(client, buf, max);
            if (len > 0 && len <= max)
               j = jo_parse_mem(buf, len);
         }
         esp_http_client_close(client);
      }
      REVK_ERR_CHECK(esp_http_client_cleanup(client));
      return j;
   }
   char city[17];
   jo_t j;
   asprintf(&url, "https://monitoringapi.solaredge.com/site/%d/details?api_key=%s", sesite, sekey);
   while (1)
   {
      sleep(5);
      if (revk_link_down())
         continue;
      if ((j = fetch(url)))
      {
         if (jo_find(j, "*.location.city") == JO_STRING)
            jo_strncpy(j, city, sizeof(city));
         jo_free(&j);
         break;
      } else
         sleep(60);
   }
   free(url);
#ifndef	CONFIG_GFX_NONE
   time_t last = 0;
   float today = 0;
   if (url && buf)
      while (1)
      {
         char unit[3] = "";
         float pv = 0,
             load = 0;
         time_t this = time(0);
         if (last / 15 / 60 != this / 15 / 60)
         {                      // Stats
            last = this;
            asprintf(&url, "https://monitoringapi.solaredge.com/site/%d/overview?api_key=%s", sesite, sekey);
            if ((j = fetch(url)))
            {
               if (jo_find(j, "*.lastDayData.energy") == JO_NUMBER)
                  today = jo_read_float(j);
            }
            free(url);
         }
         asprintf(&url, "https://monitoringapi.solaredge.com/site/%d/currentPowerFlow?api_key=%s", sesite, sekey);
         if ((j = fetch(url)))
         {
            if (jo_find(j, "*.unit") == JO_STRING)
               jo_strncpy(j, unit, sizeof(unit));
            if (jo_find(j, "*.PV.currentPower") == JO_NUMBER)
               pv = jo_read_float(j) * 1000;
            if (jo_find(j, "*.LOAD.currentPower") == JO_NUMBER)
               load = jo_read_float(j) * 1000;
            jo_free(&j);
         }
         free(url);
         // Log
         j = jo_object_alloc();
         jo_int(j, "site", sesite);
         jo_string(j, "city", city);
         jo_litf(j, "pv", "%.2f", pv / 1000);
         jo_litf(j, "load", "%.2f", load / 1000);
         jo_litf(j, "today", "%.3f", today / 1000);
         jo_string(j, "unit", unit);
         revk_info("solaredge", &j);
         // Display
         gfx_lock();
         gfx_clear(0);
         gfx_pos(gfx_width() / 2, 0, GFX_T | GFX_C | GFX_V);
         gfx_text(-2, "%s", city);
         gfx_fill(gfx_width(), 1, 255);
         gfx_pos(gfx_x(), gfx_y() + 2, gfx_a());
         gfx_text(-2, "Generation");
         if (pv < 1000 && *unit == 'k')
            gfx_text(5, "%.0f%s", pv, unit + 1);
         else
            gfx_text(5, "%.2f%s", pv / 1000, unit);
         gfx_text(-2, "Consumption");
         if (load < 1000 && *unit == 'k')
            gfx_text(5, "%.0f%s", load, unit + 1);
         else
            gfx_text(5, "%.2f%s", load / 1000, unit);
         gfx_fill(gfx_width(), 1, 255);
         gfx_pos(gfx_x(), gfx_y() + 2, gfx_a());
         gfx_text(-2, "Today");
         if (today < 1000 && *unit == 'k')
            gfx_text(5, "%.0f%sh", today, unit + 1);
         else
            gfx_text(5, "%.1f%sh", today / 1000, unit);
         gfx_unlock();
         sleep(60);
      }
#endif
}

void input_task(void *arg)
{
   arg = arg;
   while (1)
   {
      usleep(1000LL);
      for (int i = 0; i < MAXGPIO; i++)
         if (input[i])
         {
         }
   }
}

void output_task(void *arg)
{
   arg = arg;
   while (1)
   {
      usleep(1000);
      for (int i = 0; i < MAXGPIO; i++)
         if (output[i] && !(outputoverride & (1ULL << i)))
         {
            int p = port_mask(output[i]);
            if (outputremaining[i] && !--outputremaining[i])
               outputbits ^= (1ULL << i);       //timeout
            if ((outputbits ^ outputraw) & (1ULL << i))
            {                   //Change output
               outputraw ^= (1ULL << i);
               //REVK_ERR_CHECK(gpio_hold_dis(p));
               REVK_ERR_CHECK(gpio_set_level(p, ((output[i] & PORT_INV) ? 1 : 0) ^ ((outputbits >> i) & 1)));
               //REVK_ERR_CHECK(gpio_hold_en(p));
               if (outputbits & (1ULL << i))
                  outputremaining[i] = outputmark[i];   //Time
               else if (!outputcount[i] || (outputcount[i] != -1 && !--outputcount[i]))
                  outputremaining[i] = 0;
               else
                  outputremaining[i] = outputspace[i];  //Time
            }
         }
   }
}

const char *gfx_qr(const char *value)
{
#ifndef	CONFIG_GFX_NONE
   uint32_t width = 0;
 uint8_t *qr = qr_encode(strlen(value), value, widthp: &width, noquiet:1);
   if (!qr)
      return "Failed to encode";
   if (!width || width > CONFIG_GFX_WIDTH)
   {
      free(qr);
      return "Too wide";
   }
   gfx_lock();
   gfx_clear(0);
#if CONFIG_GFX_WIDTH > CONFIG_GFX_HEIGH
   const int w = CONFIG_GFX_HEIGHT;
#else
   const int w = CONFIG_GFX_WIDTH;
#endif
   int s = w / width;
   int ox = (CONFIG_GFX_WIDTH - width * s) / 2;
   int oy = (CONFIG_GFX_HEIGHT - width * s) / 2;
   for (int y = 0; y < width; y++)
      for (int x = 0; x < width; x++)
         if (qr[width * y + x] & QR_TAG_BLACK)
            for (int dy = 0; dy < s; dy++)
               for (int dx = 0; dx < s; dx++)
                  gfx_pixel(ox + x * s + dx, oy + y * s + dy, 0xFF);
   gfx_unlock();
   free(qr);
#endif
   return NULL;
}

char *setdefcon(int level, char *value)
{                               // DEFCON state
   // With value it is used to turn on/off a defcon state, the lowest set dictates the defcon level
   // With no value, this sets the DEFCON state directly instead of using lowest of state set
   static uint8_t state = 0;    // DEFCON state
   if (*value)
   {
      if (*value == '1' || *value == 't' || *value == 'y')
         state |= (1 << level);
      else
         state &= ~(1 << level);
      int l;
      for (l = 0; l < 8 && !(state & (1 << l)); l++);
      defcon_level = l;
   } else
      defcon_level = level;
   return "";
}

const char *app_callback(int client, const char *prefix, const char *target, const char *suffix, jo_t j)
{
   char value[1000];
   int len = 0;
   *value = 0;
   if (j)
   {
      len = jo_strncpy(j, value, sizeof(value));
      if (len < 0)
         return "Expecting JSON string";
      if (len > sizeof(value))
         return "Too long";
   }
   if (defcon && prefix && !strcmp(prefix, "DEFCON") && target && isdigit(*target) && !target[1])
      return setdefcon(*target - '0', value);
   if (client || !prefix || target || strcmp(prefix, prefixcommand) || !suffix)
      return NULL;              //Not for us or not a command from main MQTT
   if (defcon && isdigit(*suffix) && !suffix[1])
      return setdefcon(*suffix - '0', value);
   if (!strcmp(suffix, "connect"))
   {
      if (defcon)
         lwmqtt_subscribe(revk_mqtt(0), "DEFCON/#");

   }
   if (!strcmp(suffix, "shutdown"))
      httpd_stop(webserver);
   if (!strcmp(suffix, "upgrade") || !strcmp(suffix, "wait"))
   {
      busy = esp_timer_get_time() + 60000000ULL;
      return "";
   }
   if (!strcmp(suffix, "sleep"))
   {
      busy = 0;
      return "";
   }
   if (!strcmp(suffix, "qr"))
   {
      return gfx_qr(value) ? : "";
   }
   if (!strcmp(suffix, "message"))
   {
      gfx_message(value);
      return "";
   }
   if (!strncmp(suffix, "output", 6))
   {
      int i = atoi(suffix + 6);
      if (i < 0 || i >= MAXGPIO)
         return "Bad output number";
      if (!output[i])
         return "Output not configured";
      int c = atoi(value);
      if (!c && (*value == 't' || *value == 'y'))
         c = 1;
      if (c)
      {
         if (!outputcount[i])
         {                      // On
            outputcount[i] = c;
            outputbits |= (1ULL << i);
         }
      } else
      {                         // Off
         outputcount[i] = 0;
         outputbits &= ~(1ULL << i);
      }
      return "";
   }
   if (!strncmp(suffix, "pwm", 3))
   {
      int i = atoi(suffix + 3);
      if (i < 0 || i >= MAXGPIO)
         return "Bad output number";
      if (!output[i])
         return "Output not configured";
      int p = port_mask(output[i]);
      int freq = atoi(value);
      if (!freq)
      {
         gpio_reset_pin(p);
         REVK_ERR_CHECK(gpio_set_direction(p, GPIO_MODE_OUTPUT));
         outputcount[i] = 0;
         outputraw |= (1ULL << i);
         outputbits &= ~(1ULL << i);
         outputoverride &= ~(1ULL << i);
         return "";
      }
      outputoverride |= (1ULL << i);
      ledc_timer_config_t t = {
         .duty_resolution = 8,
         .timer_num = i,
         .freq_hz = freq,
      };
      REVK_ERR_CHECK(ledc_timer_config(&t));
      ledc_channel_config_t c = {
         .gpio_num = p,
         .channel = i,
         .timer_sel = i,
         .duty = 128,
      };
      REVK_ERR_CHECK(ledc_channel_config(&c));
      return "";
   }
   return NULL;
}

// --------------------------------------------------------------------------------
// Web
#ifdef	CONFIG_REVK_APCONFIG
#error 	Clash with CONFIG_REVK_APCONFIG set
#endif
static esp_err_t web_root(httpd_req_t * req)
{
   if (revk_link_down())
      return revk_web_config(req);      // Direct to web set up
   httpd_resp_sendstr_chunk(req, "<meta name='viewport' content='width=device-width, initial-scale=1'>");
   httpd_resp_sendstr_chunk(req, "<html><body style='font-family:sans-serif;background:#8cf;'><h1>");
   httpd_resp_sendstr_chunk(req, appname);
   httpd_resp_sendstr_chunk(req, "</h1>");
   httpd_resp_sendstr_chunk(req, NULL);
   return ESP_OK;
}

void app_main()
{
   time_t now = time(0);
   revk_boot(&app_callback);
   revk_register("input", MAXGPIO, sizeof(*input), &input, BITFIELDS, SETTING_BITFIELD | SETTING_SET);
   revk_register("output", MAXGPIO, sizeof(*output), &output, BITFIELDS, SETTING_BITFIELD | SETTING_SET | SETTING_SECRET);
   revk_register("outputgpio", MAXGPIO, sizeof(*output), &output, BITFIELDS, SETTING_BITFIELD | SETTING_SET);
   revk_register("outputmark", MAXGPIO, sizeof(*outputmark), &outputmark, NULL, SETTING_LIVE);
   revk_register("outputspace", MAXGPIO, sizeof(*outputspace), &outputspace, NULL, SETTING_LIVE);
   revk_register("power", MAXGPIO, sizeof(*power), &power, BITFIELDS, SETTING_BITFIELD | SETTING_SET);
   revk_register("ranger", 0, sizeof(ranger0x), &ranger0x, NULL, SETTING_BOOLEAN | SETTING_SECRET);     // Header
   revk_register("gfx", 0, sizeof(gfxcs), &gfxcs, "- ", SETTING_SET | SETTING_BITFIELD | SETTING_SECRET);       // Header
#define io(n,d)           revk_register(#n,0,sizeof(n),&n,"- "#d,SETTING_SET|SETTING_BITFIELD);
#define b(n) revk_register(#n,0,sizeof(n),&n,NULL,SETTING_BOOLEAN);
#define u32(n,d) revk_register(#n,0,sizeof(n),&n,#d,0);
#define s8(n,d) revk_register(#n,0,sizeof(n),&n,#d,SETTING_SIGNED);
#define u8(n,d) revk_register(#n,0,sizeof(n),&n,#d,0);
#define s(n) revk_register(#n,0,0,&n,NULL,0);
   settings
#undef io
#undef u32
#undef s8
#undef u8
#undef b
#undef s
       revk_start();

   // Web interface
   httpd_config_t config = HTTPD_DEFAULT_CONFIG();
   if (!httpd_start(&webserver, &config))
   {
      {
         httpd_uri_t uri = {
            .uri = "/",
            .method = HTTP_GET,
            .handler = web_root,
            .user_ctx = NULL
         };
         REVK_ERR_CHECK(httpd_register_uri_handler(webserver, &uri));
      }
      {
         httpd_uri_t uri = {
            .uri = "/wifi",
            .method = HTTP_GET,
            .handler = revk_web_config,
            .user_ctx = NULL
         };
         REVK_ERR_CHECK(httpd_register_uri_handler(webserver, &uri));
      }
      revk_web_config_start(webserver);
   }
   if (gfxmosi || gfxdc || gfxsck)
   {
    const char *e = gfx_init(port: HSPI_HOST, cs: port_mask(gfxcs), sck: port_mask(gfxsck), mosi: port_mask(gfxmosi), dc: port_mask(gfxdc), rst: port_mask(gfxrst), busy: port_mask(gfxbusy), ena: port_mask(gfxena), flip:gfxflip);
      if (e)
      {
         ESP_LOGE(TAG, "gfx %s", e);
         jo_t j = jo_object_alloc();
         jo_string(j, "error", "Failed to start");
         jo_string(j, "description", e);
         revk_error("gfx", &j);
      } else
         gfx_qr("HTTPS://GENERIC.REVK.UK");
   }
   {
    gpio_config_t c = { mode:GPIO_MODE_OUTPUT };
      for (int i = 0; i < MAXGPIO; i++)
      {
         if (input[i])
         {
            int p = port_mask(input[i]);
            //REVK_ERR_CHECK(gpio_hold_dis(p));
            REVK_ERR_CHECK(gpio_reset_pin(p));
            REVK_ERR_CHECK(gpio_set_direction(p, GPIO_MODE_INPUT));
         }
         if (output[i])
         {
            int p = port_mask(output[i]);
            c.pin_bit_mask |= (1ULL << p);
            REVK_ERR_CHECK(gpio_set_level(p, (output[i] & PORT_INV) ? 1 : 0));
            holding++;
         }
         if (power[i])
         {
            int p = port_mask(power[i]);
            c.pin_bit_mask |= (1ULL << p);
            //REVK_ERR_CHECK(gpio_hold_dis(p));
            REVK_ERR_CHECK(gpio_set_level(p, (power[i] & PORT_INV) ? 0 : 1));
            REVK_ERR_CHECK(gpio_set_drive_capability(p, GPIO_DRIVE_CAP_3));

            holding++;
         }
      }
      if (c.pin_bit_mask)
         REVK_ERR_CHECK(gpio_config(&c));
   }
   if (esp_reset_reason() != ESP_RST_DEEPSLEEP && awake < 60)
      awake = 60;
   if (period)
      ESP_LOGI(TAG, "Start %ld", now % period);
   if (usb)
   {
      gpio_reset_pin(port_mask(usb));
      gpio_set_pull_mode(port_mask(usb), GPIO_PULLDOWN_ONLY);
      gpio_set_direction(port_mask(usb), GPIO_MODE_INPUT);
      usleep(1000);
      if (gpio_get_level(port_mask(usb)) == ((usb & PORT_INV) ? 0 : 1))
      {
         gpio_set_pull_mode(port_mask(usb), GPIO_PULLUP_ONLY);
         ESP_LOGI(TAG, "USB found");
         usb_present = 1;
         if (awake < 60)
            awake = 60;
      } else if (period)
      {
         esp_log_level_set("*", ESP_LOG_NONE);  /* no debug */
         gpio_reset_pin(1);
         gpio_set_pull_mode(1, GPIO_PULLDOWN_ONLY);
      }
   }
   if (charger)
   {
      gpio_reset_pin(port_mask(charger));
      gpio_set_pull_mode(port_mask(charger), GPIO_PULLDOWN_ONLY);
      gpio_set_direction(port_mask(charger), GPIO_MODE_INPUT);
      usleep(1000);
      if (gpio_get_level(port_mask(charger)) == ((charger & PORT_INV) ? 0 : 1))
      {
         gpio_set_pull_mode(port_mask(charger), GPIO_PULLUP_ONLY);
         ESP_LOGI(TAG, "Charger found");
         charger_present = 1;
         if (period)
         {
            esp_log_level_set("*", ESP_LOG_NONE);       /* no debug */
            gpio_reset_pin(1);
            gpio_set_pull_mode(1, GPIO_PULLDOWN_ONLY);
         }
         busy = 0;
         //No point waiting, powered via USB port
      }
   }
   if (adcon)
   {
      REVK_ERR_CHECK(gpio_reset_pin(port_mask(adcon)));
      REVK_ERR_CHECK(gpio_set_level(port_mask(adcon), (adcon & PORT_INV) ? 0 : 1));     /* on */
      REVK_ERR_CHECK(gpio_set_direction(port_mask(adcon), GPIO_MODE_OUTPUT));

      esp_adc_cal_characteristics_t adc_chars = { 0 };
      esp_adc_cal_characterize(ADC_UNIT_1, ADC_ATTEN_DB_11, ADC_WIDTH_BIT_12, 1100, &adc_chars);
      REVK_ERR_CHECK(adc1_config_width(ADC_WIDTH_BIT_12));
      REVK_ERR_CHECK(adc1_config_channel_atten(adc, ADC_ATTEN_DB_11));
#define TRIES 100
      voltage = 0;
      for (int try = 0; try < TRIES; try++)
      {
         uint32_t v = 0;
         REVK_ERR_CHECK(esp_adc_cal_get_voltage(adc, &adc_chars, &v));
         if (adcr2)
            v = v * (adcr1 + adcr2) / adcr2;
         voltage += v;
      }
      voltage /= TRIES;
      if (!usb_present)
         gpio_set_level(port_mask(adcon), (adcon & PORT_INV) ? 1 : 0);  /* off */
   }
   if (rangergnd)
   {
      gpio_reset_pin(port_mask(rangergnd));
      gpio_set_level(port_mask(rangergnd), (rangergnd & PORT_INV) ? 1 : 0);     /* gnd */
      gpio_set_direction(port_mask(rangergnd), GPIO_MODE_OUTPUT);
   }
   if (rangerpwr)
   {
      gpio_reset_pin(port_mask(rangerpwr));
      gpio_set_level(port_mask(rangerpwr), (rangerpwr & PORT_INV) ? 0 : 1);     /* pwr */
      gpio_set_direction(port_mask(rangerpwr), GPIO_MODE_OUTPUT);
   }
   if (rangersda && rangerscl)
   {
      ESP_LOGI(TAG, "Ranger init GND=%d PWR=%d SCL=%d SDA=%d Address=%02X", port_mask(rangergnd), port_mask(rangerpwr), port_mask(rangerscl), port_mask(rangersda), rangeraddress);
      if (ranger0x)
      {
         vl53l0x_t *v = vl53l0x_config(0, port_mask(rangerscl), port_mask(rangersda), -1, rangeraddress, 0);
         if (!v)
            ESP_LOGE(TAG, "Ranger config failed");
         else
         {
            rangererr = vl53l0x_init(v);
            if (rangererr)
               ESP_LOGE(TAG, "Ranger error:%s", rangererr);
            else
            {
               range = vl53l0x_readRangeSingleMillimeters(v);
               ESP_LOGI(TAG, "Range=%d", range);
            }
         }
      } else
      {                         /* Try 1X */
         vl53l1x_t *v = vl53l1x_config(0, port_mask(rangerscl), port_mask(rangersda), -1, rangeraddress, 0);
         if (!v)
            ESP_LOGE(TAG, "Ranger config failed");
         else
         {
            rangererr = vl53l1x_init(v);
            if (rangererr)
               ESP_LOGE(TAG, "Ranger error:%s", rangererr);
            else
            {
               range = vl53l1x_readSingle(v, true);
               ESP_LOGI(TAG, "Range=%d", range);
            }
         }
      }
   }
   revk_task("input", input_task, 0);
   revk_task("output", output_task, 0);
   if (defcon)
      revk_task("defcon", defcon_task, 0);
   if (!revk_wait_wifi(10))
   {
      ESP_LOGE(TAG, "No WiFi");
      if (awake < 60)
         awake = 60;
   } else if (!revk_wait_mqtt(2))
      ESP_LOGE(TAG, "No MQTT");
   else
   {
      if (now < 30)
      {                         /* wait clock set */
         ESP_LOGI(TAG, "Wait clock set");
         while ((now = time(0)) < 30)
            sleep(1);
      }
      int64_t run = esp_timer_get_time();
      struct tm tm;
      gmtime_r(&now, &tm);
      if (!tm.tm_hour && !tm.tm_min && awake < 10)
         awake = 10;            /* allow clock to set */
      jo_t j = jo_object_alloc();
      jo_string(j, "id", revk_id);
      jo_stringf(j, "ts", "%04d-%02d-%02dT%02d:%02d:%02dZ", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
      jo_litf(j, "runtime", "%u.%06u", (int) run / 1000000, (int) run % 1000000);
      if (range)
         jo_litf(j, "range", "%d", range);
      if (voltage)
         jo_litf(j, "voltage", "%u.%03u", voltage / 1000, voltage % 1000);
      if (charger_present)
         jo_bool(j, "charger", 1);
      else if (usb_present)
         jo_bool(j, "usb", 1);
      int i;
      for (i = 0; i < MAXGPIO && !input[i]; i++);
      if (i < MAXGPIO)
      {
         jo_array(j, "input");
         for (i = 0; i < MAXGPIO; i++)
            jo_bool(j, NULL, (gpio_get_level(port_mask(input[i])) ^ ((input[i] ^ PORT_INV) ? 1 : 0)));
         jo_close(j);
      }
      revk_info(NULL, &j);
   }

   if (uart1rx)
      revk_task("uart1", uart_task, &uart1rx);
   if (uart2rx)
      revk_task("uart2", uart_task, &uart2rx);
   if (*sekey && sesite)
      revk_task("solaredge", se_task, 0);

   if (!period)
   {
      //We run forever, not sleeping
      ESP_LOGE(TAG, "Idle");
      while (1)
         sleep(1);
      return;
   }
   // Sleepy stuff
   if (!busy)
   {
      ESP_LOGI(TAG, "Wait for %d", awake);      /* wait a bit */
      if (awake)
         sleep(awake);
      else
         usleep(50000);         /* just long enough ? */
   }
   if (busy)
   {
      ESP_LOGI(TAG, "Waiting %d", (int) ((busy - esp_timer_get_time()) / 1000000ULL));
      while (busy > esp_timer_get_time())
         sleep(1);
   }
   time_t next = (time(0) + 5) / period * period + period;
   {
      char reason[100];
      struct tm tm;
      gmtime_r(&next, &tm);
      sprintf(reason, "Sleep after %lldms until %04d-%02d-%02dT%02d:%02d:%02dZ", esp_timer_get_time() / 1000, tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
      revk_mqtt_close(reason);
      revk_wifi_close();
      if (holding)
         gpio_deep_sleep_hold_en();
      else
         gpio_deep_sleep_hold_dis();
      esp_sleep_config_gpio_isolate();
      ESP_LOGI(TAG, "%s", reason);
   }
   if (usb_present && !charger_present)
      sleep(1);
   struct timeval tv;
   gettimeofday(&tv, NULL);
   if (next < tv.tv_sec + 1)
      next = tv.tv_sec + 1;
   esp_deep_sleep(((uint64_t) next - tv.tv_sec - 1) * 1000000LL + 1000000LL - tv.tv_usec);

   /* Should not get here */
   ESP_LOGE(TAG, "Still awake!");
   while (1)
      sleep(1);
}
