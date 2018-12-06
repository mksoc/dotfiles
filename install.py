#!/usr/bin/python3

from glob import glob
from pathlib import Path
import os


def mkdir(path):
    if not os.path.exists(path):
        os.makedirs(path)


def ask_user(question):
    while True:
        choice = input('{} (Y/n): '.format(question))
        if choice in ('', 'y', 'Y', 'yes', 'Yes', 'YES'):
            return True
        elif choice in ('n', 'N', 'no', 'No', 'NO'):
            return False
        else:
            print('Invalid option. Try again.')


# set repo root directory
repo_name = 'dotfiles'
cwd = os.getcwd()
repo_root = cwd[0:cwd.find(repo_name) + len(repo_name)]

# set home directory
home = str(Path.home())

# get list of dotfiles
dotfiles_in_repo = []
for root, dirs, files in os.walk(repo_root):
    if '.git' in dirs:
        dirs.remove('.git')
    dotfiles_in_repo.extend([os.path.join(root, f) for f in files if f not in ('install.py', 'install.sh', 'todo.txt', 'README', 'colorscheme-manjaro-default')])

# remove absolute path and add a leading dot
dotfiles_relative = [item.replace('{}/'.format(repo_root), '.') for item in dotfiles_in_repo]

# create backup directory
backup_dir = '{}/.dots_bak'.format(home)
mkdir(backup_dir)

# backup and install files
for item in dotfiles_relative:
    if ask_user('Install {}?'.format(item)):
        home_file = '{}/{}'.format(home, item)
        # backup 
        bak_file = '{}/{}'.format(backup_dir, item)
        if os.path.isfile(home_file):
            mkdir(bak_file[0:bak_file.rindex('/')])
            os.rename(home_file, bak_file)
            print('\t{} backed up to {}'.format(home_file, bak_file))
        # symlink
        new_file = dotfiles_in_repo[dotfiles_relative.index(item)]
        mkdir(home_file[0:home_file.rindex('/')])
        os.symlink(new_file, home_file)
        print('\t{} symlinked to {}'.format(new_file, home_file))
    else:
        pass
    
