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
mkdir -p $bak_dir/.config/rofi ; mv ~/.config/rofi/config $_
mkdir -p $bak_dir/.config ; mv ~/.config/compton.conf $_
mkdir -p $bak_dir ; mv ~/.xinitrc $_

# symlink dotfiles
ln -sv $dot_dir/bashrc ~/.bashrc
ln -sv $dot_dir/bash_aliases ~/.bash_aliases
ln -sv $dot_dir/profile ~/.profile
ln -sv $dot_dir/gitconfig ~/.gitconfig
ln -sv $dot_dir/config/i3/config ~/.config/i3/config
mkdir -p ~/.config/rofi ; ln -sv $dot_dir/config/rofi/config $_/config
ln -sv $dot_dir/config/compton.conf ~/.config/compton.conf
ln -sv $dot_dir/xinitrc ~/.xinitrc