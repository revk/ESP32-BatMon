EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Generic ESP32 (battery operation)"
Date "2021-05-22"
Rev "2"
Comp ""
Comment1 "@TheRealRevK"
Comment2 "www.me.uk"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 J2
U 1 1 60436927
P 6500 1900
F 0 "J2" H 6607 2767 50  0000 C CNN
F 1 "USB-C" H 6607 2676 50  0000 C CNN
F 2 "RevK:USC16-TR-Round" H 6650 1900 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 6650 1900 50  0001 C CNN
	1    6500 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 6043A8AD
P 7350 1500
F 0 "R7" V 7557 1500 50  0000 C CNN
F 1 "5K1" V 7466 1500 50  0000 C CNN
F 2 "RevK:R_0603" V 7280 1500 50  0001 C CNN
F 3 "~" H 7350 1500 50  0001 C CNN
	1    7350 1500
	0    -1   -1   0   
$EndComp
Text GLabel 3550 2050 2    50   Input ~ 0
I
Text GLabel 8250 1800 2    50   Input ~ 0
D-
Text GLabel 8250 2000 2    50   Input ~ 0
D+
Wire Wire Line
	6200 2800 6500 2800
Connection ~ 6500 2800
Wire Wire Line
	7100 2100 7100 2000
Connection ~ 7100 2000
Wire Wire Line
	7100 1900 7100 1800
Connection ~ 7100 1800
Wire Wire Line
	7100 1300 7700 1300
Wire Wire Line
	7100 1500 7200 1500
Wire Wire Line
	7100 1600 7200 1600
Wire Wire Line
	7500 1500 7500 1550
Wire Wire Line
	7700 1550 7500 1550
Connection ~ 7500 1550
Wire Wire Line
	7500 1550 7500 1600
Text GLabel 6300 4750 0    50   Input ~ 0
D+
Text GLabel 6300 4650 0    50   Input ~ 0
D-
Wire Wire Line
	6300 4750 6400 4750
Wire Wire Line
	6400 4650 6300 4650
NoConn ~ 2350 2950
NoConn ~ 2350 3050
NoConn ~ 2350 3150
NoConn ~ 2350 3250
NoConn ~ 2350 3350
NoConn ~ 2350 3450
$Comp
L Device:R R8
U 1 1 6049A32B
P 7350 1600
F 0 "R8" V 7450 1600 50  0000 C CNN
F 1 "5K1" V 7550 1600 50  0000 C CNN
F 2 "RevK:R_0603" V 7280 1600 50  0001 C CNN
F 3 "~" H 7350 1600 50  0001 C CNN
	1    7350 1600
	0    1    1    0   
$EndComp
NoConn ~ 7100 2400
NoConn ~ 7100 2500
Text GLabel 7800 4350 2    50   Input ~ 0
I
Text GLabel 7800 4450 2    50   Input ~ 0
O
Text GLabel 7800 4550 2    50   Input ~ 0
EN
NoConn ~ 3550 2950
NoConn ~ 3550 3050
NoConn ~ 3550 4050
$Comp
L power:VBUS #PWR05
U 1 1 60464020
P 7700 1300
F 0 "#PWR05" H 7700 1150 50  0001 C CNN
F 1 "VBUS" H 7715 1473 50  0000 C CNN
F 2 "" H 7700 1300 50  0001 C CNN
F 3 "" H 7700 1300 50  0001 C CNN
	1    7700 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 6046533F
P 3950 1550
F 0 "#PWR03" H 3950 1400 50  0001 C CNN
F 1 "+3.3V" H 3965 1723 50  0000 C CNN
F 2 "" H 3950 1550 50  0001 C CNN
F 3 "" H 3950 1550 50  0001 C CNN
	1    3950 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 6046CDD6
P 7700 1550
F 0 "#PWR06" H 7700 1300 50  0001 C CNN
F 1 "GND" H 7705 1377 50  0000 C CNN
F 2 "" H 7700 1550 50  0001 C CNN
F 3 "" H 7700 1550 50  0001 C CNN
	1    7700 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 6046DFEC
P 7750 2800
F 0 "#PWR07" H 7750 2550 50  0001 C CNN
F 1 "GND" H 7755 2627 50  0000 C CNN
F 2 "" H 7750 2800 50  0001 C CNN
F 3 "" H 7750 2800 50  0001 C CNN
	1    7750 2800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 6049A89B
