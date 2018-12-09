#!/usr/bin/python3

import sys

with open(sys.argv[1], 'r') as in_file:
    with open(sys.argv[2], 'w') as out_file:
        for line in in_file.readlines():
            fields = line.split(' ')
            if '*.' in fields[0]:
                out_file.write('#define {} {}'.format(fields[0].strip('*.:').upper(), fields[-1]))
            else:
                out_file.write('{}'.format(line))