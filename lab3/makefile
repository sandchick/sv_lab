# VCS 
VCS = vcs -full64 -LDFLAGS -Wl,--no-as-needed
DEFINE_DSDB = +define+DUMP_FSDB
TB_FILE = tb1
PKG_FILE = chnl_pkg1

#Simulation Timescale
TIMESCALE = timescale=1ns/1ps

all: gen_flist com dump_file sim verdi

gen_flist:
	find ../MCDT/v1/ -wholename "*.v" > filelist.f
	echo "./$(PKG_FILE).sv" >> filelist.f
	echo "./$(TB_FILE).sv" >> filelist.f

com:
	$(VCS) +v2k -sverilog \
	-f filelist.f \
	-debug_access+all+dmptf \
	-debug_pp \
	-$(TIMESCALE) \
	-l com.log \
	$(DEFINE_DSDB)

dump_file:
	echo "global env" > dump_fsdb_vcs.tcl 
	echo "set fsdbname wave" >> dump_fsdb_vcs.tcl 
	echo 'fsdbDumpfile "$$fsdbname.fsdb" ' >> dump_fsdb_vcs.tcl
	echo 'fsdbDumpvars 0 "$(TB_FILE)" ' >> dump_fsdb_vcs.tcl
	echo "run" >> dump_fsdb_vcs.tcl

sim:
	./simv \
	-ucli -i dump_fsdb_vcs.tcl \
	+fsdb+functions \
	+ntb_random_seed_automatic \
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
