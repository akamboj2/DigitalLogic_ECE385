transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA_lite/18.1/2Bit_Adder {C:/intelFPGA_lite/18.1/2Bit_Adder/HexDriver.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/FA8Bit.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/shiftRegister.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/FSM.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/DFF.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/Lab5_toplvl.sv}

vlog -sv -work work +incdir+C:/intelFPGA_lite/lab_5_multiplier {C:/intelFPGA_lite/lab_5_multiplier/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
