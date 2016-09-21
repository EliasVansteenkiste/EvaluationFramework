# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess

p_find = subprocess.Popen('find . -name "postplace_timing_max.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    print designname,
    p_grep = subprocess.Popen('grep "Data Path Delay:" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
	words = line.split()
	if words[0] == "Data" and words[1] == "Path" and words[2]=="Delay:":
		print words[3][0:-2]
		break
