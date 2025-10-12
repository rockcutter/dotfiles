# ls 
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# kubectl 
alias kc='kubectl'
alias mkc='microk8s kubectl'

# microk8sが存在する場合、kubectlコマンドをmicrok8s kubectlにエイリアス
if command -v microk8s >/dev/null 2>&1; then
    alias kubectl='microk8s kubectl'
fi

# docker 
alias dc='docker compose'
alias d='docker'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

function hist(){
    local greps=""

    for arg in "$@"; do
        greps="$greps | grep $arg"
    done

    eval "history $greps"
}
