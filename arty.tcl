#!/usr/bin/env -S vivado -mode batch -source

set projname arty
set part xc7a35ticsg324-1L

set cp_args [list $projname $projname -part $part]
if {[lsearch $argv "-force"] >= 0} {
    lappend cp_args -force
}
create_project {*}$cp_args
set_property target_language VHDL [current_project]

# Sources
add_files -fileset sources_1 [list			\
	[file normalize "src/pwm.vhd"]			\
	[file normalize "src/top.vhd"]			\
]

# Everything VHDL is VHDL-2008
set_property file_type "VHDL 2008" -objects [get_files -of_objects [get_filesets sources_1] [list \
	"*.vhd"							\
]]

# Constraints
add_files -fileset constrs_1 [list			\
	[file normalize "xdc/arty.xdc"]		\
]

# cmd name value [var to eval] 
set_property top top [current_fileset]
# set_property top arty_top [current_fileset]

