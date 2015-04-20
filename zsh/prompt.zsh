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
<<<<<<< Updated upstream
    if [[ $(id -u) -eq 0 ]]; then
      echo "%{$fg[brightred]%}root%{$reset_color%}"
    else
      echo $(whoami)
=======
    if [[ $UID -eq 0 ]]; then
      echo "%{$fg[brightred]%}root%{$reset_color%}"
    else
      echo "%{$fg[green]%}$(whoami)%{$reset_color%}"
>>>>>>> Stashed changes
    fi
  fi
}

current_machine() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
<<<<<<< Updated upstream
    echo "%m"
=======
    echo "%{$fg[green]%}%m%{$reset_color%}"
>>>>>>> Stashed changes
  fi
}

directory_name() {
<<<<<<< Updated upstream
  echo ":%3~"
=======
    echo "%{$fg[magenta]%}:%3~%{$reset_color%}"
    if [[ $(has_git) == true ]]; then
        echo %{$fg[green]%}•%{$reset_color%}
    fi
>>>>>>> Stashed changes
}

prompt_symbol() {
  echo "%{$reset_color%}%{%F{brightyellow}%}ᛄ%{$reset_color%}"
}

git_quickinfo() {
<<<<<<< Updated upstream
  echo "$(git_branch)"
}

last_exitcode() {
  echo "%(?.. %{%F{brightred}%}%?⏎%{$reset_color%})"
=======
    if [[ $(has_git) == true ]]; then
        echo $(git_branch) $(git_remote_status) $(git_stashcount)
    else
        echo ""
    fi
    #git status &> /dev/null;
    #if [[ !$ -eq 0 ]]; then
    #    echo $(git_branch) $(git_remote_status) $(git_stashcount)
    #else
    #    echo ""
    #fi
}

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_stashcount() {
  local count
  count=$(git stash list 2>/dev/null | wc -l)
  if [[ $count -gt 0 ]]; then
      echo "(⛁ $count)"
  else
      echo ""
  fi
>>>>>>> Stashed changes
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

