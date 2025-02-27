PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )%(1j.%F{red}[%j] %f.)%{$fg[cyan]%}%(5~|%-1~/…/%3~|%4~)%{$reset_color%}"

GIT_USER_DEFAULT="" # Change to most used git user email
GIT_USER_PERSONAL="" # Change to personal git email if not default

git_user () {
  if [[ $(git_current_user_email) == "$GIT_USER_PERSONAL" ]] then;
    echo "%{$fg[blue]%}personal@"
  elif [[ $(git_current_user_email) != "$GIT_USER_DEFAULT" ]] then;
    echo "%{$fg[blue]%}$(git_current_user_email)@"
  fi
  return 0
}


PROMPT+=' $(git_user)$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
