# VCS 
VCS = vcs -full64 -LDFLAGS -Wl,--no-as-needed
DEFINE_DSDB = +define+DUMP_FSDB

#Simulation Timescale
TIMESCALE = timescale=1ns/1ps

#Testname
TESTNAME = mcdf_data_consistence_basic_test

all: gen_flist com dump_file sim verdi

nverdi: gen_flist com dump_file sim 

gen_flist:
	find ../MCDF/v0/ -wholename "*.v" > filelist.f
	echo "./rpt_pkg.sv" >> filelist.f
	echo "./arb_pkg.sv" >> filelist.f
	echo "./chnl_pkg.sv" >> filelist.f
	echo "./reg_pkg.sv" >> filelist.f
	echo "./fmt_pkg.sv" >> filelist.f
	echo "./mcdf_pkg.sv" >> filelist.f
	echo "./tb.sv" >> filelist.f

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
	+TESTNAME=$(TESTNAME) \
	-l sim.log -sml

clean:clean_com clean_sim clean_verdi
	rm -rf *.log
	ls -l

clean_com:
	rm -rf csrc simv.daidir simv com.log simv.cst

clean_sim:
	rm -rf *.key *.fsdb *.vcd *vpd DVEfiles NOVAS_dump.log sim.log verilog.dump sim.log.sml .__solver_cache__/

clean_verdi:
	rm -rf ./verdiLog ./novas.*

dve:
	$(DVE) -vpd ./sim_output_pluson.vpd &

verdi:
	verdi +v2k -sverilog -f filelist.f -ssf ./wave.fsdb -sswr ./signal.rc &
