global env
set fsdbname wave
set tbname breakpoint1 
fsdbDumpfile "$fsdbname.fsdb"
fsdbDumpvars 0 "$tbname"
run 300ns
quit