P 2800 6300
F 0 "J1" H 2908 6681 50  0000 C CNN
F 1 "Connector" H 2908 6590 50  0000 C CNN
F 2 "RevK:Molex_MiniSPOX_H6RA_0.1" H 2800 6300 50  0001 C CNN
F 3 "~" H 2800 6300 50  0001 C CNN
	1    2800 6300
	1    0    0    -1  
$EndComp
Text GLabel 3550 2450 2    50   Input ~ 0
IO1
Text GLabel 3550 2650 2    50   Input ~ 0
IO2
Text GLabel 3550 1950 2    50   Input ~ 0
IO3
Text GLabel 3550 2550 2    50   Input ~ 0
IO4
Text GLabel 3550 2150 2    50   Input ~ 0
IO5
Text GLabel 4250 6200 2    50   Input ~ 0
IO1
Text GLabel 4250 6300 2    50   Input ~ 0
IO2
Text GLabel 4250 6400 2    50   Input ~ 0
IO3
Text GLabel 4250 6500 2    50   Input ~ 0
IO4
Text GLabel 4550 6600 2    50   Input ~ 0
IO5
$Comp
L Device:R R1
U 1 1 6043FFAD
P 3650 5850
F 0 "R1" H 3700 5650 50  0000 R CNN
F 1 "NF" V 3650 5900 50  0000 R CNN
F 2 "RevK:Pad_1206_0805_NF" V 3580 5850 50  0001 C CNN
F 3 "~" H 3650 5850 50  0001 C CNN
	1    3650 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 6043FFB3
P 3750 5850
F 0 "R2" H 3700 5650 50  0000 L CNN
F 1 "NF" V 3750 5800 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3680 5850 50  0001 C CNN
F 3 "~" H 3750 5850 50  0001 C CNN
	1    3750 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 6043FFB9
P 3850 5850
F 0 "R3" H 3800 5650 50  0000 L CNN
F 1 "NF" V 3850 5800 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3780 5850 50  0001 C CNN
F 3 "~" H 3850 5850 50  0001 C CNN
	1    3850 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6043FFBF
P 3950 5850
F 0 "R4" H 3900 5650 50  0000 L CNN
F 1 "NF" V 3950 5800 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3880 5850 50  0001 C CNN
F 3 "~" H 3950 5850 50  0001 C CNN
	1    3950 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 6043FFC5
P 4050 5850
F 0 "R5" H 4000 5650 50  0000 L CNN
F 1 "NF" V 4050 5800 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3980 5850 50  0001 C CNN
F 3 "~" H 4050 5850 50  0001 C CNN
	1    4050 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 5700 3750 5700
Wire Wire Line
	3850 5700 3750 5700
Connection ~ 3750 5700
Wire Wire Line
	3950 5700 3850 5700
Connection ~ 3850 5700
Wire Wire Line
	3750 5700 3750 5300
Wire Wire Line
	3650 6000 3650 6200
Wire Wire Line
	3650 6200 4250 6200
Wire Wire Line
	3750 6000 3750 6300
Wire Wire Line
	3750 6300 4250 6300
Wire Wire Line
	3850 6000 3850 6400
Connection ~ 3850 6400
Wire Wire Line
	3850 6400 4250 6400
Wire Wire Line
	3950 6000 3950 6500
Wire Wire Line
	3950 6500 4250 6500
Wire Wire Line
	4050 6000 4050 6600
Wire Wire Line
	4050 6600 4250 6600
Wire Wire Line
	3000 6400 3850 6400
Connection ~ 3650 6200
Wire Wire Line
	3000 6300 3750 6300
Connection ~ 3750 6300
Wire Wire Line
	3000 6500 3950 6500
Connection ~ 3950 6500
$Comp
L power:+3.3V #PWR02
U 1 1 604A10C5
P 3750 5300
F 0 "#PWR02" H 3750 5150 50  0001 C CNN
F 1 "+3.3V" H 3765 5473 50  0000 C CNN
F 2 "" H 3750 5300 50  0001 C CNN
F 3 "" H 3750 5300 50  0001 C CNN
	1    3750 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 60526275
P 3300 5900
F 0 "#PWR01" H 3300 5650 50  0001 C CNN
F 1 "GND" H 3305 5727 50  0000 C CNN
F 2 "" H 3300 5900 50  0001 C CNN
F 3 "" H 3300 5900 50  0001 C CNN
	1    3300 5900
	-1   0    0    1   
