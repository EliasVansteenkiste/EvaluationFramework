#!/usr/bin/python
# written by Elias Vansteenkiste, August 27, 2014
import sys
import os
import subprocess
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

def run(blif_directory):
    p_find = subprocess.Popen('find '+blif_directory+' -name "*postRoute\.dcp"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for dcp_loc in p_find.stdout.readlines():
	dcp_loc = dcp_loc.rstrip()
	dir_loc = dcp_loc.split("postRoute.dcp")[0]
        print "benchmark "+dcp_loc+" dcp_loc "+dir_loc
	with cd(dir_loc):
		os.system("vivado -mode tcl -source ../catch_timing_summary.tcl | tee postroute_timing_summary.rpt")
	   
cwd = os.getcwd()
print cwd
run(cwd)
 

