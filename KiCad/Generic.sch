EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Generic ESP32 (suitable for battery operation)"
Date "2021-07-20"
Rev "6"
Comp ""
Comment1 "@TheRealRevK"
Comment2 "www.me.uk"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 J2
U 1 1 60D24A36
P 6125 1600
F 0 "J2" H 6232 2467 50  0000 C CNN
F 1 "USB-C" H 6232 2376 50  0000 C CNN
F 2 "RevK:USC16-TR-Round" H 6275 1600 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 6275 1600 50  0001 C CNN
F 4 "Valcon" H 6125 1600 50  0001 C CNN "Manufacturer"
F 5 "CSP-USC16-TR" H 6125 1600 50  0001 C CNN "Part No"
F 6 "https://www.toby.co.uk/signal-to-board-connectors/usb-connectors/csp-usc16-tr-valcon-usb-type-c-surface-mount-pcb-socket/" H 6125 1600 50  0001 C CNN "Order URL"
	1    6125 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 6043A8AD
P 6975 1200
F 0 "R11" V 7050 1200 50  0000 C CNN
F 1 "5K1" V 6975 1200 50  0000 C CNN
F 2 "RevK:R_0603" V 6905 1200 50  0001 C CNN
F 3 "~" H 6975 1200 50  0001 C CNN
	1    6975 1200
	0    -1   -1   0   
$EndComp
Text GLabel 3175 1750 2    50   Input ~ 0
I
Text GLabel 7725 1600 2    50   BiDi ~ 0
D-
Text GLabel 7725 1700 2    50   BiDi ~ 0
D+
Wire Wire Line
	5825 2500 6125 2500
Connection ~ 6125 2500
Wire Wire Line
	6725 1800 6725 1700
Wire Wire Line
	6725 1000 7325 1000
Wire Wire Line
	6725 1200 6825 1200
Wire Wire Line
	6725 1300 6825 1300
Wire Wire Line
	7125 1200 7125 1250
Wire Wire Line
	7325 1250 7125 1250
Connection ~ 7125 1250
Wire Wire Line
	7125 1250 7125 1300
Text GLabel 5925 4450 0    50   BiDi ~ 0
D+
Text GLabel 5925 4350 0    50   BiDi ~ 0
D-
Wire Wire Line
	5925 4450 6025 4450
Wire Wire Line
	6025 4350 5925 4350
NoConn ~ 1975 2650
NoConn ~ 1975 2750
NoConn ~ 1975 2850
NoConn ~ 1975 2950
NoConn ~ 1975 3050
NoConn ~ 1975 3150
$Comp
L Device:R R12
U 1 1 6049A32B
P 6975 1300
F 0 "R12" V 7050 1300 50  0000 C CNN
F 1 "5K1" V 6975 1300 50  0000 C CNN
F 2 "RevK:R_0603" V 6905 1300 50  0001 C CNN
F 3 "~" H 6975 1300 50  0001 C CNN
	1    6975 1300
	0    1    1    0   
$EndComp
NoConn ~ 6725 2100
NoConn ~ 6725 2200
Text GLabel 7425 4050 2    50   Output ~ 0
I
Text GLabel 7425 4150 2    50   Input ~ 0
O
Text GLabel 7425 4250 2    50   Output ~ 0
EN
NoConn ~ 1975 1650
$Comp
L power:VBUS #PWR016
U 1 1 60464020
P 7325 1000
F 0 "#PWR016" H 7325 850 50  0001 C CNN
F 1 "VBUS" H 7340 1173 50  0000 C CNN
F 2 "" H 7325 1000 50  0001 C CNN
F 3 "" H 7325 1000 50  0001 C CNN
	1    7325 1000
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR010
U 1 1 6046533F
P 3575 1250
F 0 "#PWR010" H 3575 1100 50  0001 C CNN
F 1 "+3.3V" H 3590 1423 50  0000 C CNN
F 2 "" H 3575 1250 50  0001 C CNN
F 3 "" H 3575 1250 50  0001 C CNN
	1    3575 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6046CDD6
P 7325 1250
F 0 "#PWR017" H 7325 1000 50  0001 C CNN
F 1 "GND" H 7330 1077 50  0000 C CNN
F 2 "" H 7325 1250 50  0001 C CNN
F 3 "" H 7325 1250 50  0001 C CNN
	1    7325 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 6046DFEC
P 7375 2500
F 0 "#PWR018" H 7375 2250 50  0001 C CNN
F 1 "GND" H 7380 2327 50  0000 C CNN
F 2 "" H 7375 2500 50  0001 C CNN
F 3 "" H 7375 2500 50  0001 C CNN
	1    7375 2500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 60D24A3C
P 2425 6000
F 0 "J1" H 2533 6381 50  0000 C CNN
F 1 "Connector" H 2533 6290 50  0000 C CNN
F 2 "RevK:Molex_MiniSPOX_H6RA_0.1" H 2425 6000 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/276/0022057065_PCB_HEADERS-158483.pdf" H 2425 6000 50  0001 C CNN
F 4 "Molex" H 2425 6000 50  0001 C CNN "Manufacturer"
F 5 "0022057065" H 2425 6000 50  0001 C CNN "Part No"
F 6 "Not fitted" H 2425 6000 50  0001 C CNN "Notes"
	1    2425 6000
	1    0    0    -1  