$EndComp
Wire Wire Line
	3000 6100 3150 6100
Wire Wire Line
	3150 6100 3150 5900
Wire Wire Line
	2950 1550 2950 1650
Wire Wire Line
	6500 2800 7750 2800
Wire Wire Line
	7100 1800 8250 1800
Wire Wire Line
	6000 4950 6000 4350
Wire Wire Line
	6000 4350 6400 4350
Wire Wire Line
	6000 4950 6400 4950
Wire Wire Line
	6400 4350 6400 3750
Wire Wire Line
	7200 4050 7200 3750
Wire Wire Line
	7200 3750 7750 3750
NoConn ~ 3550 2850
Wire Wire Line
	2950 1550 3950 1550
NoConn ~ 3550 3150
NoConn ~ 3550 3350
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 60460B50
P 9700 1200
F 0 "J3" H 9672 1082 50  0000 R CNN
F 1 "DC" H 9672 1173 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 9700 1200 50  0001 C CNN
F 3 "~" H 9700 1200 50  0001 C CNN
	1    9700 1200
	-1   0    0    -1  
$EndComp
NoConn ~ 3550 3950
Wire Wire Line
	7100 2000 8250 2000
$Comp
L Device:R R6
U 1 1 607317BC
P 4400 6600
F 0 "R6" V 4500 6600 50  0000 C CNN
F 1 "0R" V 4400 6600 50  0000 C CNN
F 2 "RevK:Pad_1206_0805_NF" V 4330 6600 50  0001 C CNN
F 3 "~" H 4400 6600 50  0001 C CNN
	1    4400 6600
	0    1    1    0   
$EndComp
$Comp
L Device:C C1
U 1 1 60734BE5
P 3300 6050
F 0 "C1" H 3300 5950 50  0000 L CNN
F 1 "NF" H 3250 6050 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" H 3338 5900 50  0001 C CNN
F 3 "~" H 3300 6050 50  0001 C CNN
	1    3300 6050
	1    0    0    -1  
$EndComp
Connection ~ 3300 5900
Connection ~ 3300 6200
Wire Wire Line
	3300 6200 3650 6200
Wire Wire Line
	3150 5900 3300 5900
Wire Wire Line
	3000 6200 3300 6200
Connection ~ 4050 6600
Wire Wire Line
	3000 6600 4050 6600
Text GLabel 4750 2700 2    50   Input ~ 0
GPIO0
NoConn ~ 3550 2250
NoConn ~ 3550 2350
NoConn ~ 3550 2750
$Comp
L Interface_USB:FT231XQ U2
U 1 1 60849D1E
P 7100 4950
F 0 "U2" H 7100 6031 50  0000 C CNN
F 1 "FT231XQ" H 7100 5940 50  0000 C CNN
F 2 "RevK:QFN-20-(hand)-1EP_4x4mm_P0.5mm_EP2.5x2.5mm" H 8450 4150 50  0001 C CNN
F 3 "https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT231X.pdf" H 7100 4950 50  0001 C CNN
	1    7100 4950
	1    0    0    -1  
$EndComp
Connection ~ 6400 4350
Text GLabel 7800 4750 2    50   Input ~ 0
GPIO0
$Comp
L power:GND #PWR0102
U 1 1 6084D835
P 7800 4650
F 0 "#PWR0102" H 7800 4400 50  0001 C CNN
F 1 "GND" V 7805 4522 50  0000 R CNN
F 2 "" H 7800 4650 50  0001 C CNN
F 3 "" H 7800 4650 50  0001 C CNN
	1    7800 4650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 6084DCBB
P 7800 4850
F 0 "#PWR0103" H 7800 4600 50  0001 C CNN
F 1 "GND" V 7805 4722 50  0000 R CNN
F 2 "" H 7800 4850 50  0001 C CNN
F 3 "" H 7800 4850 50  0001 C CNN
	1    7800 4850
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 6084E14D
P 7800 4950
F 0 "#PWR0104" H 7800 4700 50  0001 C CNN
F 1 "GND" V 7805 4822 50  0000 R CNN
F 2 "" H 7800 4950 50  0001 C CNN
F 3 "" H 7800 4950 50  0001 C CNN
	1    7800 4950
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 6084E5CB
P 7800 5050
F 0 "#PWR0105" H 7800 4800 50  0001 C CNN
F 1 "GND" V 7805 4922 50  0000 R CNN
F 2 "" H 7800 5050 50  0001 C CNN
F 3 "" H 7800 5050 50  0001 C CNN
	1    7800 5050
	0    -1   -1   0   
