autoload -U promptinit && promptinit
autoload -U colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

precmd() {
  export PROMPT="$(current_user)@$(current_machine)$(directory_name)
$(prompt_symbol) "
  export RPROMPT="$(git_quickinfo)$(last_exitcode)"
}

current_user() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    if [[ $(id -u) -eq 0 ]]; then
      echo "%{$fg[brightred]%}root%{$reset_color%}"
    else
      echo $(whoami)
    fi
  fi
}

current_machine() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    echo "%m"
  fi
}

directory_name() {
  echo ":%3~"
}

prompt_symbol() {
  echo "%{$reset_color%}%{%F{brightyellow}%}ᛄ%{$reset_color%}"
}

git_quickinfo() {
  echo "$(git_branch)"
}

last_exitcode() {
  echo "%(?.. %{%F{brightred}%}%?⏎%{$reset_color%})"
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