$EndComp
Text GLabel 3175 2150 2    50   BiDi ~ 0
IO1
Text GLabel 3175 2350 2    50   BiDi ~ 0
IO2
Text GLabel 3175 1650 2    50   BiDi ~ 0
IO3
Text GLabel 3175 3350 2    50   BiDi ~ 0
IO4
Text GLabel 3175 1850 2    50   BiDi ~ 0
IO5
Text GLabel 3875 5900 2    50   BiDi ~ 0
IO1
Text GLabel 3875 6000 2    50   BiDi ~ 0
IO2
Text GLabel 3875 6100 2    50   BiDi ~ 0
IO3
Text GLabel 3875 6200 2    50   BiDi ~ 0
IO4
Text GLabel 4175 6300 2    50   BiDi ~ 0
IO5
$Comp
L Device:R R2
U 1 1 6043FFAD
P 3275 5550
F 0 "R2" H 3325 5350 50  0000 R CNN
F 1 "NF" V 3275 5600 50  0000 R CNN
F 2 "RevK:Pad_1206_0805_NF" V 3205 5550 50  0001 C CNN
F 3 "~" H 3275 5550 50  0001 C CNN
F 4 "Not fitted" H 3275 5550 50  0001 C CNN "Notes"
	1    3275 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 6043FFB3
P 3375 5550
F 0 "R3" H 3325 5350 50  0000 L CNN
F 1 "NF" V 3375 5500 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3305 5550 50  0001 C CNN
F 3 "~" H 3375 5550 50  0001 C CNN
F 4 "Not fitted" H 3375 5550 50  0001 C CNN "Notes"
	1    3375 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6043FFB9
P 3475 5550
F 0 "R4" H 3425 5350 50  0000 L CNN
F 1 "NF" V 3475 5500 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3405 5550 50  0001 C CNN
F 3 "~" H 3475 5550 50  0001 C CNN
F 4 "Not fitted" H 3475 5550 50  0001 C CNN "Notes"
	1    3475 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 60D24A3A
P 3575 5550
F 0 "R5" H 3525 5350 50  0000 L CNN
F 1 "NF" V 3575 5500 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3505 5550 50  0001 C CNN
F 3 "~" H 3575 5550 50  0001 C CNN
F 4 "Not fitted" H 3575 5550 50  0001 C CNN "Notes"
	1    3575 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 60D24A3B
P 3675 5550
F 0 "R6" H 3625 5350 50  0000 L CNN
F 1 "NF" V 3675 5500 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" V 3605 5550 50  0001 C CNN
F 3 "~" H 3675 5550 50  0001 C CNN
F 4 "Not fitted" H 3675 5550 50  0001 C CNN "Notes"
	1    3675 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3275 5400 3375 5400
Wire Wire Line
	3475 5400 3375 5400
Connection ~ 3375 5400
Wire Wire Line
	3575 5400 3475 5400
Connection ~ 3475 5400
Wire Wire Line
	3375 5400 3375 5000
Wire Wire Line
	3275 5700 3275 5900
Wire Wire Line
	3275 5900 3875 5900
Wire Wire Line
	3375 5700 3375 6000
Wire Wire Line
	3375 6000 3875 6000
Wire Wire Line
	3475 5700 3475 6100
Connection ~ 3475 6100
Wire Wire Line
	3475 6100 3875 6100
Wire Wire Line
	3575 5700 3575 6200
Wire Wire Line
	3575 6200 3875 6200
Wire Wire Line
	3675 5700 3675 6300
Wire Wire Line
	3675 6300 3875 6300
Wire Wire Line
	2625 6100 3475 6100
Connection ~ 3275 5900
Wire Wire Line
	2625 6000 3375 6000
Connection ~ 3375 6000
Wire Wire Line
	2625 6200 3575 6200
Connection ~ 3575 6200
$Comp
L power:+3.3V #PWR09
U 1 1 604A10C5
P 3375 5000
F 0 "#PWR09" H 3375 4850 50  0001 C CNN
F 1 "+3.3V" H 3390 5173 50  0000 C CNN
F 2 "" H 3375 5000 50  0001 C CNN
F 3 "" H 3375 5000 50  0001 C CNN
	1    3375 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 60D24A3E
P 2925 5600
F 0 "#PWR04" H 2925 5350 50  0001 C CNN
F 1 "GND" H 2930 5427 50  0000 C CNN
F 2 "" H 2925 5600 50  0001 C CNN
F 3 "" H 2925 5600 50  0001 C CNN
	1    2925 5600
	-1   0    0    1   
$EndComp
Wire Wire Line
	2625 5800 2775 5800
Wire Wire Line
	2775 5800 2775 5600
Wire Wire Line
	2575 1250 2575 1350
