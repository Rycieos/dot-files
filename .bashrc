# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc. To make all shells read ~/.bashrc, load it in ~/.bash_profile

export EDITOR=vim
export TERM="xterm-256color"
[[ -d ~/bin ]] && export PATH=~/bin:$PATH

# The following lines are only for interactive shells
[[ $- = *i* ]] || return

# Function for getting amount of mail in inbox for prompt
_new_mail() {
    if [ -n "$MAIL" ]; then
        NEWMAIL=`cat $MAIL | grep '^Subject: ' | wc -l`
        if [ $NEWMAIL -gt -0 ]; then
            echo "${NEWMAIL}m "
        fi
    fi
}

# Make a directory and move to it
function md() {
    mkdir $1
    cd $1
}

function dirdo() {
    for D in */; do
        cd "$D"
        pwd
        for var in "$@"; do
            $var
        done
        cd ..
    done
}

# Use the system config if it exists
[[ -r /etc/bashrc            ]] && . /etc/bashrc
[[ -r /etc/bash.bashrc       ]] && . /etc/bash.bashrc

# Basic PS1 in case liquidprompt does not load
export PS1="[\u@\h:\w] \$?\\$ \[$(tput sgr0)\]"

[[ -r /usr/local/bin/liquidprompt/liquidprompt ]] && source /usr/local/bin/liquidprompt/liquidprompt
[[ -r /etc/bash_completion   ]] && . /etc/bash_completion
[[ -d /etc/bash_completion.d ]] && . /etc/bash_completion.d/*
[[ -r ~/.alias               ]] && . ~/.alias

# Enable auto-complete after sudo and man
complete -cf sudo
complete -cf man

# Disable terminal bell
# Many machines don't have setterm
hash setterm 2>/dev/null && setterm -bfreq 0

# If the output is smaller than the screen height is smaller,
# less will just cat it
export LESS="-FX -R"

# Alias
echo "" | which -i which >/dev/null 2>&1 && alias which='alias | /usr/bin/which -i --tty-only --show-dot --show-tilde'
alias realias='vim ~/.bashrc; source ~/.bashrc'
alias ls='ls --color'
alias ll='ls --color -lAh'
alias la='ls --color -lah'
alias df='df -h'
alias du='du -hs'
alias dus='du -hs * | sort -h'
alias please='sudo $(history -p !!)'
alias cd..='cd ..'
alias netstat='ss -rput'
alias path='echo $PATH | tr ":" "\n"'

# Load machine local config
[[ -r ~/.bash_local ]] && source ~/.bash_local || true
