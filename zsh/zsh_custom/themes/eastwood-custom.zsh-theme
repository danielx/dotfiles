#!/usr/bin/zsh

if [[ "$USER" != "$DEFAULT_USER" && -n "$SSH_CLIENT" ]]; then
  ZSH_PROMPT_USER_HOST="%{$fg[yellow]%}%n@%m%{$reset_color%} "
elif [[ "$USER" != "$DEFAULT_USER" ]]; then
  ZSH_PROMPT_USER_HOST="%{$fg[blue]%}%n%{$reset_color%} "
elif [[ -n "$SSH_CLIENT" ]]; then
  ZSH_PROMPT_USER_HOST="%{$fg[yellow]%}%m%{$reset_color%} "
else
  ZSH_PROMPT_USER_HOST=''
fi

# git symbols for the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"

# Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  GIT_CURRENT_BRANCH=$(git_current_branch)
  if [ -n "$GIT_CURRENT_BRANCH" ]; then
    echo "%{$fg[green]%}[$GIT_CURRENT_BRANCH]%{$reset_color%} $(parse_git_dirty)"
  fi
}

PROMPT='%{$fg[cyan]%}[%{$reset_color%}$ZSH_PROMPT_USER_HOST%{$fg[cyan]%}%~]%{$reset_color%}$(git_custom_status) '

