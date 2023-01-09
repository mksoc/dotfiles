###############
# ZSH OPTIONS #
###############
# Changing directories
setopt AUTO_CD

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
PROMPT='%B%F{cyan}%n@%m%f%b %F{242}%3~%f %B%(!.%(?.%F{green}#.%F{red}#).%(?.%F{green}>.%F{red}>))%f%b '

###########
# ALIASES #
###########
alias ll='ls -lahGFH --color=auto'
alias grep='grep --color=auto'
alias free='free -h'
alias df='df -h'

alias glg='git log --stat --max-count=10'
alias glo='git log --oneline'
alias gpl='git pull'
alias gps='git push'
alias gca='git commit -am'
alias gcm='git commit -m'
alias gst='git status'

#################
# CUSTOM CONFIG #
#################
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.cern ] && source ~/.zshrc.cern
[ -f ~/.zshrc.server ] && source ~/.zshrc.server

################
# AUTOCOMPLETE #
################
bindkey "^[[3~" delete-char

zstyle ':completion:*' menu select=0
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' \
                                    '+l:|=* r:|=*'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''

autoload -Uz compinit
compinit