Wire Wire Line
	5625 4650 5625 4050
Wire Wire Line
	5625 4050 6025 4050
Wire Wire Line
	5625 4650 6025 4650
Wire Wire Line
	6025 4050 6025 3450
Wire Wire Line
	6825 3750 6825 3450
NoConn ~ 3175 2850
Wire Wire Line
	2575 1250 3575 1250
NoConn ~ 3175 2750
$Comp
L RevK:PowerIn J3
U 1 1 60460B50
P 9325 900
F 0 "J3" H 9375 1000 50  0000 R CNN
F 1 "DC" H 9500 900 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 9325 900 50  0001 C CNN
F 3 "~" H 9325 900 50  0001 C CNN
F 4 "Not fitted" H 9325 900 50  0001 C CNN "Notes"
	1    9325 900 
	1    0    0    -1  
$EndComp
NoConn ~ 1975 1750
$Comp
L Device:R R7
U 1 1 60D24A3F
P 4025 6300
F 0 "R7" V 4125 6300 50  0000 C CNN
F 1 "NF" V 4025 6300 50  0000 C CNN
F 2 "RevK:Pad_1206_0805_NF" V 3955 6300 50  0001 C CNN
F 3 "~" H 4025 6300 50  0001 C CNN
F 4 "Not fitted" V 4025 6300 50  0001 C CNN "Notes"
	1    4025 6300
	0    1    1    0   
$EndComp
$Comp
L Device:C C1
U 1 1 60D24A40
P 2925 5750
F 0 "C1" H 2925 5650 50  0000 L CNN
F 1 "NF" H 2875 5750 50  0000 L CNN
F 2 "RevK:Pad_1206_0805_NF" H 2963 5600 50  0001 C CNN
F 3 "~" H 2925 5750 50  0001 C CNN
F 4 "Not fitted" H 2925 5750 50  0001 C CNN "Notes"
	1    2925 5750
	1    0    0    -1  
$EndComp
Connection ~ 2925 5600
Connection ~ 2925 5900
Wire Wire Line
	2925 5900 3275 5900
Wire Wire Line
	2775 5600 2925 5600
Wire Wire Line
	2625 5900 2925 5900
Connection ~ 3675 6300
Wire Wire Line
	2625 6300 3675 6300
Text GLabel 4375 2400 2    50   Input ~ 0
GPIO0
NoConn ~ 3175 3050
NoConn ~ 3175 2650
NoConn ~ 3175 2450
$Comp
L Interface_USB:FT231XQ U2
U 1 1 60849D1E
P 6725 4650
F 0 "U2" H 6725 5731 50  0000 C CNN
F 1 "FT231XQ" H 6725 5640 50  0000 C CNN
F 2 "RevK:QFN-20-1EP_4x4mm_P0.5mm_EP2.5x2.5mm" H 8075 3850 50  0001 C CNN
F 3 "https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT231X.pdf" H 6725 4650 50  0001 C CNN
F 4 "FTDI" H 6725 4650 50  0001 C CNN "Manufacturer"
F 5 "FT231XQ" H 6725 4650 50  0001 C CNN "Part No"
	1    6725 4650
	1    0    0    -1  
$EndComp
Connection ~ 6025 4050
Text GLabel 7425 4450 2    50   Output ~ 0
GPIO0
$Comp
L power:GND #PWR019
U 1 1 6084D835
P 7425 4350
F 0 "#PWR019" H 7425 4100 50  0001 C CNN
F 1 "GND" V 7430 4222 50  0000 R CNN
F 2 "" H 7425 4350 50  0001 C CNN
F 3 "" H 7425 4350 50  0001 C CNN
	1    7425 4350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR020
U 1 1 6084DCBB
P 7425 4550
F 0 "#PWR020" H 7425 4300 50  0001 C CNN
F 1 "GND" V 7430 4422 50  0000 R CNN
F 2 "" H 7425 4550 50  0001 C CNN
F 3 "" H 7425 4550 50  0001 C CNN
	1    7425 4550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR021
U 1 1 6084E14D
P 7425 4650
F 0 "#PWR021" H 7425 4400 50  0001 C CNN
F 1 "GND" V 7430 4522 50  0000 R CNN
F 2 "" H 7425 4650 50  0001 C CNN
F 3 "" H 7425 4650 50  0001 C CNN
	1    7425 4650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR022
U 1 1 6084E5CB
P 7425 4750
F 0 "#PWR022" H 7425 4500 50  0001 C CNN
F 1 "GND" V 7430 4622 50  0000 R CNN
F 2 "" H 7425 4750 50  0001 C CNN
F 3 "" H 7425 4750 50  0001 C CNN
	1    7425 4750
	0    -1   -1   0   
$EndComp
NoConn ~ 7425 5150
NoConn ~ 7425 5250
$Comp
L power:GND #PWR015
U 1 1 608547A1
P 6725 5550
F 0 "#PWR015" H 6725 5300 50  0001 C CNN
F 1 "GND" H 6730 5377 50  0000 C CNN
F 2 "" H 6725 5550 50  0001 C CNN
F 3 "" H 6725 5550 50  0001 C CNN
	1    6725 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6625 5550 6725 5550
