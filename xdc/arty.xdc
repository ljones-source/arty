set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property -dict {PACKAGE_PIN E3  IOSTANDARD LVCMOS33} [get_ports {clk}];
create_clock -name clk -period 10.00 [get_ports {clk}];

# SWITCHES
set_property -dict {PACKAGE_PIN A8  IOSTANDARD LVCMOS33} [get_ports {sw[0]}];
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {sw[1]}];
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports {sw[2]}];
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports {sw[3]}];

# BUTTONS
set_property -dict {PACKAGE_PIN D9  IOSTANDARD LVCMOS33} [get_ports {btn[0]}];
set_property -dict {PACKAGE_PIN C9  IOSTANDARD LVCMOS33} [get_ports {btn[1]}];
set_property -dict {PACKAGE_PIN B9  IOSTANDARD LVCMOS33} [get_ports {btn[2]}];
set_property -dict {PACKAGE_PIN B8  IOSTANDARD LVCMOS33} [get_ports {btn[3]}];

# LEDS
set_property -dict {PACKAGE_PIN H5  IOSTANDARD LVCMOS33} [get_ports {led[0]}];
set_property -dict {PACKAGE_PIN J5  IOSTANDARD LVCMOS33} [get_ports {led[1]}];
set_property -dict {PACKAGE_PIN T9  IOSTANDARD LVCMOS33} [get_ports {led[2]}];
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {led[3]}];

# RGB LEDS
set_property -dict {PACKAGE_PIN G6  IOSTANDARD LVCMOS33} [get_ports {led_r[0]}];
set_property -dict {PACKAGE_PIN F6  IOSTANDARD LVCMOS33} [get_ports {led_g[0]}];
set_property -dict {PACKAGE_PIN E1  IOSTANDARD LVCMOS33} [get_ports {led_b[0]}];
set_property -dict {PACKAGE_PIN G3  IOSTANDARD LVCMOS33} [get_ports {led_r[1]}];
set_property -dict {PACKAGE_PIN J4  IOSTANDARD LVCMOS33} [get_ports {led_g[1]}];
set_property -dict {PACKAGE_PIN G4  IOSTANDARD LVCMOS33} [get_ports {led_b[1]}];
set_property -dict {PACKAGE_PIN J3  IOSTANDARD LVCMOS33} [get_ports {led_r[2]}];
set_property -dict {PACKAGE_PIN J2  IOSTANDARD LVCMOS33} [get_ports {led_g[2]}];
set_property -dict {PACKAGE_PIN H4  IOSTANDARD LVCMOS33} [get_ports {led_b[2]}];
set_property -dict {PACKAGE_PIN K1  IOSTANDARD LVCMOS33} [get_ports {led_r[3]}];
set_property -dict {PACKAGE_PIN H6  IOSTANDARD LVCMOS33} [get_ports {led_g[3]}];
set_property -dict {PACKAGE_PIN K2  IOSTANDARD LVCMOS33} [get_ports {led_b[3]}];

# PMOD JA Standard
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_1}];
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_2}];
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_3}];
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_4}];
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_7}];
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_8}];
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_9}];
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {pmod_JA_10}];

# PMOD JB High Speed
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_1}];
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_2}];
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_3}];
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_4}];
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_7}];
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_8}];
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_9}];
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {pmod_JB_10}];

# PMOD JC High Speed
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_1}];
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_2}];
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_3}];
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_4}];
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_7}];
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_8}];
set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_9}];
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {pmod_JC_10}];

# PMOD JD Starndard
set_property -dict {PACKAGE_PIN D4  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_1}];
set_property -dict {PACKAGE_PIN D3  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_2}];
set_property -dict {PACKAGE_PIN F4  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_3}];
set_property -dict {PACKAGE_PIN F3  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_4}];
set_property -dict {PACKAGE_PIN E2  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_7}];
set_property -dict {PACKAGE_PIN D2  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_8}];
set_property -dict {PACKAGE_PIN H2  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_9}];
set_property -dict {PACKAGE_PIN G2  IOSTANDARD LVCMOS33} [get_ports {pmod_JD_10}];

# Shield Analogue I/O
set_property -dict {PACKAGE_PIN C5  IOSTANDARD LVCMOS33} [get_ports {vaux4_n}]  ;# A0
set_property -dict {PACKAGE_PIN C6  IOSTANDARD LVCMOS33} [get_ports {vaux4_p}]  ;# A0
set_property -dict {PACKAGE_PIN A5  IOSTANDARD LVCMOS33} [get_ports {vaux5_n}]  ;# A1
set_property -dict {PACKAGE_PIN A6  IOSTANDARD LVCMOS33} [get_ports {vaux5_p}]  ;# A1
set_property -dict {PACKAGE_PIN B4  IOSTANDARD LVCMOS33} [get_ports {vaux6_n}]  ;# A2
set_property -dict {PACKAGE_PIN C4  IOSTANDARD LVCMOS33} [get_ports {vaux6_p}]  ;# A2
set_property -dict {PACKAGE_PIN A1  IOSTANDARD LVCMOS33} [get_ports {vaux7_n}]  ;# A3
set_property -dict {PACKAGE_PIN B1  IOSTANDARD LVCMOS33} [get_ports {vaux7_p}]  ;# A3
set_property -dict {PACKAGE_PIN B2  IOSTANDARD LVCMOS33} [get_ports {vaux15_n}] ;# A4
set_property -dict {PACKAGE_PIN B3  IOSTANDARD LVCMOS33} [get_ports {vaux15_p}] ;# A4
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports {vaux0_n}]  ;# A5
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {vaux0_p}]  ;# A5
