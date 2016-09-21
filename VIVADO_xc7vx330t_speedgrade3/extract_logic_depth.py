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

p_find = subprocess.Popen('find . -name "run.tcl"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
for run_loc in p_find.stdout.readlines():
    run_loc = run_loc.rstrip()
    designname = run_loc.split('/')[1]
    dir_loc = run_loc.split("run.tcl")[0]
    with cd(dir_loc):
        os.system("vivado -mode tcl -source ../extract_pr_logic_depth.tcl | tee postroute_logic_depth.txt")
        os.system("vivado -mode tcl -source ../extract_ps_logic_depth.tcl | tee postsynth_logic_depth.txt")
	

        
