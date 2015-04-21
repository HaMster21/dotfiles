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
      echo "%{$fg[magenta]%}$(whoami)%{$reset_color%}"
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
    local dir
    dir="%{$fg[magenta]%}:%~%{$reset_color%}"
    if [[ $(has_git) == true ]]; then
        dir="$dir%{$fg[green]%}•%{$reset_color%}"
    else
        dir="$dir%{$fg[red]%}•%{$reset_color%}"
    fi
    echo "$dir"
}

prompt_symbol() {
  echo "\n%{$fg[green]%}ᛄ%{$reset_color%}"
}

git_quickinfo() {
    echo "$(git_branch)"
}

last_exitcode() {
    echo " %(?.. %{%F{brightred}%?↲%{$reset_color%})"
}

has_git() {
    if [[ -n $(git_branch) ]]; then
        return false
    else
        return true
    fi
}

git_branch() {
    local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "${ref#/refs/heads/}"
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
    echo "$rstatus"
    #echo $($rstatus | grep < | wc -l)⇅$($rstatus | grep > | wc -l)
}

