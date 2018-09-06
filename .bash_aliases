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

# SSH with key-copy
function sshwc {
    if grep 'Permission denied' <(ssh -o PreferredAuthentications=publickey $@ exit 2>/dev/stdout) > /dev/null; then
        sshpass -p\!clearwater ssh-copy-id mjp4@$@ || sshpass -p\!clearwater ssh-copy-id clearwater@$@ || sshpass -p\!bootstrap ssh-copy-id root@$@ || sshpass -p\!ubuntu ssh-copy-id ubuntu@$@ || ssh-copy-id $@
    fi
    ssh -o PreferredAuthentications=publickey $@ || ssh -o PreferredAuthentications=publickey mjp4@$@ || ssh -o PreferredAuthentications=publickey clearwater@$@ || ssh -o PreferredAuthentications=publickey root@$@ || ssh -o PreferredAuthentications=publickey ubuntu@$@
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

# Use cwc-make by default (https://metacom2.metaswitch.com/confluence/x/YYupAg)
alias make=cwc-make
