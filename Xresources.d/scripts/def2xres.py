#!/usr/bin/python3

import sys

with open(sys.argv[1], 'r') as in_file:
    with open(sys.argv[2], 'w') as out_file:
        for line in in_file.readlines():
            fields = line.split(' ')
            if fields[0] == '#define':
                out_file.write('*.{}: {}'.format(fields[1].lower(), fields[-1]))
            else:
                out_file.write('{}'.format(line))