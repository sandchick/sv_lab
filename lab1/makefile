# VCS 
VCS = vcs -full64 -LDFLAGS -Wl,--no-as-needed
DEFINE_DSDB = +define+DUMP_FSDB

#Simulation Timescale
TIMESCALE = timescale=1ns/1ps

all: gen_flist com sim verdi

gen_flist:
	find ../MCDT/v0/ -wholename "*.v" > filelist.f
	echo "./tb3.sv" >> filelist.f

com:
	$(VCS) +v2k -sverilog \
	-f filelist.f \
	-debug_access+all \
	-$(TIMESCALE) \
	-l com.log \
	+fsdb+functions \
	$(DEFINE_DSDB)

sim:
	./simv \
	-ucli -i dump_fsdb_vcs.tcl \
	-l sim.log

clean:clean_com clean_sim clean_verdi
	rm -rf *.log
	ls -l

clean_com:
	rm -rf csrc simv.daidir simv com.log

clean_sim:
	rm -rf *.key *.fsdb *.vcd *vpd DVEfiles NOVAS_dump.log sim.log verilog.dump

clean_verdi:
	rm -rf ./verdiLog ./novas.*

dve:
	$(DVE) -vpd ./sim_output_pluson.vpd &

verdi:
	verdi +v2k -sverilog -f filelist.f -ssf ./wave.fsdb -sswr ./signal.rc &
