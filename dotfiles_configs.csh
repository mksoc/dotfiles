# Shared list of configs tracked by link_base.csh and init_project.csh.
# To add a new config, add one line here - nothing else needs to change.
#
# Format per entry: "<path-in-repo>:<path-relative-to-a-homedir>"
set DOTFILES_CONFIGS = ( \
    "zsh/.zshrc:.zshrc" \
    "zsh/.zshrc.cern-mic:.zshrc.cern-mic" \
    "lazygit/config.yml:.config/lazygit/config.yml" \
)
