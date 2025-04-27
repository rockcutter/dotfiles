alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

function hist(){
    local greps=""

    for arg in "$@"; do
        greps="$greps | grep $arg"
    done

    eval "history $greps"
}