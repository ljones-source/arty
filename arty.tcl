#!/usr/bin/env -S vivado -mode batch -source

set d [file normalize [file dirname [info script]]]

create_project arty $d -part xc7a35ticsg324-1L -force
set_property target_language VHDL [current_project]

add_files -fileset sources_1 [list \
	$d/src/pwm.vhd \
	$d/src/top.vhd \
	$d/src/uart_tx.vhd \
]
add_files -fileset sim_1 [list \
	$d/src/uart_tx_tb.vhd \
]
add_files -fileset constrs_1 [list \
	$d/xdc/arty.xdc \
]

set_property file_type "VHDL 2008" -objects [get_files *.vhd]

set_property top top [get_filesets sources_1]
set_property top uart_tx_tb [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

set_property -name xsim.simulate.runtime -value 50ms -objects [get_filesets sim_1]
