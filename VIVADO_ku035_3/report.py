# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess
from random import randint

def print_usage(lines,prim_type):
    found = 0
    for row in lines[idx_last_occ_cell_usage:-1]:
        cells = row.split("|")
#        print cells
	if len(cells)>4:
            celltype = cells[2].rstrip()
            if celltype == prim_type:
                print cells[3]+"\t",
                found = 1
    if not found:
        print "0\t",

p_find = subprocess.Popen('find . -name "*output_auto.log"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)


primitive_types = ["LUT6","LUT5","LUT4","LUT3","LUT2","LUT1","CARRY4","DSP48E1","DSP48E1_1","DSP48E1_2","DSP48E1_3","DSP48E1_4","MUXF7","MUXF8","MUXCY","MUXCY_L","XORCY","FDRE","FDSE","LD","SRL16E","SRLC32E","FIFO36E1","FIFO36E1_1","RAMB18E1","RAMB36E1","RAMB36E1_1","RAMB36E1_2","RAMB36E1_3","BUFG","IBUF","OBUF","OBUFT"]
print "Design name\t",
for primitive_type in primitive_types:
    print primitive_type, "\t",
headers = [' Slice LUTs*             ', '   LUT as Logic          ', '   LUT as Memory         ', ' Slice Registers         ', '   Register as Flip Flop ','   Register as Latch     ',' F7 Muxes                ',' F8 Muxes                ']
for header in headers:
    print header, "\t",
print
for rpt_loc in p_find.stdout.readlines():
    p_grep = subprocess.Popen('grep -A 30 "Report Cell Usage" '+rpt_loc.rstrip(), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    designname = rpt_loc.split('/')[1]
    print designname, "\t",
    i=0
    idx_last_occ_cell_usage = -1
    lines = p_grep.stdout.readlines()
    for line in lines:
	if line.rstrip() == "Report Cell Usage:":
            idx_last_occ_cell_usage = i
        i += 1
    for primitive_type in primitive_types:
	print_usage(lines,primitive_type)
    p_grepSlice = subprocess.Popen('grep "Slice Logic" -A 16 '+rpt_loc.rstrip(), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grepSlice.wait()
    lines = p_grepSlice.stdout.readlines()
    for line in lines:
	cells = line.split('|')
        for header in headers:
            if len(cells)>6 and cells[1]==header:
                print str(int(cells[2])), "\t",
    print
