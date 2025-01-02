# Begin Oh My Zsh configuration -------------------------------------------------
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

: ${ZSH_THEME:="suvash"}
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User onfiguraitons 

## zsh -------------------------------------------------
unsetopt auto_menu

## aliases -------------------------------------------------

alias tm='tmux'
alias ll='ls -lah'

## fzf -------------------------------------------------
# if type fzf-tmux > /dev/null; then 
# 	alias fzf='fzf-tmux -p 80%'
# fi
# if $TMUX;then 
if [ -z "${(P)TMUX}" ];then 
	alias fzf='fzf-tmux -p 80%'
fi


## dotfile -------------------------------------------------
export DOTFILES_SOURCES_DIR=$HOME/dotfiles_sources
source $DOTFILES_SOURCES_DIR/*.sh

## aws configuration -------------------------------------------------

export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_SESSION_TOKEN_TTL=3h
export AWS_DEFAULT_OUTPUT="json"

export GPG_TTY=$(tty)

## 1password configuration -------------------------------------------------

alias ssh='ssh.exe'
alias ssh-add='ssh-add.exe'

## golang configuration -------------------------------------------------

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOBIN

## brew
export PATH=$PATH:/opt/homebrew/bin

## psql 
export PATH=$PATH:/opt/homebrew/opt/libpq/bin

## compose configuration
export PATH=$PATH:$HOME/.config/composer/vendor/bin
 
## history configuration -------------------------------------------------

# export HISTTIMEFORMAT='%y-%m-%dT%H:%M:%S '
export HISTIGNORE='&:ls:ll:pwd:history:hist:zsh'
export HISTSIZE=65535
export HISTFILESIZE=65535

setopt share_history
setopt hist_ignore_dups
setopt append_history
setopt hist_verify
setopt hist_expire_dups_first
setopt extended_glob
unsetopt hist_ignore_space

## Functions -------------------------------------------------
function repo(){
    cd $(ghq root)/$(ghq list | fzf --query="$LBUFFER" -e)
}

function ghu(){
    gh pr view --json url | jq
    gh repo view --json nameWithOwner,url | jq
}

function gadd(){
    git add $(git status -s | awk '{print $2}' | fzf -m --preview 'git diff -- {1}' | sed -e 's/\n/ /g');
    git status -s
}

function hist(){
	local COMMAND=$(\
		history -i | tail -r | \
		fzf --no-sort -e --preview 'echo {} | fold -s -$(tput cols)' --preview-window='down,wrap' | \
		awk '{$1=$2=$3="";print $0}')
	print -s "${COMMAND##[[:space:]]##}"
    echo $COMMAND
	eval $COMMAND

}

function histwc(){
	local COMMAND=$(\
		history -i | tac | \
		fzf --no-sort -e --preview 'echo {} -- | fold -s -$(tput cols)' --preview-window='down,wrap' | \
		awk '{$1=$2=$3="";print $0}')
	print -s "${COMMAND##[[:space:]]##}"
    echo '$COMMAND | clip.exe'
    echo $COMMAND | clip.exe
}

function avt() {
    local role="$1"
    shift
	aws-vault exec $role -- $@
}

function s3cp() {
    local role="$1"
    shift
	aws-vault exec $role -- aws s3 cp $@
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


## tmux configurations -------------------------------------------------
if which tmux >/dev/null 2>&1; then
	if [ -z $VSCODE_GIT_ASKPASS_MAIN ] && [ -z $DISABLE_TMUX_AUTOSTARTUP ]; then
		#if not inside a tmux session, and if no session is started, start a new session
		#もしtmuxの中にいないか起動していればサブシェルでアタッチ失敗したら新しいセッションを実行
		test -z "$TMUX" && (tmux attach -t main || tmux new-session -s main)
    fi
fi

## zoxide configurations -------------------------------------------------
eval "$(zoxide init zsh)"

## mise configurations -------------------------------------------------
eval "$(~/.local/bin/mise activate zsh)"

