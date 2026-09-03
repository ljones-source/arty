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

# Shield Analogue I/O - Outer Header, single-ended analog inputs (A0-A5)
# NOTE: mutually exclusive with the "Shield Outer Digital I/O" block below - same physical pins.
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

# Shield Outer Digital I/O (A0-A5) - alternate use of the pins above; leave commented
# out unless you are NOT using the XADC on these pins.
#set_property -dict {PACKAGE_PIN F5  IOSTANDARD LVCMOS33} [get_ports {ck_a0}]; # A0
#set_property -dict {PACKAGE_PIN D8  IOSTANDARD LVCMOS33} [get_ports {ck_a1}]; # A1
#set_property -dict {PACKAGE_PIN C7  IOSTANDARD LVCMOS33} [get_ports {ck_a2}]; # A2
#set_property -dict {PACKAGE_PIN E7  IOSTANDARD LVCMOS33} [get_ports {ck_a3}]; # A3
#set_property -dict {PACKAGE_PIN D7  IOSTANDARD LVCMOS33} [get_ports {ck_a4}]; # A4
#set_property -dict {PACKAGE_PIN D5  IOSTANDARD LVCMOS33} [get_ports {ck_a5}]; # A5

# Shield Inner Analogue I/O - differential analog inputs (A6-A11)
# NOTE: mutually exclusive with the "Shield Inner Digital I/O" block below - same physical pins.
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {vaux12_p}] ;# A6
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {vaux12_n}] ;# A7
set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {vaux13_p}] ;# A8
set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {vaux13_n}] ;# A9
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {vaux14_p}] ;# A10
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {vaux14_n}] ;# A11

# Shield Inner Digital I/O (A6-A11) - alternate use of the pins above; leave commented
# out unless you are NOT using the XADC on these pins.
#set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {ck_a6}];  # A6
#set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {ck_a7}];  # A7
#set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {ck_a8}];  # A8
#set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {ck_a9}];  # A9
#set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {ck_a10}]; # A10
#set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {ck_a11}]; # A11

# USB-UART Interface
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports {uart_rxd_out}];
set_property -dict {PACKAGE_PIN A9  IOSTANDARD LVCMOS33} [get_ports {uart_txd_in}];

# Shield Outer Digital Header
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {ck_io0}];
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {ck_io1}];
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {ck_io2}];
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {ck_io3}];
set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports {ck_io4}];
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {ck_io5}];
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {ck_io6}];
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {ck_io7}];
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {ck_io8}];
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {ck_io9}];
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {ck_io10}];
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {ck_io11}];
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {ck_io12}];
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {ck_io13}];

# Shield Inner Digital Header
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {ck_io26}];
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {ck_io27}];
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {ck_io28}];
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {ck_io29}];
set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {ck_io30}];
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {ck_io31}];
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {ck_io32}];
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {ck_io33}];
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {ck_io34}];
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {ck_io35}];
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {ck_io36}];
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {ck_io37}];
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {ck_io38}];
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {ck_io39}];
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {ck_io40}];
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {ck_io41}];

# Shield SPI
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {ck_miso}];
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {ck_mosi}];
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports {ck_sck}];
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {ck_ss}];

# Shield I2C
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {ck_scl}];
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {ck_sda}];
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {scl_pup}];
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {sda_pup}];

# Misc. Shield Ports
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {ck_ioa}];
set_property -dict {PACKAGE_PIN C2  IOSTANDARD LVCMOS33} [get_ports {ck_rst}];

# SMSC Ethernet PHY
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {eth_col}];
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {eth_crs}];
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports {eth_mdc}];
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {eth_mdio}];
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {eth_ref_clk}];
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {eth_rstn}];
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports {eth_rx_clk}];
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {eth_rx_dv}];
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[0]}];
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[1]}];
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[2]}];
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[3]}];
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {eth_rxerr}];
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {eth_tx_clk}];
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {eth_tx_en}];
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {eth_txd[0]}];
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {eth_txd[1]}];
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {eth_txd[2]}];
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {eth_txd[3]}];

# Quad SPI Flash
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports {qspi_cs}];
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[0]}];
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[1]}];
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[2]}];
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[3]}];

# Power Measurements
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {vsnsvu_n}];
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {vsnsvu_p}];
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports {vsns5v0_n}];
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports {vsns5v0_p}];
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {isns5v0_n}];
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {isns5v0_p}];
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {isns0v95_n}];
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {isns0v95_p}];
