global env
set fsdbname wave
set tbname tb3
fsdbDumpfile "$fsdbname.fsdb"
fsdbDumpvars 0 "$tbname"
run 200000ns
quit
