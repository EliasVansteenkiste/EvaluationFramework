# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess
import os
from random import randint

p_find = subprocess.Popen('find . -name "postroute.timing_summary.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    dir_loc = rpt_loc.split("postroute.timing_summary.rpt")[0]
    print designname, ",",
    rpt = open(rpt_loc,'r')
    lines = rpt.readlines()
    total_endpoints = "NA"
    i = 0
    for i in range(len(lines)):
	line = lines[i]
        words = line.split()
        if len(words)>3:
            if words[1]=="Design" and words[2]=="Timing" and words[3]=="Summary":
                numbers = lines[i+6].split()
                print numbers[0]
