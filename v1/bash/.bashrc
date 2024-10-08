# begin user definition 
# historyのformat設定
export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S '
export HISTIGNORE='&:ls:ll:pwd:history:hist:bash'
export HISTSIZE=65535
export HISTFILESIZE=65535
# source
source ~/.git-prompt.sh
# source ~/.zellij.sh
# alias
alias lg='lazygit'
alias zj='zellij'
alias tm='tmux'
alias cd='z'
# func
function repo(){
    cd $(ghq root)/$(ghq list | fzf --query="$LBUFFER" -e)
}
function gadd(){
    git add $(git status -s | awk '{print $2}' | fzf -m --preview 'git diff -- {1}' | sed -e 's/\n/ /g');
    git status -s
}
function cdd(){
	if [ $# -eq 0 ]; then
		pushd ~ > /dev/null
	else
		pushd "$1" > /dev/null
	fi
}
function hist_completion(){
	local COMMAND=$(history | tac | fzf --no-sort -e | awk '{$1=$2=$3=""; print $0}')
	history -s $COMMAND
	READLINE_LINE="${COMMAND}"
	READLINE_POINT=${#COMMAND}
}
bind -x '"\C-r": hist_completion'
function hist(){
	local COMMAND=$(history | tac | fzf --no-sort -e | awk '{$1=$2=$3=""; print $0}')
	echo $COMMAND
	history -s $COMMAND
	eval $COMMAND
}
function histwc(){
	local COMMAND=$(history | tac | fzf --no-sort -e | awk '{$1=$2=$3=""; print $0}')
	echo '$COMMAND | clip.exe'
	echo $COMMAND | clip.exe
}
function aw(){
	aws-vault --backend=$AWS_VAULT_BACKEND exec rockcutter -- aws "$@"
}
function pane(){
	if [ $1 ]; then
	  cnt_pane=1
	  while [ $cnt_pane -lt $1 ]
	  do
		if [ $(( $cnt_pane & 1 )) ]; then
			tmux split-window -h
		else
			tmux split-window -v
		fi
		if [ $1 -ne 2 ]; then
			tmux select-layout tiled 1>/dev/null
		fi
		cnt_pane=$(( $cnt_pane + 1 ))
	  done
	fi
}

# env
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PROMPT_COMMAND="history -a;history -c;history -r"
export ZELLIJ_AUTO_ATTACH=true
export force_color_prompt=yes

## aws
export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_SESSION_TOKEN_TTL=3h
## go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOBIN

export GPG_TTY=$(tty)

# run cmd
shopt -u histappend
# end user definition

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='┏ ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] >> \[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 "[[\e[35m%s\e[39m]]") \e[31m(\t)\e[39m\n┗ \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h >> \w $(__git_ps1 "[[%s]]") (\t)\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zellij 自動起動
# $(zellij setup --generate-auto-start bash)
# if [[ -z "$ZELLIJ" ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c mz
#     else
#         zellij
#     fi
# 
#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi
eval "$(zoxide init bash)"
tmux