Connection ~ 6725 5550
Wire Wire Line
	6725 5550 6825 5550
$Comp
L RevK:Regulator Reg1
U 1 1 608EC192
P 9175 1300
F 0 "Reg1" H 9753 1201 50  0000 L CNN
F 1 "Regulator" H 9753 1110 50  0000 L CNN
F 2 "RevK:RegulatorBlock" H 9625 1400 50  0001 C CNN
F 3 "lmr16006yddcr" H 9625 1400 50  0001 C CNN
F 4 "This is a composite part - LMR16006, 0.1uF 0603, 2.2uf 0805, 10uf 0805, Diode, 6.8uH" H 9175 1300 50  0001 C CNN "Notes"
	1    9175 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 608EF177
P 8775 1500
F 0 "#PWR023" H 8775 1250 50  0001 C CNN
F 1 "GND" V 8780 1372 50  0000 R CNN
F 2 "" H 8775 1500 50  0001 C CNN
F 3 "" H 8775 1500 50  0001 C CNN
	1    8775 1500
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR028
U 1 1 608EF736
P 9175 1600
F 0 "#PWR028" H 9175 1450 50  0001 C CNN
F 1 "+3.3V" V 9190 1728 50  0000 L CNN
F 2 "" H 9175 1600 50  0001 C CNN
F 3 "" H 9175 1600 50  0001 C CNN
	1    9175 1600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 608FDC75
P 3175 2250
F 0 "#PWR06" H 3175 2000 50  0001 C CNN
F 1 "GND" V 3180 2122 50  0000 R CNN
F 2 "" H 3175 2250 50  0001 C CNN
F 3 "" H 3175 2250 50  0001 C CNN
	1    3175 2250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 608FE16D
P 3175 2050
F 0 "#PWR05" H 3175 1800 50  0001 C CNN
F 1 "GND" V 3180 1922 50  0000 R CNN
F 2 "" H 3175 2050 50  0001 C CNN
F 3 "" H 3175 2050 50  0001 C CNN
	1    3175 2050
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 608FEA23
P 2575 4050
F 0 "#PWR03" H 2575 3800 50  0001 C CNN
F 1 "GND" H 2580 3877 50  0000 C CNN
F 2 "" H 2575 4050 50  0001 C CNN
F 3 "" H 2575 4050 50  0001 C CNN
	1    2575 4050
	1    0    0    -1  
$EndComp
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 6043326C
P 2575 2650
F 0 "U1" H 2575 4231 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 2575 4140 50  0000 C CNN
F 2 "RevK:ESP32-WROOM-32" H 2575 1150 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 2275 2700 50  0001 C CNN
F 4 "Espressif" H 2575 2650 50  0001 C CNN "Manufacturer"
F 5 "ESP32-WROOM-32" H 2575 2650 50  0001 C CNN "Part No"
F 6 "Can be -32D, -32E, etc, must have built in antenna. Select models with 16MB (128Mb) flash fitted" H 2575 2650 50  0001 C CNN "Notes"
	1    2575 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 608FF224
P 3175 3750
F 0 "#PWR08" H 3175 3500 50  0001 C CNN
F 1 "GND" V 3180 3622 50  0000 R CNN
F 2 "" H 3175 3750 50  0001 C CNN
F 3 "" H 3175 3750 50  0001 C CNN
	1    3175 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR07
U 1 1 608FF6DE
P 3175 3650
F 0 "#PWR07" H 3175 3400 50  0001 C CNN
F 1 "GND" V 3180 3522 50  0000 R CNN
F 2 "" H 3175 3650 50  0001 C CNN
F 3 "" H 3175 3650 50  0001 C CNN
	1    3175 3650
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C2
U 1 1 609259A6
P 5625 4800
F 0 "C2" H 5740 4846 50  0000 L CNN
F 1 "100nF" H 5740 4755 50  0000 L CNN
F 2 "RevK:C_0603" H 5663 4650 50  0001 C CNN
F 3 "~" H 5625 4800 50  0001 C CNN
	1    5625 4800
	1    0    0    -1  
$EndComp
Connection ~ 5625 4650
$Comp
L power:GND #PWR013
U 1 1 60926541
P 5625 4950
F 0 "#PWR013" H 5625 4700 50  0001 C CNN
F 1 "GND" H 5630 4777 50  0000 C CNN
F 2 "" H 5625 4950 50  0001 C CNN
F 3 "" H 5625 4950 50  0001 C CNN
	1    5625 4950
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR014
U 1 1 60A03A7F
P 6625 3150
F 0 "#PWR014" H 6625 3000 50  0001 C CNN
F 1 "VBUS" H 6640 3323 50  0000 C CNN
F 2 "" H 6625 3150 50  0001 C CNN
F 3 "" H 6625 3150 50  0001 C CNN
	1    6625 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6625 3150 6625 3750
