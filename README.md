# ESP32-Generic board (USB-C)

Simple generic ESP32 based PCB deisgn, ideally suited for battery use.

This PCB design has a 6 pin connector (SPOX or 0.1" header) for 5 GPIO pins, USB-C for power and debug/serial, ADC connection to DC supply via potential divide and switched via a FET for low power working, LED. Can be powered by DC contacts or via 6 pin connector (4V-40V) or via USB. Works with esptool for flashing and debug via USB. GPIO pins with optional pull up or similar components. Includes RGB LED.

Typical use is with VL53L1X for ranging with PP3 9V battery.

![Battery](https://user-images.githubusercontent.com/996983/119488601-a9e11300-bd52-11eb-8f39-9f28214a056b.png)

# ESP32-Generic board (USB-A)

A very simple board with no GPIO, designed to fit a USB-A socket, incldues RGB LED and a button only.

![USBA](https://user-images.githubusercontent.com/996983/140615566-fc0d410a-a81b-4b3e-9b71-35afe68315ae.png)

Copyright © 2019-21 Adrian Kennard, Andrews & Arnold Ltd. See LICENCE file for details. GPL 3.0
