# SW_HOME is not exported, since no child process should need to access it.
SW_HOME='/home/mkw/sw/shearwater'

export SET_IN_REDIS_IN_DEVELOPMENT='true'

export VISUAL=subl
export EDITOR="$VISUAL"
export GIT_EDITOR=vim

function join { local IFS="$1"; shift; echo "$*"; }

alias csubl='c ~/.config/sublime-text-3/Packages/User/'
alias ess='vim ~/.config/sublime-text-3/Local/Session.sublime_session'
alias cb='cd ~/repos/dotfiles/'

alias ct='cd $SW_HOME/two'
alias ca='cd $SW_HOME/admin'
alias cs='cd $SW_HOME'
alias cl='cd $SW_HOME/legacy'
alias cea='cd $SW_HOME/ember/app'
alias cr='cd $SW_HOME/rails'
alias fn='find -type f -name'
alias f='find -type f'
alias fr='find . \( -name .git -o -name tmp -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name public -o -name vendor -o -path ./test/reports -o -name dist \) -prune -o -type f -print'
alias gp='grep -E -i'
alias gpni='grep -E'
alias gpvni='grep -E -v'
alias gpv='grep -E -v -i'
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update'
alias sag='sudo apt-get'
alias cl='clear'
alias spo='sudo poweroff'
alias umf='git diff --name-only --diff-filter=U'
alias sumf='subl $(umf)'
alias radest='rake deploy staging'
alias vpr='gcs https://github.com/shearwater-intl/shearwater/pulls &'
alias grm='git rebase master'
alias vc='veracrypt'

alias untracked_files='git ls-files --others --exclude-standard'
alias utf='untracked_files'
alias sutf='subl $(untracked_files)'

source /usr/share/bash-completion/completions/git

alias g='git'
__git_complete g __git_main

alias gc='git checkout'
__git_complete gc _git_checkout

alias gmf='git merge --ff-only'
__git_complete gmf _git_merge

alias gd='git diff'
__git_complete gd _git_diff

alias gdc='git diff --cached'
__git_complete gdc _git_diff

alias ga='git add'
__git_complete ga _git_add

alias gb='git branch'
__git_complete gb _git_branch

alias gs='git status'
alias gcm='git commit'
alias gcam='git commit -am'
alias gca='git commit -a'
alias gsl='git stash list'
alias gss='git stash save'
alias gsa='git stash apply'
alias gpr='git pull --rebase'
alias gba='git branch -a'
alias gl='git log'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gph='git push'
alias gpf='git push -f'
alias gpffo='git pull --ff-only'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gaa='git add -A'

alias gco='git checkout --ours'

alias s='subl'

alias rdm='rake db:migrate'

alias eb='subl ~/.bashrc'
alias sb='source ~/.bashrc'

alias c1='cd ..'
alias c2='cd ../..'
alias c3='cd ../../..'
alias c4='cd ../../../..'
alias c5='cd ../../../..'
alias c6='cd ../../../../..'

alias gcs='google-chrome-stable'

alias es='ember server --proxy http://localhost:3200'
alias eso='ember server --proxy http://localhost:3200 --port 4000'
alias rs='bundle exec bin/rails s --port=3200'

# TODO: make this work.
alias rrs='bundle exec rescue bin/rails s --port=3200'

alias eds='ember deploy staging'
alias edsa='ember deploy staging --activate'
alias edd='ember deploy demo'
alias edda='ember deploy demo --activate'
alias edp='ember deploy production'
alias edpa='ember deploy production --activate'

alias et='ember test'

function save_power {
  sudo tlp start battery
  sudo pm-powersave battery
}

function go_fast {
  sudo tlp start ac
  sudo pm-powersave ac
}

function sgl {
  subl $(gpfr -l "$@")
}

# "Last Commit Message"
alias lcm='git log -1 --pretty=%B'

# Use this command to open a new pull request for the current branch, and immediatel open it in
# Chrome.
function hpr {
  gcs $(hub pull-request -m "$(lcm)" "$@") &
}

# TODO: rework the "force" versions of these commands to use:
#   git subtree push --prefix web heroku master
# or its ilk. When deleting and then re-creating the remote branch, Heroku's deploy hooks don't
# always pick it up.

function rds {
  pushd $SW_HOME/rails
  rake deploy:staging
  popd
}

function rdd {
  pushd $SW_HOME/rails
  rake deploy:demo
  popd
}

function rddf {
  pushd $SW_HOME/rails
  git push origin --delete demo
  rake deploy:demo
  popd
}

function rdsf {
  pushd $SW_HOME/rails
  git push origin --delete staging
  rake deploy:staging
  popd
}

function rdp {
  pushd $SW_HOME/rails
  rake deploy:production
  popd
}

function rdpf {
  pushd $SW_HOME/rails
  git push origin --delete production
  rake deploy:production
  popd
}

function rrfpuc {
  pushd $SW_HOME/rails
  rake restore_from_most_recent_production_backup
  popd
}

function rrfp {
  pushd $SW_HOME/rails
  rake restore_from_most_recent_saved_production_backup
  popd
}

# In the current feature branch-- how many commits do we have that aren't in master?
function commits_ahead_of_master {
  git rev-list $(current_branch) --not master | wc -l
}

# Rebase feature branch.
alias rfb='git rebase -i HEAD~$(commits_ahead_of_master)'

function c {
  cd $1
  ls
}

function gpfr {
  gp --color "$@" $(fr)
}

function gpnifr {
  gpni --color "$@" $(fr)
}

function rbc {
  pushd $SW_HOME/rails
  rubocop -D "$@"
  popd
}

function rr {
  cd $SW_HOME
  rake run
}

function rc {
  pushd $SW_HOME/rails
  bin/rails console
  popd
}

function rt {
  pushd $SW_HOME/rails
  rake test
  popd
}

function rts {
  pushd $SW_HOME/rails
  rspec
  popd
}

function catchmail {
  gem install mailcatcher
  mailcatcher
  google-chrome-stable http://127.0.0.1:1080
}

function gssp {
  eval "git stash show -p stash@{$1}"
}

function gcount {
  git log $1..$2 --pretty=oneline | wc -l
}

function op {
  git status --short | awk '$1 ~ /^M|A|U/ {print $2}'
}

function sop {
  subl $(op)
}

function current_branch {
  git rev-parse --abbrev-ref HEAD
}

function gpsu {
  git push --set-upstream origin $(current_branch)
}

function delete_merged_branches {
  if [ "master" != $(current_branch) ];
  then
    echo 'The current branch is not master!'
    return
  fi
  # To delete local branches that have been merged, run:
  git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

alias hrrc='heroku run rails console --app shearwater'
alias hrrcs='heroku run rails console --app shearwater-staging'
alias hrrcd='heroku run rails console --app shearwater-demo'

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

# I changed the heroku directory to be added to the end of the PATH rather than the beginning--
# this was causing issues with RVM.

# Added by the Heroku Toolbelt:
export PATH="$PATH:/usr/local/heroku/bin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/home/mkw/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
