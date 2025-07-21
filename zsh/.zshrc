###############
# ZSH OPTIONS #
###############

# Expansion and globbing
setopt NO_CASE_GLOB
setopt GLOB_DOTS

# History 
HISTFILE=$HOME/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
setopt HIST_IGNORE_ALL_DUPS

##########
# PROMPT #
##########
function get_git_status {
    local statc="%F{white}" # assume clean
    local icon=""
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
            statc="%F{yellow}"
        else
            statc="%F{white}"
        fi

        if $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
            statc="%F{red}"
            icon=""
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
            icon=""
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
            icon=""
        else
            icon=""
        fi

        echo -n "$statc $bname$icon%f"
    fi
}

setopt PROMPT_SUBST

PROMPT="%B%F{cyan}%n@%m%f%b %F{242}%3~%f $(get_git_status) %(?.%F{green}>%f.%F{94}💩%f) "

###########
# ALIASES #
###########
alias ll='ls -lahFH --color=auto'
alias grep='grep --color=auto'
alias free='free -h'
alias df='df -h'

#################
# CUSTOM CONFIG #
#################
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f /homedir/mandorno/.zshrc.cern-mic ] && source /homedir/mandorno/.zshrc.cern-mic
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