Wire Wire Line
	6025 3450 6825 3450
Wire Wire Line
	9125 1000 8925 1000
Wire Wire Line
	8925 1000 8925 1125
Wire Wire Line
	8925 1300 9175 1300
Wire Wire Line
	8925 1300 8925 1400
Wire Wire Line
	8925 1400 9175 1400
Connection ~ 8925 1300
Wire Wire Line
	9125 900  8775 900 
Wire Wire Line
	8775 900  8775 1500
Wire Wire Line
	8775 1500 9175 1500
Connection ~ 8775 1500
Wire Wire Line
	1225 1450 1975 1450
$Comp
L Device:R R1
U 1 1 60A25F05
P 1225 1300
F 0 "R1" V 1432 1300 50  0000 C CNN
F 1 "10K" V 1341 1300 50  0000 C CNN
F 2 "RevK:R_0603" V 1155 1300 50  0001 C CNN
F 3 "~" H 1225 1300 50  0001 C CNN
	1    1225 1300
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR01
U 1 1 60A276D4
P 1225 1150
F 0 "#PWR01" H 1225 1000 50  0001 C CNN
F 1 "+3.3V" H 1240 1323 50  0000 C CNN
F 2 "" H 1225 1150 50  0001 C CNN
F 3 "" H 1225 1150 50  0001 C CNN
	1    1225 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 60A27EE2
P 1225 1850
F 0 "#PWR02" H 1225 1600 50  0001 C CNN
F 1 "GND" H 1230 1677 50  0000 C CNN
F 2 "" H 1225 1850 50  0001 C CNN
F 3 "" H 1225 1850 50  0001 C CNN
	1    1225 1850
	1    0    0    -1  
$EndComp
Text GLabel 825  1650 0    50   Input ~ 0
EN
Wire Wire Line
	3175 1450 3625 1450
Wire Wire Line
	3625 1450 3625 2100
Wire Wire Line
	3625 2100 3975 2100
Wire Wire Line
	3975 2100 3975 2200
$Comp
L power:GND #PWR011
U 1 1 60A33C2A
P 3975 2600
F 0 "#PWR011" H 3975 2350 50  0001 C CNN
F 1 "GND" H 3980 2427 50  0000 C CNN
F 2 "" H 3975 2600 50  0001 C CNN
F 3 "" H 3975 2600 50  0001 C CNN
	1    3975 2600
	1    0    0    -1  
$EndComp
Text Notes 5675 5950 0    50   ~ 0
Note that RTS and DTR need to be inverted in FT231X configuration
Text GLabel 7425 4950 2    50   Output ~ 0
USB
Text GLabel 3175 2550 2    50   Input ~ 0
USB
$Comp
L Device:R R8
U 1 1 60A436C8
P 4200 4150
F 0 "R8" V 4275 4150 50  0000 C CNN
F 1 "324R" V 4200 4150 50  0000 C CNN
F 2 "RevK:R_0603" V 4130 4150 50  0001 C CNN
F 3 "~" H 4200 4150 50  0001 C CNN
	1    4200 4150
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR012
U 1 1 60A44FE5
P 4750 3950
F 0 "#PWR012" H 4750 3800 50  0001 C CNN
F 1 "+3.3V" V 4765 4078 50  0000 L CNN
F 2 "" H 4750 3950 50  0001 C CNN
F 3 "" H 4750 3950 50  0001 C CNN
	1    4750 3950
	0    1    1    0   
$EndComp
Text GLabel 9200 1125 2    50   Output ~ 0
DC
$Comp
L RevK:RN1701 Q1
U 1 1 60A739E6
P 1175 1650
F 0 "Q1" H 1316 1696 50  0000 L CNN
F 1 "RN1701" H 1316 1605 50  0000 L CNN
F 2 "RevK:USV-5" H 1175 1650 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/408/RN1701_datasheet_en_20191003-1627196.pdf" H 1175 1650 50  0001 C CNN
F 4 "Toshiba" H 1175 1650 50  0001 C CNN "Manufacturer"
F 5 "RN1701" H 1175 1650 50  0001 C CNN "Part No"
	1    1175 1650
	1    0    0    -1  
$EndComp
$Comp
L RevK:RN1701 Q1
U 2 1 60A78720
P 4025 2400
F 0 "Q1" H 4166 2446 50  0000 L CNN
F 1 "RN1701" H 4166 2355 50  0000 L CNN
F 2 "RevK:USV-5" H 4025 2400 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/408/RN1701_datasheet_en_20191003-1627196.pdf" H 4025 2400 50  0001 C CNN
F 4 "Toshiba" H 4025 2400 50  0001 C CNN "Manufacturer"
F 5 "RN1701" H 4025 2400 50  0001 C CNN "Part No"
	2    4025 2400
	-1   0    0    -1  
$EndComp
Text GLabel 3675 5400 1    50   Input ~ 0
DC
Wire Wire Line
	8925 1125 9200 1125
Connection ~ 8925 1125
Wire Wire Line
	8925 1125 8925 1300
