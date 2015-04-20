precmd() {
    export RPROMPT="$(git_quickinfo)$(last_exitcode)"
    export PROMPT="$(current_user)@$(current_machine)$(directory_name)$(prompt_symbol) "
}

current_user() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    if [[ $(id -u) -eq 0 ]]; then
      echo "%{$fg[brightred]%}root%{$reset_color%}"
    else
      echo "$(whoami)"
    fi
  fi
}

current_machine() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    echo "%{$fg[green]%}%m%{$reset_color%}"
  fi
}

directory_name() {
    echo "%{$fg[magenta]%}:~%{$reset_color%}"
    if [[ $(has_git) == true ]]; then
        echo %{$fg[green]%}•%{$reset_color%}
    fi
}

prompt_symbol() {
  echo "\n%{$fg[green]%}ᛄ%{$reset_color%}"
}

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {"print $NF"})
}

git_stashcount() {
  local count
  count=$(git stash list 2>/dev/null | wc -l)
  if [[ $count -gt 0 ]]; then
      echo "(⛁ $count)"
  else
      echo ""
  fi
}

git_remote_status() {
    local rstatus
    rstatus=$(git rev-list --count --left-right --boundary @{u}... 2>/dev/null)
    echo $rstatus
    #echo $($rstatus | grep < | wc -l)⇅$($rstatus | grep > | wc -l)
}

