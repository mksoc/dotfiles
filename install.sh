#!/bin/bash

# set dotfiles directory
dot_dir=~/dotfiles
bak_dir=~/.dots_bak

# backup old dotfiles
mkdir -p $bak_dir ; mv ~/.bashrc $_
mkdir -p $bak_dir ; mv ~/.bash_aliases $_
mkdir -p $bak_dir ; mv ~/.profile $_
mkdir -p $bak_dir ; mv ~/.gitconfig $_
mkdir -p $bak_dir/.config/i3 ; mv ~/.config/i3/config $_

# symlink dotfiles
ln -sv $dot_dir/bashrc ~/.bashrc
ln -sv $dot_dir/bash_aliases ~/.bash_aliases
ln -sv $dot_dir/profile ~/.profile
ln -sv $dot_dir/gitconfig ~/.gitconfig
ln -sv $dot_dir/config/i3/config ~/.config/i3/config
