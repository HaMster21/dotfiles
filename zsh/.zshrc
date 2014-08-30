export EDITOR="vim"

HISTFILE=~/.zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -v

zstyle :compinstall filename '/home/hamster/.zshrc'

autoload -Uz compinit
compinit

# handy ls variations
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias  l='ls -CF'

# color grep
alias  grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# git operations
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gc='git commit'

# vim
alias v='vim -N'

# debian
alias update='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
