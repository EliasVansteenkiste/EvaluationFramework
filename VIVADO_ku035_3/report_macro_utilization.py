# written by Elias Vansteenkiste, january 28, 2015
import sys
import subprocess

p_find = subprocess.Popen('find . -name "postRoute.utilization.rpt"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

headers = ['Slices', '\t', '\t', 'Block RAM tiles', '\t','\t','DSPs','\t','\t','IOBs','\t','\t']
for header in headers:
    print header, "\t",
print
headers = ['used', 'total', 'utilization ratio', 'used', 'total','utilization ratio','used','total','utilization ratio','used','total','utilization ratio']
for header in headers:
    print header, "\t",
print
for rpt_loc in p_find.stdout.readlines():
    rpt_loc = rpt_loc.rstrip()
    designname = rpt_loc.split('/')[1]
    print designname, ",",
    p_grep = subprocess.Popen('grep "CLB" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
	#print line
	words = line.split()
	if words[1] == "CLB" and words[2] == "|":
		print words[3], ",",
		print words[7], ",",
		print words[9], ",",
        if words[2] == "LUTs":
		print words[4], ",",
		print words[8], ",",
		print words[10], ",",
    p_grep = subprocess.Popen('grep "Block RAM Tile" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        #print line
        words = line.split()
        if words[4] == "|":
		print words[5], ",",
		print words[9], ",",
		print words[11], ",",
    p_grep = subprocess.Popen('grep "DSPs" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        #print line
        words = line.split()
        if words[2] == "|":
                print words[3], ",",
                print words[7], ",",
                print words[9], ",",
    p_grep = subprocess.Popen('grep "Bonded IOB" '+rpt_loc, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p_grep.wait()
    lines = p_grep.stdout.readlines()
    for line in lines:
        words = line.split()
        if words[3] == "|":
                print words[4], ",",
                print words[8], ",",
                print words[10], 

    print
