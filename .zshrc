# Changing directories
setopt AUTO_CD

# Expansion and globbing
setopt NO_CASE_GLOB
setopt GLOB_DOTS

# History 
HISTFILE=$HOME/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
setopt SHARE_HISTORY # share history across multiple zsh sessions
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit

# Prompt settings
PROMPT='%B%F{cyan}%n@%m%f%b %F{242}%3~%f %B%(!.%(?.%F{green}#.%F{red}#).%(?.%F{green}>.%F{red}>))%f%b '

# Autocomplete
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

zstyle ':completion:*' menu select=0
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' \
                                    '+l:|=* r:|=*'

autoload -Uz compinit
compinit

# Aliases
alias     ll='ls -lahGF'
alias   grep='grep --color=auto'
alias  ibrew='arch -x86_64 /usr/local/bin/brew'

alias cernvnc='/Applications/TigerVNC\ Viewer\ 1.11.0.app/Contents/MacOS/TigerVNC\ Viewer micgate02.cern.ch:84 -via lxtunnel'
alias vncgivepass='read -s "?VNC password:" VNC_PASSWORD ; export VNC_PASSWORD'

# Path
export PATH=/opt/homebrew/opt/python@3.11/libexec/bin:$PATH

# Fzf
[ -f ~/.fzf ] && source ~/.fzf
