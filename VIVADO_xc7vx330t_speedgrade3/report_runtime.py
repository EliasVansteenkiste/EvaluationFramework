# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess

def seconds(scnotstr):
    words = scnotstr.split(":")
    return 3600*int(words[0])+60*int(words[1])+int(words[2])

p_find = subprocess.Popen('find . -name "output_auto.txt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    print designname, ",",
    p_grep = subprocess.Popen('grep "synth_design:" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
	words = line.split()
	if words[0] == "synth_design:" and words[1]=="Time":
		print seconds(words[5]), " - ",
                print seconds(words[9]), ", ",
		break
    p_grep = subprocess.Popen('grep "place_design:" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        words = line.split()
        if words[0] == "place_design:" and words[1]=="Time":
		print seconds(words[5]), " - ",
                print seconds(words[9]), ", ",
                break
    p_grep = subprocess.Popen('grep "route_design:" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        words = line.split()
        if words[0] == "route_design:" and words[1]=="Time":
		print seconds(words[5]), " - ",
                print seconds(words[9]), ", ",
                break
    print

