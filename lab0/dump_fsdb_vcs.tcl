global env
set fsdbname wave
set tbname tb1
fsdbDumpfile "$fsdbname.fsdb"
fsdbDumpvars 0 "$tbname"
run
quit
