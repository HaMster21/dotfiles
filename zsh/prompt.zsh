autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

precmd() {
  export PROMPT=$'$(directory_name) $(need_push)\n$(prompt_symbol) ' 
  export RPROMPT="%{$fg_bold[cyan]%}$(git_branch) $(git_quickinfo)%{$reset_color%}"
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

git_quickinfo() {
  echo ""
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%n@%M:%3~%{$reset_color%}"
}

prompt_symbol() {
  echo "%{%F{green}%}ᛄ%{$reset_color%}"
}


