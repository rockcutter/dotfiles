function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

function virtualenv_info {
    [[ -n "$VIRTUAL_ENV" ]] && echo ' ('${VIRTUAL_ENV:t}') '
}

# PROMPT='%F{red}%n%f at %F{yellow}%m%f in %B%F{green}%~%f%b at %F{red}%D{%Y-%m-%dT%H:%M:%S%z}%f
# $?$(git_prompt_info)$(virtualenv_info) $(prompt_char) '
PROMPT='%F{green}$ZSH_NEST_INDICATOR %F{red}%n%f at %F{yellow}%m%f at %F{red}%D{%Y-%m-%dT%H:%M:%S%z} %f
wd %B%F{green}%~%f%b
$?$(git_prompt_info)$(virtualenv_info) $(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=' %F{red}'
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY='%F{blue}*'
ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{green}?'
ZSH_THEME_GIT_PROMPT_CLEAN=''

