## =====================================================================
## Clock Signal (100 MHz onboard oscillator)
## =====================================================================
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## =====================================================================
## Switches 0-7 -> Input A[7:0]
## =====================================================================
set_property PACKAGE_PIN V17 [get_ports {A[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]
set_property PACKAGE_PIN V16 [get_ports {A[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]
set_property PACKAGE_PIN W16 [get_ports {A[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[2]}]
set_property PACKAGE_PIN W17 [get_ports {A[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[3]}]
set_property PACKAGE_PIN W15 [get_ports {A[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[4]}]
set_property PACKAGE_PIN V15 [get_ports {A[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[5]}]
set_property PACKAGE_PIN W14 [get_ports {A[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[6]}]
set_property PACKAGE_PIN W13 [get_ports {A[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {A[7]}]

## =====================================================================
## Switches 8-15 -> Input B[7:0]
## =====================================================================
set_property PACKAGE_PIN V2  [get_ports {B[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[0]}]
set_property PACKAGE_PIN T3  [get_ports {B[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[1]}]
set_property PACKAGE_PIN T2  [get_ports {B[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[2]}]
set_property PACKAGE_PIN R3  [get_ports {B[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[3]}]
set_property PACKAGE_PIN W2  [get_ports {B[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[4]}]
set_property PACKAGE_PIN U1  [get_ports {B[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[5]}]
set_property PACKAGE_PIN T1  [get_ports {B[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[6]}]
set_property PACKAGE_PIN R2  [get_ports {B[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {B[7]}]

## =====================================================================
## LEDs 0-7 -> Output RCheck[7:0]
## =====================================================================
set_property PACKAGE_PIN U16 [get_ports {RCheck[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[0]}]
set_property PACKAGE_PIN E19 [get_ports {RCheck[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[1]}]
set_property PACKAGE_PIN U19 [get_ports {RCheck[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[2]}]
set_property PACKAGE_PIN V19 [get_ports {RCheck[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[3]}]
set_property PACKAGE_PIN W18 [get_ports {RCheck[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[4]}]
set_property PACKAGE_PIN U15 [get_ports {RCheck[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[5]}]
set_property PACKAGE_PIN U14 [get_ports {RCheck[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[6]}]
set_property PACKAGE_PIN V14 [get_ports {RCheck[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {RCheck[7]}]

## =====================================================================
## LEDs 8-15 -> Output OpCodeCheck[7:0]
## =====================================================================
set_property PACKAGE_PIN V13 [get_ports {OpCodeCheck[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[0]}]
set_property PACKAGE_PIN V3  [get_ports {OpCodeCheck[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[1]}]
set_property PACKAGE_PIN W3  [get_ports {OpCodeCheck[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[2]}]
set_property PACKAGE_PIN U3  [get_ports {OpCodeCheck[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[3]}]
set_property PACKAGE_PIN P3  [get_ports {OpCodeCheck[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[4]}]
set_property PACKAGE_PIN N3  [get_ports {OpCodeCheck[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[5]}]
set_property PACKAGE_PIN P1  [get_ports {OpCodeCheck[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[6]}]
set_property PACKAGE_PIN L1  [get_ports {OpCodeCheck[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OpCodeCheck[7]}]
	
## =====================================================================
## 7-Segment Display (Shared Segments)
## =====================================================================
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {Led[6]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {Led[5]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {Led[4]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {Led[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {Led[2]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {Led[1]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {Led[0]}]

## =====================================================================
## Digit Enables / Anodes (Active LOW)
## =====================================================================
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {Anodes[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {Anodes[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {Anodes[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {Anodes[3]}]

## =====================================================================
## Push Buttons
## =====================================================================
## Center Button (BTNC) -> Reset_All
set_property PACKAGE_PIN U18 [get_ports Reset_All]						
	set_property IOSTANDARD LVCMOS33 [get_ports Reset_All]

## Right Button (BTNR) -> data_in
set_property PACKAGE_PIN T17 [get_ports data_in]						
	set_property IOSTANDARD LVCMOS33 [get_ports data_in]
	
set_property PACKAGE_PIN W19 [get_ports Enable_Decoder]						
	set_property IOSTANDARD LVCMOS33 [get_ports Enable_Decoder]