Wire Wire Line
	7325 1000 7525 1000
Connection ~ 7325 1000
$Comp
L Device:D D2
U 1 1 60A93E56
P 7675 1000
F 0 "D2" H 7675 783 50  0000 C CNN
F 1 "D" H 7675 874 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 7675 1000 50  0001 C CNN
F 3 "~" H 7675 1000 50  0001 C CNN
	1    7675 1000
	-1   0    0    1   
$EndComp
Text GLabel 7825 1000 2    50   Output ~ 0
DC
Text GLabel 3175 1550 2    50   Output ~ 0
O
$Comp
L Device:R R13
U 1 1 60A9502C
P 8775 2850
F 0 "R13" V 9000 2850 50  0000 C CNN
F 1 "10K" V 8900 2850 50  0000 C CNN
F 2 "RevK:R_0603" V 8705 2850 50  0001 C CNN
F 3 "~" H 8775 2850 50  0001 C CNN
	1    8775 2850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R16
U 1 1 60A21378
P 9650 3150
F 0 "R16" V 9857 3150 50  0000 C CNN
F 1 "1k" V 9766 3150 50  0000 C CNN
F 2 "RevK:R_0603" V 9580 3150 50  0001 C CNN
F 3 "~" H 9650 3150 50  0001 C CNN
	1    9650 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 60A1CD4E
P 9650 2850
F 0 "R15" V 9857 2850 50  0000 C CNN
F 1 "18K" V 9766 2850 50  0000 C CNN
F 2 "RevK:R_0603" V 9580 2850 50  0001 C CNN
F 3 "~" H 9650 2850 50  0001 C CNN
	1    9650 2850
	1    0    0    -1  
$EndComp
Text GLabel 9650 2100 1    50   Input ~ 0
DC
$Comp
L power:GND #PWR029
U 1 1 60AA71A7
P 9650 3300
F 0 "#PWR029" H 9650 3050 50  0001 C CNN
F 1 "GND" H 9655 3127 50  0000 C CNN
F 2 "" H 9650 3300 50  0001 C CNN
F 3 "" H 9650 3300 50  0001 C CNN
	1    9650 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 60AB0248
P 9275 2350
F 0 "R14" V 9500 2350 50  0000 C CNN
F 1 "10K" V 9400 2350 50  0000 C CNN
F 2 "RevK:R_0603" V 9205 2350 50  0001 C CNN
F 3 "~" H 9275 2350 50  0001 C CNN
	1    9275 2350
	-1   0    0    1   
$EndComp
Wire Wire Line
	9275 2200 9650 2200
Wire Wire Line
	9650 2200 9650 2300
Wire Wire Line
	9075 2900 9075 3300
Wire Wire Line
	9075 3300 9650 3300
Connection ~ 9650 3300
Wire Wire Line
	8775 3000 8775 3300
Wire Wire Line
	8775 3300 9075 3300
Connection ~ 9075 3300
Wire Wire Line
	9650 3000 10175 3000
Connection ~ 9650 3000
Wire Wire Line
	8775 2700 8350 2700
Text GLabel 3175 2950 2    50   Output ~ 0
ADCON
Text GLabel 3175 3250 2    50   Input ~ 0
ADC
Text GLabel 10175 3000 2    50   Output ~ 0
ADC
Text GLabel 8350 2700 0    50   Input ~ 0
ADCON
Wire Wire Line
	9650 2100 9650 2200
Connection ~ 9650 2200
Wire Wire Line
	9075 2500 9275 2500
Connection ~ 9275 2500
Wire Wire Line
	9275 2500 9350 2500
$Comp
L RevK:NX6020CAKS U3
U 1 1 60A96FBC
P 9075 2700
F 0 "U3" H 9180 2746 50  0000 L CNN
F 1 "NX6020CAKS" H 9180 2655 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9025 2125 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/NX6020CAKS.pdf" H 9025 2125 50  0001 C CNN
F 4 "NX6020CAKS" H 9075 2700 50  0001 C CNN "Part No"
F 5 "Nexperia" H 9075 2700 50  0001 C CNN "Manufacturer"
	1    9075 2700
	1    0    0    -1  
$EndComp
Connection ~ 8775 2700
$Comp
L RevK:NX6020CAKS U3
U 2 1 60A986A6
P 9650 2500
F 0 "U3" H 9755 2454 50  0000 L CNN
F 1 "NX6020CAKS" H 9755 2545 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9600 1925 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/NX6020CAKS.pdf" H 9600 1925 50  0001 C CNN
	2    9650 2500
	1    0    0    1   
$EndComp
Connection ~ 1225 1450
Text GLabel 3175 1950 2    50   Input ~ 0
CHARGER
Text GLabel 7425 5050 2    50   Output ~ 0
CHARGER
$Comp
L Device:LED_ARGB D1
U 1 1 60CF36BC
P 4550 3950
F 0 "D1" H 4550 4447 50  0000 C CNN
F 1 "RGB" H 4550 4356 50  0000 C CNN
F 2 "RevK:LED-RGB-1.6x1.6" H 4550 3900 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/216/APTF1616LSEEZGKQBKC-786442.pdf" H 4550 3900 50  0001 C CNN
F 4 "Kingbright" H 4550 3950 50  0001 C CNN "Manufacturer"
F 5 "APTF1616LSEEZGKQBKC" H 4550 3950 50  0001 C CNN "Part No"
	1    4550 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 60CF9E4D
