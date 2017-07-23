#Makefile:


####################### special targets ########################

all: setup compile sim

setup: setup.csh pre_compile.csh

compile: vcom vlog vopt

sim: vsim view


######################### setup files ###############################

setup.csh:
	source setup.csh

pre_compile.csh:
	source pre_compile.csh

######################### compilation ################################

vcom: setup.csh pre_compile.csh
	vcom -64 -f rtl.cfg

vlog: setup.csh pre_compile.csh
	vlog -64 -sv -f tb.cfg

######################## optimization ################################

vopt: vcom vlog
	vopt -64 Processor_tb +acc=mpr -o Processor_tb_opt

######################### simulate ###################################

vsim: vopt
	vsim -64 -l simulation.log -do sim.do -c Processor_tb_opt

view: sim
	vsim -view waveform.wlf

######################## clean ################################

clean:
	rm -f transcript waveform.wlf simulation.log
