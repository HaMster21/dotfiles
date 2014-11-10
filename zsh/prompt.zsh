precmd() {
    export RPROMPT='$(git_quickinfo)$(last_exitcode)'
    export PROMPT='$(current_user)@$(current_machine)$(directory_name)$(prompt_symbol) '

}

current_user() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    if [[ $(id -u) -eq 0 ]]; then
      echo %{$fg[brightred]%}root%{$reset_color%}
    else
      echo %{$fg[green]%}$(whoami)%{$reset_color%}
    fi
  fi
}

current_machine() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    echo %{$fg[green]%}%m%{$reset_color%}
  fi
}

directory_name() {
  echo %{$fg[magenta]%}:%3~%{$reset_color%}
}

prompt_symbol() {
  echo "\n%{$fg[green]%}ᛄ%{$reset_color%}"
}

last_exitcode() {
  echo "%(?..%{$fg[red]%} %?⏎%{$reset_color%})"
}

git_quickinfo() {
    git status &> /dev/null
    if [[ !$ -eq 0 ]]; then
        echo $(git_branch) $(git_stashcount)
    else
        echo ''
    fi
}

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_stashcount() {
  local count
  count=$(git stash list 2>/dev/null | wc -l)
  if [[ $count -gt 0 ]]; then
      echo $count
  else
      echo ''
  fi
}
