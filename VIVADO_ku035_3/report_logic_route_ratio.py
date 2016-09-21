# written by Elias Vansteenkiste, April 7, 2015
import sys
import subprocess

p_find = subprocess.Popen('find . -name "postroute_timing_max.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
no_reports = 0
tlogic = 0.0
trouting = 0.0
for rpt_loc in p_find.stdout.readlines():
    no_reports += 1
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[-2]
    print designname,
    p_grep = subprocess.Popen('grep "Data Path Delay:" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    lines = p_grep.stdout.readlines()
    no_paths = 0
    logic = 0.0
    routing = 0.0
    for line in lines:
        no_paths += 1
	words = line.split()
        #print words[6][1:-2], words[9][1:-3]
        logic += float(words[6][1:-2])
        routing += float(words[9][1:-3])
    print logic/no_paths, routing/no_paths,
    tlogic += logic/no_paths
    trouting += routing/no_paths
    p_grep.communicate()
    print
print "------------------------------------"
print "Average logic share: ", tlogic/no_reports
print "Average routing share: ", trouting/no_reports
