rm -rf work
mkdir work

#ncvhdl -work work -64  -update   -mess  rtl.vhd -APPEND_LOG
#ncvhdl -work work -64  -update   -mess  tb.vhd -APPEND_LOG
ncvlog -sv -work work -64 -update -mess -FILE ../design/rtl.cfg
ncvlog -sv -work work -64 -update -mess -FILE ../verif/tb.cfg

#ncelab -work work -64 -update -mess -64bit -access +R+W  -APPEND_LOG WORK.decoder:decoder
#ncelab -work work -64 -update -mess -64bit -access +R+W  -APPEND_LOG WORK.TB_TOP:ARCH
ncelab  -work work -64   -mess -64bit -access +R+W  -APPEND_LOG WORK.tb_top:module


