# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess

p_find = subprocess.Popen('find . -name "postsynth_logic_depth.txt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

print
for rpt_loc in p_find.stdout.readlines():
    max_ll = -1
    wns_ll = -1
    total_ll = 0
    no_ll = 0
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    print designname,
    p_grep = subprocess.Popen('grep "logic_levels" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    lines = p_grep.stdout.readlines()
    for line in lines:
	words = line.split("|")
        if len(words)>1:
            fragment = words[1].split()
            if fragment[1] != "$logic_levels":
                ll = int(fragment[1])
                if wns_ll < 0:
                    wns_ll = ll
                if max_ll < ll:
                    max_ll = ll
                total_ll += ll
                no_ll+=1
    print max_ll, wns_ll, total_ll, no_ll,
    if no_ll>0:
        print 1.0*total_ll/no_ll,
    p_grep.communicate()
    print
