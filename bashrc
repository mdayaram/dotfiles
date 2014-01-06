# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep -Hn --color=auto'
    alias fgrep='fgrep -Hn --color=auto'
    alias egrep='egrep -Hn --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Rather complicated prompt, ignore the colors, looks like this:
# (^.^) :gitbranch: /current/path $
# The git branch only shows up if in a git directory.
# The face at the beginning represents the exit code of the last command.
#   (^.^) if exit status == 0
#   (>.<) if exist status != 0
export PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]'(^.^)'\[\e[0m\]; else echo \[\e[31m\]'(>.<)'\[\e[0m\]; fi\` \${debian_chroot:+(\$debian_chroot)}\[\e[0;34m\]:\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1 /'): \[\e[0;32m\]\$PWD\[\e[0;31m\] \\$\[\e[m\] "

# Aliases for common commands

alias vi='vim'
alias sudo='sudo ' # allow aliases to work with sudo
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias bell="tput bel" # play system bell sound.

# Need to set these before we source rvm and gvm because they back up the path.
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/bin/moovweb
export PATH=$PATH:$HOME/dev/shell-utils/build
export PATH=$PATH:$HOME/dev/shell-utils/test
export PATH=$PATH:$HOME/dev/shell-utils/apollo

# RVM scripts
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# add scripts for gvm and go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# add git autocompletion
[[ -s "$HOME/.dotfiles/git-completion" ]] && source "$HOME/.dotfiles/git-completion"

# Change GOPATH from gvm's default for now until gpkg makes use
# of go 1s new package features.
export MOOV_HOME=$HOME/dev/moovweb
export GOPATH=$MOOV_HOME

clear
echo "Hello $USER! And welcome to $(hostname)!"
echo -ne "Uptime: "; uptime
echo ""
cal
fortune | cowsay
echo ""

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Use vi commands in bash terminal when you press ESC
#set -o vi
