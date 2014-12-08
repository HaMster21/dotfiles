precmd() {
    export RPROMPT="$(git_quickinfo)$(last_exitcode)"
    export PROMPT="$(current_user)@$(current_machine)$(directory_name)$(prompt_symbol) "
}

current_user() {
  if [[ -n $SSH_CONNECTION ]]; then
    #react to running ssh session
  else
    if [[ $UID -eq 0 ]]; then
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
    if [[ $(has_git) == true ]]; then
        echo %{$fg[green]%}•%{$reset_color%}
    fi
}

prompt_symbol() {
  echo "\n%{$fg[green]%}ᛄ%{$reset_color%}"
}

last_exitcode() {
  echo "%(?..%{$fg[red]%} %?⏎%{$reset_color%})"
}

has_git() {
    if [[ -n $(git rev-parse --git-dir 2> /dev/null) ]]; then
        return false
#    elif [[ -z $(git rev-parse --work-dir) 2> /dev/null) ]]; then
#        return false
#    elif [[ -z $(git revparse 
    else 
        return true
    fi
}

git_quickinfo() {
    if [[ $(has_git) == true ]]; then
        echo $(git_branch) $(git_remote_status) $(git_stashcount)
    else
        echo ''
    fi
    #git status &> /dev/null;
    #if [[ !$ -eq 0 ]]; then
    #    echo $(git_branch) $(git_remote_status) $(git_stashcount)
    #else
    #    echo ''
    #fi
}

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_stashcount() {
  local count
  count=$(git stash list 2>/dev/null | wc -l)
  if [[ $count -gt 0 ]]; then
      echo '(⛁ $count)'
  else
      echo ''
  fi
}

git_remote_status() {
    local rstatus
    rstatus=$(git rev-list --count --left-right --boundary @{u}... 2>/dev/null)
    echo $rstatus
    #echo $($rstatus | grep < | wc -l)⇅$($rstatus | grep > | wc -l)
}

