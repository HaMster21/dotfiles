export EDITOR="vim"

setopt beep
setopt autocd        # changing to local folders without cd
setopt prompt_subst  # enabling prompt adaption
bindkey -v           # using vi keymap

# --- history settings ---
  HISTFILE=~/.zsh/histfile
  HISTSIZE=1000
  SAVEHIST=1000

# --- zsh modules ---
  zstyle :compinstall filename '/home/hamster/.zshrc'

  # automatically load the completion system
  autoload -Uz compinit
  compinit
  # automatically loat the prompt expansion system
  autoload -U promptinit
  promptinit

  # autoload color packages
  autoload colors zsh/terminfo
  if [[ "$terminfo[colors]" -ge 8 ]]; then 
    colors 
  fi

  # use colors like everyone else for completions
  zmodload -i zsh/complist
  zstyle ':completion:*' list_colors ${(s.:.)LS_COLORS}

# --- personal aliases ---
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

  # files
  alias -s d=vim
  alias -s xml=vim
  alias -s zsh=vim
  alias -s sh=vim

# --- automatic extension ---
  source ~/Entwicklung/dotfiles/zsh/antigen.zsh

  antigen bundle git
  antigen bundle git-extras
  antigen bundle git-prompt
  antigen bundle git-flow
  antigen bundle github

  antigen bundle docker
  antigen bundle debian
  antigen bundle gpg-agent
  antigen bundle sudo
  antigen bundle tmux
  antigen bundle vundle

  antigen bundle zsh-users/zsh-syntax-highlighting
  
  antigen theme HaMster21/dotfiles zsh/topdesk
  
  antigen apply