$EndComp
NoConn ~ 7800 5350
NoConn ~ 7800 5450
NoConn ~ 7800 5550
$Comp
L power:GND #PWR0106
U 1 1 608547A1
P 7100 5850
F 0 "#PWR0106" H 7100 5600 50  0001 C CNN
F 1 "GND" H 7105 5677 50  0000 C CNN
F 2 "" H 7100 5850 50  0001 C CNN
F 3 "" H 7100 5850 50  0001 C CNN
	1    7100 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 5850 7100 5850
Connection ~ 7100 5850
Wire Wire Line
	7100 5850 7200 5850
$Comp
L RevK:Regulator Reg1
U 1 1 608EC192
P 9550 1600
F 0 "Reg1" H 10128 1501 50  0000 L CNN
F 1 "Regulator" H 10128 1410 50  0000 L CNN
F 2 "RevK:RegulatorBlock" H 10000 1700 50  0001 C CNN
F 3 "https://www.pololu.com/product/2842/resources" H 10000 1700 50  0001 C CNN
	1    9550 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 608EF177
P 9150 1800
F 0 "#PWR0109" H 9150 1550 50  0001 C CNN
F 1 "GND" V 9155 1672 50  0000 R CNN
F 2 "" H 9150 1800 50  0001 C CNN
F 3 "" H 9150 1800 50  0001 C CNN
	1    9150 1800
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0110
U 1 1 608EF736
P 9550 1900
F 0 "#PWR0110" H 9550 1750 50  0001 C CNN
F 1 "+3.3V" V 9565 2028 50  0000 L CNN
F 2 "" H 9550 1900 50  0001 C CNN
F 3 "" H 9550 1900 50  0001 C CNN
	1    9550 1900
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 608FDC75
P 3550 3550
F 0 "#PWR0111" H 3550 3300 50  0001 C CNN
F 1 "GND" V 3555 3422 50  0000 R CNN
F 2 "" H 3550 3550 50  0001 C CNN
F 3 "" H 3550 3550 50  0001 C CNN
	1    3550 3550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 608FE16D
P 3550 3650
F 0 "#PWR0112" H 3550 3400 50  0001 C CNN
F 1 "GND" V 3555 3522 50  0000 R CNN
F 2 "" H 3550 3650 50  0001 C CNN
F 3 "" H 3550 3650 50  0001 C CNN
	1    3550 3650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 608FEA23
P 2950 4350
F 0 "#PWR0113" H 2950 4100 50  0001 C CNN
F 1 "GND" H 2955 4177 50  0000 C CNN
F 2 "" H 2950 4350 50  0001 C CNN
F 3 "" H 2950 4350 50  0001 C CNN
	1    2950 4350
	1    0    0    -1  
$EndComp
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 6043326C
P 2950 2950
F 0 "U1" H 2950 4531 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 2950 4440 50  0000 C CNN
F 2 "RevK:ESP32-WROOM-32" H 2950 1450 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 2650 3000 50  0001 C CNN
	1    2950 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 608FF224
P 2350 2050
F 0 "#PWR0114" H 2350 1800 50  0001 C CNN
F 1 "GND" V 2355 1922 50  0000 R CNN
F 2 "" H 2350 2050 50  0001 C CNN
F 3 "" H 2350 2050 50  0001 C CNN
	1    2350 2050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 608FF6DE
P 2350 1950
F 0 "#PWR0115" H 2350 1700 50  0001 C CNN
F 1 "GND" V 2355 1822 50  0000 R CNN
F 2 "" H 2350 1950 50  0001 C CNN
F 3 "" H 2350 1950 50  0001 C CNN
	1    2350 1950
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 609259A6
P 6000 5100
F 0 "C2" H 6115 5146 50  0000 L CNN
F 1 "100nF" H 6115 5055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 6038 4950 50  0001 C CNN
F 3 "~" H 6000 5100 50  0001 C CNN
	1    6000 5100
	1    0    0    -1  