P 4200 3750
F 0 "R9" V 4275 3750 50  0000 C CNN
F 1 "732R" V 4200 3750 50  0000 C CNN
F 2 "RevK:R_0603" V 4130 3750 50  0001 C CNN
F 3 "~" H 4200 3750 50  0001 C CNN
	1    4200 3750
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 60CFBFAF
P 4200 3950
F 0 "R10" V 4275 3950 50  0000 C CNN
F 1 "2K" V 4200 3950 50  0000 C CNN
F 2 "RevK:R_0603" V 4130 3950 50  0001 C CNN
F 3 "~" H 4200 3950 50  0001 C CNN
	1    4200 3950
	0    1    1    0   
$EndComp
Text GLabel 4050 3750 0    50   Input ~ 0
R
Text GLabel 4050 3950 0    50   Input ~ 0
G
Text GLabel 4050 4150 0    50   Input ~ 0
B
Text GLabel 3175 3150 2    50   Output ~ 0
G
Connection ~ 2575 1250
NoConn ~ -7400 375 
$Comp
L Diode:BAV99S D3
U 1 1 609F92B0
P 9425 4000
F 0 "D3" H 9425 4217 50  0000 C CNN
F 1 "BAV99S" H 9425 4126 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9425 3500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 9425 4000 50  0001 C CNN
F 4 "Nexperia" H 9425 4000 50  0001 C CNN "Manufacturer"
F 5 "BAV99S" H 9425 4000 50  0001 C CNN "Part No"
	1    9425 4000
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR030
U 1 1 609F92C2
P 9725 4000
F 0 "#PWR030" H 9725 3850 50  0001 C CNN
F 1 "+3.3V" H 9740 4173 50  0000 C CNN
F 2 "" H 9725 4000 50  0001 C CNN
F 3 "" H 9725 4000 50  0001 C CNN
	1    9725 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 609F92D4
P 9125 4000
F 0 "#PWR024" H 9125 3750 50  0001 C CNN
F 1 "GND" H 9130 3827 50  0000 C CNN
F 2 "" H 9125 4000 50  0001 C CNN
F 3 "" H 9125 4000 50  0001 C CNN
	1    9125 4000
	-1   0    0    1   
$EndComp
Text GLabel 9725 4200 2    50   Input ~ 0
IO1
$Comp
L Diode:BAV99S D3
U 2 1 60DDC5E7
P 9425 4600
F 0 "D3" H 9425 4817 50  0000 C CNN
F 1 "BAV99S" H 9425 4726 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9425 4100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 9425 4600 50  0001 C CNN
F 4 "Nexperia" H 9425 4600 50  0001 C CNN "Manufacturer"
F 5 "BAV99S" H 9425 4600 50  0001 C CNN "Part No"
	2    9425 4600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR031
U 1 1 60DDC5ED
P 9725 4600
F 0 "#PWR031" H 9725 4450 50  0001 C CNN
F 1 "+3.3V" H 9740 4773 50  0000 C CNN
F 2 "" H 9725 4600 50  0001 C CNN
F 3 "" H 9725 4600 50  0001 C CNN
	1    9725 4600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 60DDC5F3
P 9125 4600
F 0 "#PWR025" H 9125 4350 50  0001 C CNN
F 1 "GND" H 9130 4427 50  0000 C CNN
F 2 "" H 9125 4600 50  0001 C CNN
F 3 "" H 9125 4600 50  0001 C CNN
	1    9125 4600
	-1   0    0    1   
$EndComp
Text GLabel 9725 4800 2    50   Input ~ 0
IO2
$Comp
L Diode:BAV99S D4
U 1 1 60DDEF2C
P 9425 5225
F 0 "D4" H 9425 5442 50  0000 C CNN
F 1 "BAV99S" H 9425 5351 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9425 4725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 9425 5225 50  0001 C CNN
F 4 "Nexperia" H 9425 5225 50  0001 C CNN "Manufacturer"
F 5 "BAV99S" H 9425 5225 50  0001 C CNN "Part No"
	1    9425 5225
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR032
U 1 1 60DDEF32
P 9725 5225
F 0 "#PWR032" H 9725 5075 50  0001 C CNN
F 1 "+3.3V" H 9740 5398 50  0000 C CNN
F 2 "" H 9725 5225 50  0001 C CNN
F 3 "" H 9725 5225 50  0001 C CNN
	1    9725 5225
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 60DDEF38
P 9125 5225
F 0 "#PWR026" H 9125 4975 50  0001 C CNN
F 1 "GND" H 9130 5052 50  0000 C CNN
F 2 "" H 9125 5225 50  0001 C CNN
F 3 "" H 9125 5225 50  0001 C CNN
	1    9125 5225
	-1   0    0    1   
