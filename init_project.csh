#!/bin/tcsh
#
# Symlink base-homedir dotfiles into a per-project homedir.
# Tracked configs live in dotfiles_configs.csh - add a line there to track
# a new file, no changes needed here.
#
# Usage: init_project.csh <group> <project> <version>
#    or: init_project.csh <full_project_base_path>
#
# Links go from $HOME/<path> to:
#   <project_base>/workAreas/$USER/homedir/$USER/<path>
# That project homedir is expected to already exist.

set SCRIPT_PATH = `readlink -f $0`
set REPO_ROOT = $SCRIPT_PATH:h
source $REPO_ROOT/dotfiles_configs.csh

if ($#argv == 1) then
    set PROJECT_BASE = $argv[1]
else if ($#argv == 3) then
    set PROJECT_BASE = /projects/$argv[1]/$argv[2]/$argv[3]
else
    echo "Usage: $0 <group> <project> <version>"
    echo "   or: $0 <full_project_base_path>"
    exit 1
endif

set PROJECT_HOMEDIR = $PROJECT_BASE/workAreas/$USER/homedir/$USER

if ( ! -d $PROJECT_HOMEDIR ) then
    echo "Error: project homedir does not exist: $PROJECT_HOMEDIR"
    echo "(expected workAreas/$USER/homedir/$USER to already be set up)"
    exit 1
endif

foreach entry ( $DOTFILES_CONFIGS )
    set home_rel = `echo $entry | awk -F: '{print $2}'`

    set src = $HOME/$home_rel
    set dest = $PROJECT_HOMEDIR/$home_rel

    if ( ! -e $src ) then
        echo "Skipping $home_rel: not found in base homedir ($src) - run link_base.csh first?"
        continue
    endif

    set dest_dir = $dest:h
    if ( ! -d $dest_dir ) then
        mkdir -p $dest_dir
    endif

    if ( -e $dest && ! -l $dest ) then
        echo "Backing up existing $dest -> $dest.bak"
        mv $dest $dest.bak
    endif

    echo "Linking $src -> $dest"
    ln -snf $src $dest
end
