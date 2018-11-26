#!/bin/bash

# set dotfiles directory
dot_dir=~/dotfiles
bak_dir=~/.dots_bak

# backup old dotfiles
mkdir $bak_dir
mv ~/.bashrc $bak_dir
mv ~/.bash_aliases $bak_dir
mv ~/.profile $bak_dir
mv ~/.gitconfig $bak_dir

# symlink dotfiles
ln -sv $dot_dir/bashrc ~/.bashrc
ln -sv $dot_dir/bash_aliases ~/.bash_aliases
ln -sv $dot_dir/profile ~/.profile
ln -sv $dot_dir/gitconfig ~/.gitconfig
