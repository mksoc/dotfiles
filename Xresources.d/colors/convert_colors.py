#!/usr/bin/python3

import argparse


def xres2def(line):
    fields = line.split(' ')
    if '*.' in fields[0]:
        return '#define {} {}'.format(fields[0].strip('*.:').upper(),
                                      fields[-1])
    else:
        return line


def def2xres(line):
    fields = line.split(' ')
    if fields[0] == '#define':
        return '*.{}: {}'.format(fields[1].lower(), fields[-1])
    else:
        return line


def def2vscode(line):
    setting_prefix = 'terminal.ansi'
    color_names = ('Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta',
                   'Cyan', 'White', 'BrightBlack', 'BrightRed', 'BrightGreen',
                   'BrightYellow', 'BrightBlue', 'BrightMagenta',
                   'BrightCyan', 'BrightWhite')
    fields = line.split(' ')
    if fields[0] == '#define' and 'COLOR' in fields[1]:
        return '"{}{}": "{}",\n'.format(setting_prefix,
                                        color_names[int(fields[1].
                                                        split('R')[1])],
                                        fields[2].strip())


# define command line arguments
parser = argparse.ArgumentParser(description='Convert colors schemes in different formats.')

parser.add_argument('input', help='input file', type=argparse.FileType('r'))
parser.add_argument('output', help='output file', type=argparse.FileType('w'))

group = parser.add_mutually_exclusive_group(required=True)
group.add_argument('-d', '--xres2def', help='convert from Xresources to #defines', action='store_true')
group.add_argument('-x', '--def2xres', help='convert from #defines to Xresources', action='store_true')
group.add_argument('-v', '--def2vscode', help='convert from #defines to VSCode JSON', action='store_true')

args = parser.parse_args()

# convert
for line in args.input.readlines():
    if args.xres2def:
        args.output.write(xres2def(line))
    elif args.def2xres:
        args.output.write(def2xres(line))
    elif args.def2vscode:
        args.output.write(def2vscode(line))

args.input.close()
args.output.close()
