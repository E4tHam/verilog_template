yosys -import
source edalize_yosys_procs.tcl

read_json $name.json
# alumacc
# pmuxtree
# aigmap -nand
# opt
tee -o usage.txt stat
