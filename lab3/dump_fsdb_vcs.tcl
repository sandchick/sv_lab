global env
set fsdbname wave
fsdbDumpfile "$fsdbname.fsdb" 
fsdbDumpvars 0 "tb1" 
run