$EndComp
Connection ~ 6000 4950
$Comp
L power:GND #PWR0116
U 1 1 60926541
P 6000 5250
F 0 "#PWR0116" H 6000 5000 50  0001 C CNN
F 1 "GND" H 6005 5077 50  0000 C CNN
F 2 "" H 6000 5250 50  0001 C CNN
F 3 "" H 6000 5250 50  0001 C CNN
	1    6000 5250
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR0108
U 1 1 60A03A7F
P 7000 3450
F 0 "#PWR0108" H 7000 3300 50  0001 C CNN
F 1 "VBUS" H 7015 3623 50  0000 C CNN
F 2 "" H 7000 3450 50  0001 C CNN
F 3 "" H 7000 3450 50  0001 C CNN
	1    7000 3450
	1    0    0    -1  
$EndComp
Connection ~ 7200 3750
Wire Wire Line
	7000 3450 7000 4050
Wire Wire Line
	6400 3750 7200 3750
Wire Wire Line
	9500 1300 9300 1300
Wire Wire Line
	9300 1300 9300 1425
Wire Wire Line
	9300 1600 9550 1600
Wire Wire Line
	9300 1600 9300 1700
Wire Wire Line
	9300 1700 9550 1700
Connection ~ 9300 1600
Wire Wire Line
	9500 1200 9150 1200
Wire Wire Line
	9150 1200 9150 1800
Wire Wire Line
	9150 1800 9550 1800
Connection ~ 9150 1800
Text GLabel 7750 3750 2    50   Input ~ 0
USB3.3
Wire Wire Line
	1600 1750 2350 1750
$Comp
L Device:R R9
U 1 1 60A25F05
P 1600 1600
F 0 "R9" V 1807 1600 50  0000 C CNN
F 1 "10K" V 1716 1600 50  0000 C CNN
F 2 "RevK:R_0603" V 1530 1600 50  0001 C CNN
F 3 "~" H 1600 1600 50  0001 C CNN
	1    1600 1600
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR0117
U 1 1 60A276D4
P 1600 1450
F 0 "#PWR0117" H 1600 1300 50  0001 C CNN
F 1 "+3.3V" H 1615 1623 50  0000 C CNN
F 2 "" H 1600 1450 50  0001 C CNN
F 3 "" H 1600 1450 50  0001 C CNN
	1    1600 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 60A27EE2
P 1600 2150
F 0 "#PWR0118" H 1600 1900 50  0001 C CNN
F 1 "GND" H 1605 1977 50  0000 C CNN
F 2 "" H 1600 2150 50  0001 C CNN
F 3 "" H 1600 2150 50  0001 C CNN
	1    1600 2150
	1    0    0    -1  
$EndComp
Text GLabel 1200 1950 0    50   Input ~ 0
EN
Wire Wire Line
	3550 1750 4000 1750
Wire Wire Line
	4000 1750 4000 2400
Wire Wire Line
	4000 2400 4350 2400
Wire Wire Line
	4350 2400 4350 2500
$Comp
L power:GND #PWR0119
U 1 1 60A33C2A
P 4350 2900
F 0 "#PWR0119" H 4350 2650 50  0001 C CNN
F 1 "GND" H 4355 2727 50  0000 C CNN
F 2 "" H 4350 2900 50  0001 C CNN
F 3 "" H 4350 2900 50  0001 C CNN
	1    4350 2900
	1    0    0    -1  
$EndComp
Text Notes 6050 6250 0    50   ~ 0
Note that RTS and DTR need to be inverted in FT231X configuration
Text GLabel 7800 5250 2    50   Input ~ 0
CBUS
Text GLabel 3550 3250 2    50   Input ~ 0
CBUS
$Comp
L Device:LED D1
U 1 1 60A3EE9D
P 4150 3450
F 0 "D1" H 4143 3667 50  0000 C CNN
F 1 "LED" H 4143 3576 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4150 3450 50  0001 C CNN
F 3 "~" H 4150 3450 50  0001 C CNN
	1    4150 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 60A436C8
P 4450 3450
F 0 "R11" V 4657 3450 50  0000 C CNN
F 1 "680R" V 4566 3450 50  0000 C CNN
F 2 "RevK:R_0603" V 4380 3450 50  0001 C CNN
F 3 "~" H 4450 3450 50  0001 C CNN
	1    4450 3450
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0120
U 1 1 60A44FE5
P 4600 3450
F 0 "#PWR0120" H 4600 3300 50  0001 C CNN
F 1 "+3.3V" V 4615 3578 50  0000 L CNN
F 2 "" H 4600 3450 50  0001 C CNN
F 3 "" H 4600 3450 50  0001 C CNN
	1    4600 3450
	0    1    1    0   
