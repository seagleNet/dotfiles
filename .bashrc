# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[[ $- != *i* ]] && return

# default profile
[[ -f /usr/share/defaults/etc/profile ]] && source /usr/share/defaults/etc/profile
[[ -f "${HOME}/.bashrc_default" ]] && source "${HOME}/.bashrc_default"

## work profile
[[ -f "${HOME}/.bashrc_work" ]] && source "${HOME}/.bashrc_work"

## source sensible
[[ -f "${HOME}/.local/bin/sensible.bash" ]] && source "${HOME}/.local/bin/sensible.bash"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999
HISTFILESIZE=9999

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# env variables
[[ -f "${HOME}/.vimrc" ]] && export MYVIMRC="${HOME}/.vimrc"
## path variable (shared with .profile)
[[ -f "${HOME}/.config/shell/path.sh" ]] && source "${HOME}/.config/shell/path.sh"
[[ -d "/usr/lib64/openjdk-11/bin" ]] && export PATH="/usr/lib64/openjdk-11/bin:$PATH"
[[ -d "/usr/lib64/openjdk-17/bin" ]] && export PATH="/usr/lib64/openjdk-17/bin:$PATH"
## pager
export PAGER="less"
command -v bat >/dev/null && export PAGER="bat" && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
command -v batcat >/dev/null && export PAGER="batcat" && export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export GIT_PAGER=$PAGER

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# bash completions
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

## kubectl bash completion
command -v kubectl >/dev/null && source <(kubectl completion bash) && complete -F __start_kubectl k
## helm bash completion
command -v helm >/dev/null && source <(helm completion bash)
## kind bash completion
command -v kind >/dev/null && source <(kind completion bash)
## rustup bash completion
command -v rustup >/dev/null && source <(rustup completions bash) && source <(rustup completions bash cargo)

# bash sets
## set vi shell commands
set -o vi

# starship
command -v starship >/dev/null && eval "$(starship init bash)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
