#!/usr/bin/python3

import sys

setting_str = 'terminal.ansi'
setting_tuple = ('Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White', 'BrightBlack', 'BrightRed', 'BrightGreen', 'BrightYellow', 'BrightBlue', 'BrightMagenta', 'BrightCyan', 'BrightWhite')

with open(sys.argv[1], 'r') as in_file:
    with open(sys.argv[2], 'w') as out_file:
        for line in in_file.readlines():
            fields = line.split(' ')
            if fields[0] == '#define' and 'COLOR' in fields[1]:
                out_file.write('"{}{}": "{}",\n'.format(setting_str, setting_tuple[int(fields[1].split('R')[1])], fields[2].strip()))