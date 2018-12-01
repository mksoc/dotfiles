#!/usr/bin/python3
# For each dotfile in the repo:
# 1) check if it already exists locally and make backup
# 2) symlink new one

import glob

files = glob.glob('/home/marco/dotfiles' + '/**/*', recursive=True)
print(files)
