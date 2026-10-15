###############
# ENVIRONMENT #
###############

# Drop duplicate entries from PATH and FPATH
typeset -U path fpath

# Homebrew (macOS)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

path=("$HOME/.local/bin" $path)

[[ $OSTYPE == darwin* ]] && export CLICOLOR=1

###############
# ZSH OPTIONS #
###############

# Expansion and globbing
setopt NO_CASE_GLOB
setopt GLOB_DOTS
setopt EXTENDED_GLOB

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE  # don't save commands starting with a space
setopt HIST_REDUCE_BLANKS

##########
#  VCS   #
##########
autoload -Uz add-zsh-hook vcs_info

# Run the `vcs_info` hook to grab git info before displaying the prompt
add-zsh-hook precmd vcs_info

# Style the vcs_info message
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %b%u%c%m'
# Format when the repo is in an action (merge, rebase, etc)
zstyle ':vcs_info:git*' actionformats '%F{14}⏱ %*%f'
zstyle ':vcs_info:git*' unstagedstr '*'
zstyle ':vcs_info:git*' stagedstr '+'
# This enables %u and %c (unstaged/staged changes) to work,
# but can be slow on large repos
zstyle ':vcs_info:*:*' check-for-changes true

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( " ${ahead}" )
    (( $behind )) && gitstatus+=( " ${behind}" )

    if [[ -n $gitstatus ]]; then
        hook_com[misc]+=" ${(j::)gitstatus}"
    fi
}

function git_colorize() {
  if [[ "$vcs_info_msg_0_" == *\** || "$vcs_info_msg_0_" == *+* || "$vcs_info_msg_0_" == ** || "$vcs_info_msg_0_" == ** ]]; then
    echo "%F{yellow}${vcs_info_msg_0_}%f"
  else
    echo "%F{green}${vcs_info_msg_0_}%f"
  fi
}

##########
# PROMPT #
##########
setopt PROMPT_SUBST
PROMPT='%B%F{cyan}%n@%m%f%b %F{242}%3~%f $(git_colorize) %(?.%F{green}>%f.%F{94}💩%f) '

###########
# ALIASES #
###########
alias ll='ls -lahFH --color=auto'
alias grep='grep --color=auto'
alias free='free -h'
alias df='df -h'
alias lg=lazygit

#################
# CUSTOM CONFIG #
#################
[ -f /homedir/mandorno/.zshrc.cern-mic ] && source /homedir/mandorno/.zshrc.cern-mic
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.server ] && source ~/.zshrc.server
[ -f ~/.zshrc.cern-pc ] && source ~/.zshrc.cern-pc

###########
# BINDKEY #
###########
bindkey -e
bindkey "^[[3~" delete-char         # Del
bindkey "^[[H" beginning-of-line    # Home 
bindkey "^[OH" beginning-of-line    # Home
bindkey "\033[1~" beginning-of-line # Home
bindkey "^[[F" end-of-line          # End
bindkey "^[OF" end-of-line          # End
bindkey "\033[4~" end-of-line       # End
bindkey "^[[1;3D" beginning-of-line # Cmd + left
bindkey "^[[1;3C" end-of-line       # Cmd + right

################
# AUTOCOMPLETE #
################
zstyle ':completion:*' menu select=0
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+l:|=* r:|=*'
zstyle ':completion:*' completer _complete _ignored _files

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''

autoload -Uz compinit
compinit

unset '_comps[source]'

#######
# FZF #
#######
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null; then # fzf >= 0.48
    source <(fzf --zsh)
elif [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
elif [[ -f /homedir/mandorno/.fzf.zsh ]]; then # cern-mic, where $HOME may be a project dir
    source /homedir/mandorno/.fzf.zsh
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then # Debian/Ubuntu package
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi
