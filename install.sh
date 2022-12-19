#! /bin/zsh

make_backup () {
    if [ -f $HOME/$1 ]; then
        mv $HOME/$1 $HOME/$1.bak
    fi
}

# Create symlinks
make_backup .zshrc
ln -s $(realpath ./.zshrc) $HOME

make_backup .config/nvim
ln -s $(realpath ./nvim) $HOME/.config