$EndComp
Text GLabel 9725 5425 2    50   Input ~ 0
IO3
$Comp
L Diode:BAV99S D4
U 2 1 60DE1009
P 9425 5875
F 0 "D4" H 9425 6092 50  0000 C CNN
F 1 "BAV99S" H 9425 6001 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 9425 5375 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 9425 5875 50  0001 C CNN
F 4 "Nexperia" H 9425 5875 50  0001 C CNN "Manufacturer"
F 5 "BAV99S" H 9425 5875 50  0001 C CNN "Part No"
	2    9425 5875
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR033
U 1 1 60DE100F
P 9725 5875
F 0 "#PWR033" H 9725 5725 50  0001 C CNN
F 1 "+3.3V" H 9740 6048 50  0000 C CNN
F 2 "" H 9725 5875 50  0001 C CNN
F 3 "" H 9725 5875 50  0001 C CNN
	1    9725 5875
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR027
U 1 1 60DE1015
P 9125 5875
F 0 "#PWR027" H 9125 5625 50  0001 C CNN
F 1 "GND" H 9130 5702 50  0000 C CNN
F 2 "" H 9125 5875 50  0001 C CNN
F 3 "" H 9125 5875 50  0001 C CNN
	1    9125 5875
	-1   0    0    1   
$EndComp
Text GLabel 9725 6075 2    50   Input ~ 0
IO4
Wire Wire Line
	9425 4200 9725 4200
Wire Wire Line
	9425 4800 9725 4800
Wire Wire Line
	9425 5425 9725 5425
Wire Wire Line
	9425 6075 9725 6075
$Comp
L Device:R R17
U 1 1 60E07376
P 7575 1600
F 0 "R17" V 7650 1600 50  0000 C CNN
F 1 "27R" V 7575 1600 50  0000 C CNN
F 2 "RevK:R_0603" V 7505 1600 50  0001 C CNN
F 3 "~" H 7575 1600 50  0001 C CNN
	1    7575 1600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R18
U 1 1 60E0737C
P 7575 1700
F 0 "R18" V 7650 1700 50  0000 C CNN
F 1 "27R" V 7575 1700 50  0000 C CNN
F 2 "RevK:R_0603" V 7505 1700 50  0001 C CNN
F 3 "~" H 7575 1700 50  0001 C CNN
	1    7575 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	6725 1500 6725 1600
Wire Wire Line
	6725 1600 7000 1600
Connection ~ 6725 1600
Wire Wire Line
	6725 1700 7225 1700
Connection ~ 6725 1700
$Comp
L Device:C C3
U 1 1 60CFAC57
P 7675 1200
F 0 "C3" V 7775 1300 50  0000 C CNN
F 1 "10nF" V 7850 1275 50  0000 C CNN
F 2 "RevK:C_0603" H 7713 1050 50  0001 C CNN
F 3 "~" H 7675 1200 50  0001 C CNN
	1    7675 1200
	0    1    1    0   
$EndComp
Wire Wire Line
	7525 1000 7525 1200
Connection ~ 7525 1000
$Comp
L power:GND #PWR0101
U 1 1 60CFE588
P 7825 1200
F 0 "#PWR0101" H 7825 950 50  0001 C CNN
F 1 "GND" V 7830 1072 50  0000 R CNN
F 2 "" H 7825 1200 50  0001 C CNN
F 3 "" H 7825 1200 50  0001 C CNN
	1    7825 1200
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C4
U 1 1 60D15DB1
P 7000 1950
F 0 "C4" V 6775 2050 50  0000 C CNN
F 1 "47pF" V 6850 2025 50  0000 C CNN
F 2 "RevK:C_0603" H 7038 1800 50  0001 C CNN
F 3 "~" H 7000 1950 50  0001 C CNN
	1    7000 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 60D18CDC
P 7225 1950
F 0 "C5" V 7325 2050 50  0000 C CNN
F 1 "47pF" V 7400 2025 50  0000 C CNN
F 2 "RevK:C_0603" H 7263 1800 50  0001 C CNN
F 3 "~" H 7225 1950 50  0001 C CNN
	1    7225 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1600 7000 1800
Connection ~ 7000 1600
Wire Wire Line
	7000 1600 7425 1600
Wire Wire Line
	7225 1700 7225 1800
Connection ~ 7225 1700
Wire Wire Line
	7225 1700 7425 1700
Wire Wire Line
	7225 2100 7225 2500
Connection ~ 7225 2500
Wire Wire Line
	7225 2500 7375 2500
Wire Wire Line
	7000 2100 7000 2500
Wire Wire Line
	6125 2500 7000 2500
Connection ~ 7000 2500
Wire Wire Line
	7000 2500 7225 2500
Text GLabel 3175 3550 2    50   Output ~ 0
B
Text GLabel 3175 3450 2    50   Output ~ 0
R
$EndSCHEMATC
