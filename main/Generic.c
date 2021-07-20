/* Generic app */
/* Copyright �2019 - 21 Adrian Kennard, Andrews & Arnold Ltd.See LICENCE file for details .GPL 3.0 */

static const char TAG[] = "Generic";

#include "revk.h"
#include "esp_sleep.h"
#include "esp_task_wdt.h"
#include "vl53l0x.h"
#include "vl53l1x.h"
#include <driver/gpio.h>
#include <driver/uart.h>
#include "driver/adc.h"
#include "esp_adc_cal.h"

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
static uint8_t  input[MAXGPIO];
static uint8_t  output[MAXGPIO];
static uint8_t  power[MAXGPIO]; /* fixed outputs */
int             holding = 0;

#define	settings		\
	u32(period,3600)	\
	u32(awake,0)	\
	io(usb,22)	\
	io(charger,23)	\
	io(led,-25)	\
	io(adcon,32)	\
	u8(adc,5)		\
	u32(adcr1,18000)	\
	u32(adcr2,1000)	\
	b(ranger0x)	\
	io(rangergnd,)	\
	io(rangerpwr,)	\
	io(rangerscl,)	\
	io(rangersda,)	\
        u8(rangeraddress,0x29)  \

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
char            usb_present = 0;
char            charger_present = 0;
const char     *rangererr = NULL;
uint16_t        range = 0;
uint32_t        voltage = 0;

const char     *
app_callback(int client, const char *prefix, const char *target, const char *suffix, jo_t j)
{
   if (client || !prefix || target || strcmp(prefix, prefixcommand) || !suffix)
      return NULL;
   //Not for us
      or not a command from main MQTT
         char            value[100];
   int             len = 0;
   if (j)
   {
      len = jo_strncpy(j, value, sizeof(value));
      if (len < 0)
         return "Expecting JSON string";
      if (len > sizeof(value))
         return "Too long";
   }
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
   if (!strncmp(suffix, "output", 6))
   {
      int             i = atoi(suffix + 6);
      if (i < 0 || i >= MAXGPIO)
         return "Bad output number";
      if (!output[i])
         return "Output not configured";
      int             v = 0;
      if (len && (*value == '1' || *value == 't' || *value == 'T' || *value == 'y' || *value == 'Y'))
         v = 1;
      int             p = output[i] & 0x3F;
      REVK_ERR_CHECK(gpio_hold_dis(p));
      REVK_ERR_CHECK(gpio_set_level(p, ((output[i] & 0x40) ? 1 : 0) ^ v));
      REVK_ERR_CHECK(gpio_hold_en(p));
      return "";
   }
   return NULL;
}

