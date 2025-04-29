# ls 
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# kubeclt 
alias kc='kubectl'
alias mkc='microk8s kubectl'

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