#alias covlx3='tmux split-window "ssh -t covlx3 \"tmux -2 attach || tmux -2 new\""'
alias du1='du --max-depth=1'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias Gstatus='tmux split-window -h "watch --color  git diff --color --cached"; vim -c "Gstatus | bd 1" _'

function s { git status 2>/dev/null || if [ `ls -1 | wc -l` -lt 15 ]; then ll; else l; fi; }
