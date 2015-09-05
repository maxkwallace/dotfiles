# SW_HOME is not exported, since no child process should need to access it.
SW_HOME='/home/mkw/sw/shearwater'

export VISUAL=subl
export EDITOR="$VISUAL"
export GIT_EDITOR=vim

alias cs='cd $SW_HOME'
alias ce='cd $SW_HOME/ember'
alias cr='cd $SW_HOME/rails'

alias fn='find -type f -name'
alias fr='f | gpv "Gemfile\.lock" | gpv "/coverage/" | gpv "/public/" | gpv "/log/" | gpv "/tmp/" | gpv "/vendor/" | gpv "/dist/" | gpv "/node_modules/" | gpv "/bower_components/"'
alias f='find -type f'
alias gp='grep -i'
alias gpni='grep'
alias gpvni='grep -v'
alias gpv='grep -v -i'
alias sagi='sudo apt-get install'
alias sag='sudo apt-get'
alias cl='clear'

alias g='git'
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git checkout'
alias gcm='git commit'
alias gb='git branch'
alias gsl='git stash list'
alias gss='git stash save'
alias gsd='git stash drop'
alias gsa='git stash apply'
alias gpr='git pull --rebase'
alias gba='git branch -a'
alias gl='git log'

alias op='git ls-files -m'
alias sop='subl $(git ls-files -m)'

alias s='subl'

alias eb='subl ~/.bashrc'
alias sb='source ~/.bashrc'

alias c1='cd ..'
alias c2='cd ../..'
alias c3='cd ../../..'
alias c4='cd ../../../..'
alias c5='cd ../../../..'
alias c6='cd ../../../../..'

function c {
    cd $1
    ls
}

function rbc {
  pushd $SW_HOME/rails
  rubocop -D
  popd
}

function rr {
  cd $SW_HOME
  rake run
}

function rc {
  cd $SW_HOME/rails
  rails console
}

function et {
  pushd $SW_HOME/ember
  ember test
}

#### -- BEGIN DEFAULT SECTION, ADDED BY UBUNTU -- ####

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

#### -- END DEFAULT SECTION -- ####

alias br='brightness'
function brightness {
    sudo su -c "echo $1 > /sys/class/backlight/acpi_video0/brightness"
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
