#!/bin/tcsh
#
# Symlink dotfiles from this repo into a base homedir (default: $HOME).
# Tracked configs live in dotfiles_configs.csh - add a line there to track
# a new file, no changes needed here.
#
# Usage: link_base.csh [dest_homedir]
#   dest_homedir defaults to $HOME

set SCRIPT_PATH = `readlink -f $0`
set REPO_ROOT = $SCRIPT_PATH:h
source $REPO_ROOT/dotfiles_configs.csh

set DEST_HOME = $HOME
if ($#argv >= 1) then
    set DEST_HOME = $argv[1]
endif

if ( ! -d $DEST_HOME ) then
    echo "Error: destination homedir does not exist: $DEST_HOME"
    exit 1
endif

foreach entry ( $DOTFILES_CONFIGS )
    set repo_rel = `echo $entry | awk -F: '{print $1}'`
    set home_rel = `echo $entry | awk -F: '{print $2}'`

    set src = $REPO_ROOT/$repo_rel
    set dest = $DEST_HOME/$home_rel

    if ( ! -e $src ) then
        echo "Skipping $home_rel: source not found ($src)"
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