void
app_main()
{
   time_t          now = time(0);
   revk_boot(&app_callback);
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
      revk_register("input", MAXGPIO, sizeof(*input), &input, "-", SETTING_BITFIELD | SETTING_SET);
   revk_register("output", MAXGPIO, sizeof(*output), &output, "-", SETTING_BITFIELD | SETTING_SET);
   revk_register("power", MAXGPIO, sizeof(*power), &power, "-", SETTING_BITFIELD | SETTING_SET);
   revk_start();
   int             i;
   for (i = 0; i < MAXGPIO; i++)
   {
      if (input[i])
      {
         int             p = input[i] & 0x3F;
         REVK_ERR_CHECK(gpio_hold_dis(p));
         REVK_ERR_CHECK(gpio_reset_pin(p));
         REVK_ERR_CHECK(gpio_set_direction(p, GPIO_MODE_INPUT));
      }
      if (output[i])
      {
         int             p = output[i] & 0x3F;
         REVK_ERR_CHECK(gpio_reset_pin(p));
         REVK_ERR_CHECK(gpio_set_level(p, (output[i] & 0x40) ? 1 : 0)); /* Off */
         REVK_ERR_CHECK(gpio_set_direction(p, GPIO_MODE_OUTPUT));
         REVK_ERR_CHECK(gpio_hold_en(p));
         holding++;
      }
      if (power[i])
      {
         int             p = power[i] & 0x3F;
         REVK_ERR_CHECK(gpio_reset_pin(p));
         REVK_ERR_CHECK(gpio_set_level(p, (power[i] & 0x40) ? 0 : 1));
         REVK_ERR_CHECK(gpio_set_drive_capability(p, GPIO_DRIVE_CAP_3));
         REVK_ERR_CHECK(gpio_set_direction(p, GPIO_MODE_OUTPUT));
         REVK_ERR_CHECK(gpio_hold_en(p));
         holding++;
      }
   }
   if (!period)
      period = 60;              /* avoid divide by zero */
   if (esp_reset_reason() != ESP_RST_DEEPSLEEP && awake < 60)
      awake = 60;
   //Power up
      ESP_LOGI(TAG, "Start %ld", now % period);
   if (usb)
   {
      gpio_reset_pin(usb & 0x3F);
      gpio_set_pull_mode(usb & 0x3F, GPIO_PULLDOWN_ONLY);
      gpio_set_direction(usb & 0x3F, GPIO_MODE_INPUT);
      usleep(1000);
      if (gpio_get_level(usb & 0x3F) == ((usb & 0x40) ? 0 : 1))
      {
         gpio_set_pull_mode(usb & 0x3F, GPIO_PULLUP_ONLY);
         ESP_LOGI(TAG, "USB found");
         usb_present = 1;
         if (awake < 60)
            awake = 60;
      } else
      {
         esp_log_level_set("*", ESP_LOG_NONE);  /* no debug */
         gpio_reset_pin(1);
         gpio_set_pull_mode(1, GPIO_PULLDOWN_ONLY);
      }
   }
   if (charger)
   {
      gpio_reset_pin(charger & 0x3F);
      gpio_set_pull_mode(charger & 0x3F, GPIO_PULLDOWN_ONLY);
      gpio_set_direction(charger & 0x3F, GPIO_MODE_INPUT);
      usleep(1000);
      if (gpio_get_level(charger & 0x3F) == ((charger & 0x40) ? 0 : 1))
      {
         gpio_set_pull_mode(charger & 0x3F, GPIO_PULLUP_ONLY);
         ESP_LOGI(TAG, "Charger found");
         charger_present = 1;
         esp_log_level_set("*", ESP_LOG_NONE);  /* no debug */
         gpio_reset_pin(1);
         gpio_set_pull_mode(1, GPIO_PULLDOWN_ONLY);
         busy = 0;
         //No point waiting, powered via USB port
      }
   }
   if (adcon)
   {
      REVK_ERR_CHECK(gpio_reset_pin(adcon & 0x3F));
      REVK_ERR_CHECK(gpio_set_level(adcon & 0x3F, (adcon & 0x40) ? 0 : 1));     /* on */
      REVK_ERR_CHECK(gpio_set_direction(adcon & 0x3F, GPIO_MODE_OUTPUT));

      esp_adc_cal_characteristics_t adc_chars = {0};
      esp_adc_cal_characterize(ADC_UNIT_1, ADC_ATTEN_DB_11, ADC_WIDTH_BIT_12, 1100, &adc_chars);
      REVK_ERR_CHECK(adc1_config_width(ADC_WIDTH_BIT_12));
      REVK_ERR_CHECK(adc1_config_channel_atten(adc, ADC_ATTEN_DB_11));
#define TRIES 100
      voltage = 0;
      for (int try = 0; try < TRIES; try++)
      {
         uint32_t        v = 0;
         REVK_ERR_CHECK(esp_adc_cal_get_voltage(adc, &adc_chars, &v));
         if (adcr2)
            v = v * (adcr1 + adcr2) / adcr2;
         voltage += v;
      }
      voltage /= TRIES;
      if (!usb_present)
         gpio_set_level(adcon & 0x3F, (adcon & 0x40) ? 1 : 0);  /* off */
   }
   if (led)
   {
      gpio_reset_pin(led & 0x3F);
      gpio_set_level(led & 0x3F, (led & 0x40) ? 0 : 1); /* on */
      gpio_set_direction(led & 0x3F, GPIO_MODE_OUTPUT);
   }
   if (rangergnd)
   {
      gpio_reset_pin(rangergnd & 0x3F);
      gpio_set_level(rangergnd & 0x3F, (rangergnd & 0x40) ? 1 : 0);     /* gnd */
      gpio_set_direction(rangergnd & 0x3F, GPIO_MODE_OUTPUT);
   }
   if (rangerpwr)
   {
      gpio_reset_pin(rangerpwr & 0x3F);
      gpio_set_level(rangerpwr & 0x3F, (rangerpwr & 0x40) ? 0 : 1);     /* pwr */
      gpio_set_direction(rangerpwr & 0x3F, GPIO_MODE_OUTPUT);
   }
   if (rangersda && rangerscl)
   {
      ESP_LOGI(TAG, "Ranger init GND=%d PWR=%d SCL=%d SDA=%d Address=%02X", rangergnd & 0x3F, rangerpwr & 0x3F, rangerscl & 0x3F, rangersda & 0x3F, rangeraddress);
      if (ranger0x)
      {
         vl53l0x_t      *v = vl53l0x_config(0, rangerscl & 0x3F, rangersda & 0x3F, -1, rangeraddress, 0);
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
         vl53l1x_t      *v = vl53l1x_config(0, rangerscl & 0x3F, rangersda & 0x3F, -1, rangeraddress, 0);
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
      int64_t         run = esp_timer_get_time();
      struct tm       tm;
      gmtime_r(&now, &tm);
      if (!tm.tm_hour && !tm.tm_min && awake < 10)
         awake = 10;            /* allow clock to set */
      jo_t            j = jo_create_alloc();
      jo_object(j, NULL);
      jo_string(j, "id", revk_id);
      jo_stringf(j, "ts", "%04d-%02d-%02dT%02d:%02d:%02dZ", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
      jo_litf(j, "runtime", "%u.%06u", (int)run / 1000000, (int)run % 1000000);
      if (range)
         jo_litf(j, "range", "%d", range);
      if (voltage)
         jo_litf(j, "voltage", "%u.%03u", voltage / 1000, voltage % 1000);
      if (charger_present)
         jo_bool(j, "charger", 1);
      else if (usb_present)
         jo_bool(j, "usb", 1);

      for (i = 0; i < MAXGPIO && !input[i]; i++);
      if (i < MAXGPIO)
      {
         jo_array(j, "input");
         for (i = 0; i < MAXGPIO; i++)
            jo_bool(j, NULL, (gpio_get_level(input[i] & 0x3F) ^ ((input[i] ^ 0x40) ? 1 : 0)));
         jo_close(j);
      }
      revk_info(NULL, &j);
   }
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
      ESP_LOGI(TAG, "Waiting %d", (int)((busy - esp_timer_get_time()) / 1000000ULL));
      while (busy > esp_timer_get_time())
      {
         if (led)
            gpio_set_level(led & 0x3F, (led & 0x40) ? 0 : 1);   /* on */
         usleep(500000);
         if (led)
            gpio_set_level(led & 0x3F, (led & 0x40) ? 1 : 0);   /* Off */
         usleep(500000);
      }
   }
   if (led)
      gpio_set_level(led & 0x3F, (led & 0x40) ? 1 : 0); /* Off */
   time_t          next = (time(0) + 5) / period * period + period;
   {
      char            reason[100];
      struct tm       tm;
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
   struct timeval  tv;
   gettimeofday(&tv, NULL);
   if (next < tv.tv_sec + 1)
      next = tv.tv_sec + 1;
   esp_deep_sleep(((uint64_t) next - tv.tv_sec - 1) * 1000000LL + 1000000LL - tv.tv_usec);

   /* Should not get here */
   ESP_LOGE(TAG, "Still awake!");
   while (1)
      sleep(1);
}
