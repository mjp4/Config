#alias covlx3='tmux split-window "ssh -t covlx3 \"tmux -2 attach || tmux -2 new\""'
alias du1='du --max-depth=1'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias Gstatus='tmux split-window -h "watch --color \"git diff --color --cached | ~/bin/ccut\""; vim -c "Gstatus | bd 1" _'

function http-serve {
  if [ -z "$1" ] || [ "$1" == "80" ]; then
    sudo python -m SimpleHTTPServer 80
  else
    python -m SimpleHTTPServer "$1"
  fi
}

function s {
    git status 2>/dev/null ||
        if [ `ls -1 | wc -l` -lt 15 ]; then
            ll
        else
            l
        fi
}

alias sshOTPSimulators='sshpass -p !clearwater ssh clearwater@192.168.168.167 -t tmux attach-session -t otp'

# SSH with key-copy
function sshwc {
    if grep 'Permission denied' <(ssh -o PreferredAuthentications=publickey $@ exit 2>/dev/stdout) > /dev/null; then
        sshpass -p\!clearwater ssh-copy-id $@ || sshpass -p\!bootstrap ssh-copy-id $@ || ssh-copy-id $@
    fi
    ssh $@
}

# SSH with auto-tmux
function ssht {
    if [ -z "$1" ]; then
        echo "usage: $0 <hostname>";
        exit 1;
    fi
    $(which ssh) "$@" -t "sh -c 'tmux a || tmux'";
    return $?
}

# With auto completion
if [ -f /usr/share/bash-completion/completions/ssh ]; then
    source /usr/share/bash-completion/completions/ssh
    complete -F _ssh sshwc
    complete -F _ssh ssht
fi

function ls {
    # Uses second parameter, as ls is automatically aliased to ls --color=auto
    if [ "$#" -eq 2 ] && [ -f "$2" ]; then
        less $2
    else
        command ls $@
    fi
}

function iplist {
    for a in `seq $1 $2`; do
        for b in `seq $3 $4`; do
            for c in `seq $5 $6`; do
                for d in `seq $7 $8`; do
                    echo $a.$b.$c.$d
                done
            done
        done
    done
}
