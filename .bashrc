# -*- mode: shell-script -*-
platform=`uname`

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "$platform" == 'Darwin' ]]; then
    alias ls='ls -G'
    bashcompprefix=$(brew --prefix)
elif [[ "$platform" == 'FreeBSD' ]]; then
    alias ls='ls -G'
    bashcompprefix=/usr/local/share
elif [[ "$platform" == 'OpenBSD' ]]; then
    alias ls='ls -p'
    bashcompprefix=/usr/local/share
else
    alias ls='ls --color=auto'
    bashcompprefix=/usr/share
fi

source $HOME/bin/git-prompt.sh
source $HOME/.locale

export EDITOR=vim
export TERM="xterm-256color"
export CLICOLOR=1

function __prompt_command() {
    # Set the actual prompt, have different color if previous command 
    # failed
    if [ $? != 0 ]; then
        PS1='\[\e[0;33m\]$(__git_ps1 " (%s) ")\[\e[1;31m\]>\[\e[1;31m\]>\[\e[1;31m\]>\[\e[0m\] '
    else
        PS1='\[\e[0;33m\]$(__git_ps1 " (%s) ")\[\e[0;32m\]>\[\e[1;37m\]>\[\e[1;31m\]>\[\e[0m\] '
    fi
}

alias tmux="TERM=screen-256color-bce tmux"

#
# Better History
#

# Unlimited history
export HISTFILESIZE=
export HISTSIZE=

# avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# append history entries..
shopt -s histappend

# After each command, save and reload history
PROMPT_COMMAND=__prompt_command
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export PROMPT_COMMAND

#
# Completion
#
if [ -f $bashcompprefix/etc/bash_completion ]; then
    . $bashcompprefix/etc/bash_completion
fi

source $HOME/.bash_local
