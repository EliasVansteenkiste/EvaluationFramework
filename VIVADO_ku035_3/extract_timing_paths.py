# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess
import os
from random import randint

class cd:
    """Context manager for changing the current working directory"""
    def __init__(self, newPath):
        self.newPath = newPath

    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

p_find = subprocess.Popen('find . -name "postroute.timing_summary.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    dir_loc = runtcl_loc.split("postroute.timing_summary.rpt")[0]
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
                total_endpoints = numbers[3]
    if total_endpoints != "NA":
        endpoints = int(total_endpoints)
        critical_endpoints = endpoints/20
        with cd(dir_loc):
            print endpoints, critical_endpoints
            os.system("vivado -mode tcl -source ../extract_timing_paths.tcl -tclargs "+critical_endpoints+" | tee output_extraction.txt")
	

        
#    p_grep = subprocess.Popen('grep -B2 -A4 "WNS(ns)" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#    p_grep.wait()
#    lines = p_grep.stdout.readlines()
#    for line in lines:
#	words = line.split()
#	if words[0] == "WNS(ns)":
#		print lines
#		break