$EndComp
Wire Wire Line
	3550 3450 4000 3450
$Comp
L Transistor_FET:2N7002 Q3
U 1 1 60A1A002
P 4450 4400
F 0 "Q3" H 4654 4446 50  0000 L CNN
F 1 "2N7002" H 4654 4355 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4650 4325 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 4450 4400 50  0001 L CNN
	1    4450 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 60A1CD4E
P 4550 4050
F 0 "R12" V 4757 4050 50  0000 C CNN
F 1 "18K" V 4666 4050 50  0000 C CNN
F 2 "RevK:R_0603" V 4480 4050 50  0001 C CNN
F 3 "~" H 4550 4050 50  0001 C CNN
	1    4550 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 60A21378
P 4550 4750
F 0 "R13" V 4757 4750 50  0000 C CNN
F 1 "1k" V 4666 4750 50  0000 C CNN
F 2 "RevK:R_0603" V 4480 4750 50  0001 C CNN
F 3 "~" H 4550 4750 50  0001 C CNN
	1    4550 4750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0121
U 1 1 60A22E69
P 4550 5000
F 0 "#PWR0121" H 4550 4750 50  0001 C CNN
F 1 "GND" H 4555 4827 50  0000 C CNN
F 2 "" H 4550 5000 50  0001 C CNN
F 3 "" H 4550 5000 50  0001 C CNN
	1    4550 5000
	1    0    0    -1  
$EndComp
Connection ~ 4550 4200
Text GLabel 4550 3900 1    50   Input ~ 0
DC
Text GLabel 9575 1425 2    50   Input ~ 0
DC
Wire Wire Line
	3550 3750 3900 3750
Wire Wire Line
	3550 3850 3775 3850
Wire Wire Line
	3775 3850 3775 4200
Wire Wire Line
	3775 4200 4550 4200
$Comp
L RevK:RN1701 Q1
U 1 1 60A739E6
P 1550 1950
F 0 "Q1" H 1691 1996 50  0000 L CNN
F 1 "RN1701" H 1691 1905 50  0000 L CNN
F 2 "RevK:USV-5" H 1550 1950 50  0001 C CNN
F 3 "~" H 1550 1950 50  0001 C CNN
	1    1550 1950
	1    0    0    -1  
$EndComp
Connection ~ 1600 1750
$Comp
L RevK:RN1701 Q1
U 2 1 60A78720
P 4400 2700
F 0 "Q1" H 4541 2746 50  0000 L CNN
F 1 "RN1701" H 4541 2655 50  0000 L CNN
F 2 "RevK:USV-5" H 4400 2700 50  0001 C CNN
F 3 "~" H 4400 2700 50  0001 C CNN
	2    4400 2700
	-1   0    0    -1  
$EndComp
Text GLabel 4050 5700 1    50   Input ~ 0
DC
Wire Wire Line
	9300 1425 9575 1425
Connection ~ 9300 1425
Wire Wire Line
	9300 1425 9300 1600
Wire Wire Line
	7700 1300 7900 1300
Connection ~ 7700 1300
$Comp
L Device:D D2
U 1 1 60A93E56
P 8050 1300
F 0 "D2" H 8050 1083 50  0000 C CNN
F 1 "D" H 8050 1174 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 8050 1300 50  0001 C CNN
F 3 "~" H 8050 1300 50  0001 C CNN
	1    8050 1300
	-1   0    0    1   
$EndComp
Text GLabel 8200 1300 2    50   Input ~ 0
DC
Text GLabel 3550 1850 2    50   Input ~ 0
O
$Comp
L Device:R R10
U 1 1 60A9502C
P 4250 4750
F 0 "R10" V 4475 4750 50  0000 C CNN
F 1 "10K" V 4375 4750 50  0000 C CNN
F 2 "RevK:R_0603" V 4180 4750 50  0001 C CNN
F 3 "~" H 4250 4750 50  0001 C CNN
	1    4250 4750
	-1   0    0    1   
$EndComp
Wire Wire Line
	3900 3750 3900 4400
Wire Wire Line
	4250 4400 3900 4400
Wire Wire Line
	4250 4400 4250 4600
Connection ~ 4250 4400
Wire Wire Line
	4250 4900 4550 4900
Wire Wire Line
	4550 5000 4550 4900
Connection ~ 4550 4900
$EndSCHEMATC
