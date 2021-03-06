transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Synchronizers.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Router.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Reg_4.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/HexDriver.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Control.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/compute.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Register_unit.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/Processor.sv}

vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/logic_processor8bit {C:/intelFPGA_lite/18.1/logic_processor8bit/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
