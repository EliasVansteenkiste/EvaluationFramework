# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess

def findandprint(primitive_type,rpt_loc):
    print ",",
    p_grep = subprocess.Popen('grep "'+primitive_type+'" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        words = line.split()
        if words[2] == "|":
                print words[3],
                return
    print "0",

p_find = subprocess.Popen('find . -name "postRoute.utilization.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

primitive_types = ["LUT6","LUT5","LUT4","LUT3","LUT2","LUT1","CARRY4","DSP48E1","FDRE","LDCE","FDSE","RAMD32","RAMS32","RAM16X1S","RAM16X1D","RAM32X1S","RAM32X1D","RAM64X1S","RAM64X1D","RAM128X1S","RAM128X1D","RAM32M","RAM64M","SRL16E","SRL16E1","SRL32E1","SRLC32E","RAMB18E1", "RAMB36E1"]
print "Design",
for header in primitive_types:
    print ",", header,
print
for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    print designname,
    for type in primitive_types:
        findandprint(type,rpt_loc)
    print
