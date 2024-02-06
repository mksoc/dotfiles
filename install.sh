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

    cern-mic)
        make_backup .zshrc.cern-mic
        ln -snf $(realpath ./zsh/.zshrc.cern-mic) $HOME
        ;;

    cern-pc)
        make_backup .zshrc.cern-pc
        ln -snf $(realpath ./zsh/.zshrc.cern-pc) $HOME
        ;;

    server)
        make_backup .zshrc.server
        ln -snf $(realpath ./zsh/.zshrc.server) $HOME
        ;;

    *)
        ;;
esac