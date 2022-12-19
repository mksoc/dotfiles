#! /bin/zsh

make_backup () {
    candidate=$HOME/$1
    if [ -e $candidate ] && [ ! -L $candidate ]; then
        mv $candidate $candidate.bak
    fi
}

# Create symlinks
echo "Copying Zsh config..."
make_backup .zshrc
ln -snf $(realpath ./zsh/.zshrc) $HOME

case $1 in
    mac)
        make_backup .zshrc.mac
        ln -snf $(realpath ./zsh/.zshrc.mac) $HOME
        ;;

    cern)
        make_backup .zshrc.cern
        ln -snf $(realpath ./zsh/.zshrc.cern) $HOME
        ;;

    server)
        make_backup .zshrc.server
        ln -snf $(realpath ./zsh/.zshrc.server) $HOME
        ;;

    *)
        ;;
esac

echo "Copying Neovim config..."
make_backup .config/nvim
ln -snf $(realpath ./nvim) $HOME/.config
