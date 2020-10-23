#!/usr/bin/env python3

import re

file = './unsorted.txt'

master_list = {}
byte_total = -1

with open(file, 'r') as f:
    for i, line in enumerate(f):
        if 'byte' in line:
            byte_total = [int(s) for s in re.findall(r'\b\d+\b', line)][0]
            if byte_total not in master_list:
                master_list[byte_total] = [line]
        elif line:
            master_list[byte_total].append(line)

file = './sorted.txt'
sorted_list = sorted(master_list.items(), key=lambda x: x[0], reverse=True)
with open(file, 'w') as f:
    for arr in sorted_list:
        for i, line in enumerate(arr[1]):
            if '\n' not in line:
                f.write(''.join([line,'\n\n']))
            else:
                f.write(line)
