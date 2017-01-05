# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc. To make all shells read ~/.bashrc, load it in ~/.bash_profile

hash vim 2>/dev/null && export EDITOR=vim
export TERM="xterm-256color"
[[ -d ~/bin ]] && export PATH=~/bin:$PATH

# The following lines are only for interactive shells
[[ $- = *i* ]] || return

# Run our updater
# Put in function so the job end message is nice
update_profile() {
  [[ -x ~/bin/update ]] && ~/bin/update
}
update_profile &

# Function for getting amount of mail in inbox for prompt
_new_mail() {
  if [ -r "$MAIL" ]; then
    NEWMAIL="$(grep -c '^Subject: ' "$MAIL")"
    if [ "$NEWMAIL" -gt -0 ]; then
      echo "${NEWMAIL}m "
    fi
  fi
}

# Make a directory and move to it
function md() {
    mkdir "$1" || return $?
    cd "$1"
}

# Run commands in each subdirectory
function dirdo() {
  for D in */; do
    cd "$D" 2>/dev/null || { echo "No subdirectories in this directory!"; return 1; }
    echo "$D"
    for var in "$@"; do
      $var
    done
    cd ..
  done
}

# Find file system changes since time specified
function find_modified() {
  if [ -z "$1" ]; then
    echo "Specify time difference"
    echo "Ex: '-1 hour'"
    return 1
  fi
  sudo find / -not \( -path /dev -prune \) -not \( -path /var/www/maps -prune \) -not \( -path /proc -prune \) -not \( -path /sys -prune \) -newermt "$(date -d "$1")" || return $?
}

# List file extensions in the given directory
function list_types() {
  find "$1" -mindepth 1 -type f |
    awk -F . '{print $NF}' | sort |
    uniq -c | sort -nr
}

# Use the system config if it exists
[[ -r /etc/bashrc            ]] && . /etc/bashrc
[[ -r /etc/bash.bashrc       ]] && . /etc/bash.bashrc

# Basic PS1 in case liquidprompt does not load
export PS1="[\u@\h:\w] \$?\\$ \[$(tput sgr0)\]"

[[ -r ~/bin/liquidprompt     ]] && . ~/bin/liquidprompt
[[ -r /etc/bash_completion   ]] && . /etc/bash_completion
[[ -d /etc/bash_completion.d ]] && . /etc/bash_completion.d/*
[[ -r ~/.alias               ]] && . ~/.alias

# Enable auto-complete after sudo and man
complete -cf sudo
complete -cf man

# Shell options
shopt -s cmdhist                  # save multi-line as one line
shopt -s dirspell                 # fix spelling error on tab if doesn't exist
shopt -s histappend               # append to history file
shopt -s no_empty_cmd_completion  # don't complete when on empty line

# cd options
CDPATH=".:~:~/dev"                # cd relative dirs

# History options
HISTSIZE=10000                                        # larger history size
HISTFILESIZE=10000
HISTCONTROL="erasedups:ignoreboth"                    # avoid duplicates
HISTTIMEFORMAT='%F %T '                               # timestamp entries
export HISTIGNORE="&:[ ]*:exit:bg:fg:history:clear"   # Ignore some commands

# Disable terminal bell
# Many machines don't have setterm
hash setterm 2>/dev/null && setterm -bfreq 0

# If the output is smaller than the screen height is smaller,
# less will just cat it
export LESS="-FX -R"

# Alias
echo "" | which -i which >/dev/null 2>&1 && alias which='alias | /usr/bin/which -i --tty-only --show-dot --show-tilde'
alias realias='$EDITOR ~/.bashrc; source ~/.bashrc'
alias df='df -h'
alias du='du -hs'
alias dus='du -hs * | sort -h'
alias please='sudo $(history -p !!)'
alias cd..='cd ..'
alias netstat='ss -rput'
alias dig='dig -t any +noall +answer'
alias path='echo $PATH | tr ":" "\n"'
if ls --color >/dev/null 2>&1; then
  alias ll='ls --color -lAh'
  alias la='ls --color -lah'
  alias ls='ls --color -lh'
else
  alias ll='ls -lAh'
  alias la='ls -lah'
  alias ls='ls -lh'
fi

# Load machine local config
[[ -r ~/.bash_local ]] && . ~/.bash_local
true
