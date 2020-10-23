#!/usr/bin/env python3

from random import randint

file = './unsorted.txt'

with open(file, 'w') as f:
    for i in range(int(1e7)):
        byte = randint(0,int(1e5))
        f.write(''.join([str(byte), ' bytes each:\n']))
        for j in range(randint(1,20)):
            f.write(''.join(['./test/hi/cool/not-a-directory.', str(byte),'\n']))
        f.write('\n')


