# May be useful to read https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md

# MC_HOME is not exported, since no child process should need to access it.
MC_HOME="$HOME/Documents/mc"
MC_EMBER_HOME="$MC_HOME/mentorcollective-ember"
MC_RAILS_HOME="$MC_HOME/mentorcollective-rails"

# To edit keymappings on Ubuntu 20.04, visit /usr/share/X11/xkb/symbols/
# and edit e.g. the pc file.
alias exkbpc='sudo vim /usr/share/X11/xkb/symbols/pc'

# Remove EXIF data from an image:
# mogrify -strip a.jpg

# function ffncd {
#   find . -type f -name "$1"
# }
#
# function gpf {
#   grep -E "$2" $(ffncd $1)
# }


# Test if a variable is unset or a length-zero string:
# if [ -z "$bar" ]
# then
#   echo "FOO is empty"
# else
#   echo "FOO is not empty"
# fi

# Test if a variable is set and has length > 1
# if [ -n "$FOO" ]
# then
#   echo "FOO is not empty"
# else
#   echo "FOO is empty"
# fi

# String equality:
# if [ "$str1" == "$str2" ]; then
#     echo "Strings are equal"
# else
#     echo "Strings are not equal"
# fi

# map:
# my_command | while read l; do something_with "$l"; done
# look into: https://github.com/soveran/map

function rt {
  cd ~/Documents/talon-linux-89-0.0.8.29-1351-g12bc13b/talon
  sudo ./run.sh
}

function ct {
  cd ~/.talon/user/knausj_talon
}


# Ecryption and decryption:
alias enc='gpg --pinentry-mode loopback --symmetric'
alias dec='gpg --pinentry-mode loopback --decrypt'
#
# Locally, --pinentry-mode loopback seems to use cmdline input instead of the
# UI dialog.

# Regex cheatsheet:
# Totally portable (AFAIK):
# \d - digits
# \s - whitespace
# \w - word
#
# https://www.gnu.org/software/grep/manual/grep.html#Character-Classes-and-
# Bracket-Expressions
# ‘\b - Match the empty string at the edge of a word.
# ‘\B - Match the empty string provided it’s not at the edge of a word.
# ‘\< - Match the empty string at the beginning of word.
# ‘\> - Match the empty string at the end of word.
# ‘\w - Match word constituent, it is a synonym for ‘[_[:alnum:]]’.
# ‘\W - Match non-word constituent, it is a synonym for ‘[^_[:alnum:]]’.
# ‘\s - Match whitespace, it is a synonym for ‘[[:space:]]’.
# ‘\S - Match non-whitespace, it is a synonym for ‘[^[:space:]]’.


# Utility commands:
# List total sizes of directories in current folder: du -sh -- *
alias dush='du -sh -- *'

# Wordcount lines for each file in dirctory:
# find . -maxdepth 1 -type f -exec wc -l {} \;

# Making random strings:
# (0..37).to_a.map { (('A'..'z').to_a + ('0'..'9').to_a).sample }.join

# Renaming:
# https://gist.github.com/premek/6e70446cfc913d3c929d7cdbfe896fef
# foo.flac -> bar.flac
# mv {foo,bar}.flac

# Recursive:
#
# find . -print | while read filename; do
#   touch -d '14 April 2020 11:00' "$filename"
#   touch -d "$(date -R -r "$filename") - 2 hours" "$filename"
# done

# Find the biggest files in subdirectories.
# find -type f -exec du -Sh {} + | sort -rh | head -n 5

# Use the rename command to rename multiple files:
# rename 's/ /-/g' *

# ls -a | sort -> to get a row-by-row list of names only

# Convert to FLAC:
# mkdir flac
# for i in *; do ffmpeg -i "$i" "flac/${i::-4}.flac"; done

# Splitting FLAC with cue file
# cuebreakpoints file.cue | shnsplit -o flac file.flac

# Convert webp:
# dwebp file.webp -o abc.png
#
# for file in $(ls *.webp)
# do
#   dwebp $file -o ${file:0:-5}.png
# done

# Remove intermediate directories (doesn't work?)
# for dir in $(ls)
# do
#   cd $dir
#   echo $(pwd)

#   if [ "2" == $(find -type d | wc -l) ];
#   then
#     echo "moving and removing"
#     cd $(find -type d | tail -1)
#     mv * ../
#     echo 'moved'
#     cd ..
#     echo 'removing '"$(find -type d | tail -1)"
#     rmdir $(find -type d | tail -1)
#   else
#     echo 'Expected to find one subdir, not found, doing nothing'
#   fi
#   cd ..
# done

function wtp {
  input=$1
  dwebp "$input" -o "${input%.*}.png"
}

# Unzip all zipfiles in subdirectories and delete the archives:
# find . -depth -name '*.zip' -execdir /usr/bin/unzip -n {} \; -delete


# For Redshift issues:
# https://github.com/xflux-gui/fluxgui/issues/27

# export SET_IN_REDIS_IN_DEVELOPMENT='true'
alias start_redis='sudo /etc/init.d/redis_6379 start'

# Note to self-- single vs. double quotes:
# - Single quotes perserve the literal value of each character in the quotes-- no interpolation.
# - Double quotes do the same, except for $, `, \, and !
# See http://stackoverflow.com/a/6697781/1067145

export VISUAL=subl
export EDITOR="$VISUAL"
export GIT_EDITOR=vim

# For http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html#awscli-install-linux-path
export PATH=~/.local/bin:$PATH


alias pf='pip freeze | grep -v 'pkg-resources==0.0.0''

function rpc {
  rm $(find -name *.pyc)
}

function drm {
  docker rm -f $(docker ps -a -q)
}

alias py='python3'
alias pt='pytest'


function join { local IFS="$1"; shift; echo "$*"; }

alias csubl='c ~/.config/sublime-text-3/Packages/User/'
alias ess='vim ~/.config/sublime-text-3/Local/Session.sublime_session'
alias cb='cd ~/Documents/my-repos/dotfiles/'
alias se='source'

# These aliases don't work on OSX without using double quotes.
alias cs="cd $MC_HOME"
alias cm="cd $MC_HOME"
alias ce="cd $MC_EMBER_HOME"
alias cmr="cd $MC_RAILS_HOME"
alias cea="cd $MC_EMBER_HOME/app"
alias cf="cd ~/sandbox/rails-sandbox/foo"

alias cr="cd ~/Documents/repos"

alias fn='find -type f -name'
alias f='find -type f'

# Find text files only.
alias ftfo='find . -type f -exec grep -Iq . {} \; -print'

alias ll='ls -A1F'

# Old aliases used when at MC:
# The only difference between 'fr' and 'frb' is that 'fr' also omits ./db/migrate.
# alias fr='find .  \( -name .git -o -name tmp -o -name elm-stuff -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name skylight.yml -o -name vcr_fixtures -o -name vendor -o -name _site -o -path ./test/reports -o -path ./db/migrate -o -name yarn.lock  -o -name npm-debug.log -o -name dist \) -prune -o -type f -print'
# alias frb='find . \( -name .git -o -name tmp -o -name elm-stuff -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name skylight.yml  -o -name vcr_fixtures -o -name vendor -o -name _site -o -path ./test/reports -o -name yarn.lock  -o -name npm-debug.log -o -name dist \) -prune -o -type f -print'

# Updated for Brio:
alias fr='find .  \( -name .git -o -name tmp -o -name elm-stuff -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name skylight.yml -o -name vcr_fixtures -o -name vendor -o -name _site -o -path ./test/reports -o -path ./db/migrate -o -name yarn.lock -o -name npm-debug.log -o -name dist -o -name package-lock.json -o -path ./static  -o -name __pycache__  -o -path ./not_garbage \) -prune -o -type f -print'

# Find all files without spaces in their names.
alias fs='find . -type f ! -iregex "\./.+ .+" -print'

# Includes the test from fs to filter out filenames containing spaces.
alias frs='find . \( -name .git -o -name tmp -o -name elm-stuff -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name skylight.yml -o -name vcr_fixtures -o -name vendor -o -path ./test/reports -o -path ./db/migrate -o -name yarn.lock  -o -name npm-debug.log -o -name dist \) -prune -o -type f ! -iregex "\./.+ .+" -print'

# 2019-05-10 hacking on find commands.
# find . ! -iregex '.*/[\.a-z0-9-]*'
# "!" negates the following test, regexes match the whole file path.
#
# find everything:
# find . -iregex '\./.+'
#
# find everything that doesn't contain a space:
# find . ! -iregex '\./.+ .+'

alias gp='grep -E -i'
alias gpni='grep -E'
alias gpvni='grep -E -v'
alias gpv='grep -E -v -i'

alias sai='sudo apt install'
alias sau='sudo apt update'
alias saug='sudo apt upgrade'
alias sa='sudo apt'

alias cl='clear'
alias spo='sudo poweroff'

alias umf='git diff --name-only --diff-filter=U'

# This will open a bunch of empty (new) files if I don't run it from the root
# of the repo. TODO: fix this.
# alias sumf='subl $(umf)'
# function sumf {
#   pushd EDIT
#   subl $(umf)
#   popd
# }

alias vc='veracrypt'

alias vepr='gcs https://github.com/shearwaterintl/mentorcollective-ember/pulls &'
alias vrpr='gcs https://github.com/shearwaterintl/mentorcollective-ember/pulls &'

alias untracked_files='git ls-files --others --exclude-standard'
alias utf='untracked_files'
alias sutf='subl $(untracked_files)'

alias glsm='git ls-files -m'

alias rmrfdt='rm -rf dist/* tmp/*'

source /usr/share/bash-completion/completions/git

# Searching the commit history for when a line was deleted:
# git log -c -S'missingtext' /path/to/file

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
alias gcma='git checkout master'
alias gcpr='git checkout production'
alias gct='git commit'
alias gca='git commit -a'
alias gts='git stash'
alias gsl='git stash list'
alias gss='git stash save'
alias gsa='git stash apply'
alias gpr='git pull --rebase'
alias gba='git branch -a'
alias gl='git log'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gph='git push'
alias gpffo='git pull --ff-only'
alias gmffo='git merge --ff-only'
alias grm='git rebase master'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gaa='git add -A'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'

function gcm {
  if [ -n "$1" ]
  then
    git commit -am "$1"
  else
    git commit -am "$(date)"
  fi
}

# "git rebase remote"
function grr {
  git rebase "origin/$(current_branch)"
}

alias gco='git checkout --ours'

alias ggpa='git rev-list --all | xargs git grep'

alias lola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'

alias s='subl'

alias rdm='rake db:migrate'

alias hrrdm='heroku run rake db:migrate -a shearwater'
alias hrrdmd='heroku run rake db:migrate -a shearwater-demo'
alias hrrdms='heroku run rake db:migrate -a shearwater-staging'

alias rcpts='rake copy_production_to_staging'

alias eb='subl ~/.bashrc'
alias ebp='subl ~/.bash_profile'
alias sb='source ~/.bashrc'
alias sbp='source ~/.bash_profile'

alias c1='cd ..'
alias c2='cd ../..'
alias c3='cd ../../..'
alias c4='cd ../../../..'
alias c5='cd ../../../..'
alias c6='cd ../../../../..'

alias gcs='google-chrome-stable'

alias es='ember serve --proxy http://localhost:3200'
alias rs='bundle exec bin/rails s --port 3200' # port=3200 doesn't work; I'm not sure why.
alias ces='ce && es'
alias crs='cr && rs'

alias eds='ember deploy staging'
alias edsa='ember deploy staging --activate'
alias edd='ember deploy demo'
alias edda='ember deploy demo --activate'
alias edp='ember deploy production'
alias edpa='ember deploy production --activate'
alias edpma='ember deploy prodmirror --activate'

alias et='ember test'

alias er='elm reactor -a=localhost'

alias fix_wifi='sudo systemctl restart network-manager.service'

alias ras='/usr/local/android-studio/bin/studio.sh &'

# "list installed packages"
alias lip='apt list --installed'

# To remove a package:
# sudo apt remove <application_name>

function nsv {
  npm show $1 version
}

function egm {
  ember g model --pod true "$@"
}

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

function sglni {
  subl $(gpnifr -l "$@")
}

function gdcm {
  local branch=$(current_branch)

  if [ "master" == $branch ];
  then
    echo 'Already on master'
    return
  fi
  git checkout master
  git branch -D $branch
}

# "Last Commit Message"
alias lcm='git log -1 --pretty=%B'

# All credit goes to http://stackoverflow.com/a/24642735/1067145
function dnif {
  # Recursively list a file from PWD up the directory tree to root
  [[ -n $1 ]] || { echo "dnif [ls-opts] name"; return 1; }
  local THERE=$PWD RC=2
  while [[ $THERE != / ]]
      do [[ -e $THERE/${2:-$1} ]] && { ls ${2:+$1} $THERE/${2:-$1}; RC=0; }
          THERE=$(dirname $THERE)
      done
  [[ -e $THERE/${2:-$1} ]] && { ls ${2:+$1} /${2:-$1}; RC=0; }
  return $RC
}

# Use this command to open a new pull request for the current branch, and immediately open it in
# Chrome.
# -m "$(lcm)"
function hpr {
  newline=$'\n'
  content=`cat $(dnif PULL_REQUEST_TEMPLATE)`
  template_text=$newline$content

  # For reference, here's part of my previious implementation:
  #   last_commit_message=`lcm`
  #   newline=$'\n'
  #   message="$last_commit_message
  # $template_text"
  #   $message > ~/test_file
  #   echo $message

  gcs $(hub pull-request -m "$(current_branch)$template_text" "$@") &
}

# TODO: rework the "force" versions of these commands to use:
#   git subtree push --prefix web heroku master
# or its ilk. When deleting and then re-creating the remote branch, Heroku's deploy hooks don't
# always pick it up.

function rdd {
  # Implement!
  exit 1
}

function rrfpuc {
  pushd $MC_RAILS_HOME
  rake restore_from_most_recent_production_backup
  popd
}

function rrfp {
  pushd $MC_RAILS_HOME
  rake restore_from_most_recent_saved_production_backup
  popd
}

# In the current feature branch-- how many commits do we have that aren't in master?
function commits_ahead_of_master {
  git rev-list $(current_branch) --not master | wc -l
}

# Rebase feature branch.
alias rfb='git rebase -i HEAD~$(commits_ahead_of_master)'

alias cam='commits_ahead_of_master'

function c {
  cd $1
  ls
}

# Can be used to rename, e.g. methods.
# $1 - the search pattern
# $2 - the replace string
#
# In sed, the -E flag (for Extended regex support) reverses the meaning of "(" and "\(".
# -i is --in-place
function sr {
  gpni -l "$1" $(fr) | xargs -I filepath sed -i -E "s/$1/$2/g" filepath
}

function srof {
  echo "$3" | xargs -I filepath sed -i -E "s/$1/$2/g" filepath
}

function srcrm {
  gpni -l "$1" $(crm) | xargs -I filepath sed -i -E "s/$1/$2/g" filepath
}


# This function is commented out until I have a chance to finish it.
# function srf {
  # fr | gpni $1 | xargs -I filepath
  # gpni -l $1 $(fr) | xargs -I filename echo
# }

# -n
function srn {
  gpni -l $1 $(fr)
}

function gpf {
  gp --color "$@" $(f)
}

function gpfs {
  gp --color "$@" $(fs)
}

function gpfr {
  gp --color "$@" $(fr)
}
alias gr='gpfr'

function gpfrb {
  gp --color "$@" $(frb)
}

function gpnif {
  gpni --color "$@" $(f)
}

function gpnifr {
  gpni --color "$@" $(fr)
}

function rbc {
  rubocop -D -a $(changed_relative_to_master | grep -v '\.html\.erb$' | grep -v Gemfile | grep -v '\.yml$' | grep -v '/templates/' | grep -v 'schema\.rb')
}

function rbcna {
  rubocop -D $(changed_relative_to_master | grep -v '\.html\.erb$' | grep -v Gemfile | grep -v '\.yml$' | grep -v '/templates/' | grep -v 'schema\.rb')
}

function rbca {
  rubocop -D -a "$@"
}

function rbd {
  rubocop -D "$@"
}

function rc {
  pushd $MC_RAILS_HOME
  bin/rails console
  popd
}

# function rt {
#   pushd $MC_RAILS_HOME
#   rake test
#   popd
# }

function rtns {
  pushd $MC_RAILS_HOME
  SHEARWATER_DONT_SKIP_TESTS=true rake test
  popd
}

function catchmail {
  gem install mailcatcher
  mailcatcher
  google-chrome-stable http://127.0.0.1:1080
}

function rotate_all_pd {
  for file in $(find -maxdepth 1 -type f -printf "%f\n")
  do
    convert "$file" -rotate 90 ../$file
  done
}
alias rapd='rotate_all_pd'

function rotate_all {
  mkdir ./prerotated
  for file in $(find -maxdepth 1 -type f -printf "%f\n")
  do
    mv $file ./prerotated/$file
    convert "./prerotated/$file" -rotate 90 ./$file
  done
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

function dno {
  git diff --name-only
}

function sop {
  subl $(op)
}

function sodno {
  subl $(dno)
}

function current_branch {
  git rev-parse --abbrev-ref HEAD
}

function gpsu {
  git push --set-upstream origin $(current_branch)
}

function rcs {
  mcs $1
  eval "./$1"
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

function delete_elis_branches {
  if [ "master" != $(current_branch) ];
  then
    echo 'The current branch is not master!'
    return
  fi
  git branch | grep '^  eli-' | xargs -n 1 git branch -D
}

alias desbs='delete_elis_branches'

function sublime_create_project {
  if [ -z "$1" ]; then
    echo 'Error: a project name is required'
    return
  fi

  project_name="${1%/}"
  filename="$project_name.sublime-project"
  touch $filename

  # Tried <<-, didn't work-- can't get bash to automatically ignore leading whitespace.
  tee $filename <<FILE_CONTENTS > /dev/null
{
  "folders":
  [
    {
      "path": "$project_name"
    }
  ]
}
FILE_CONTENTS
}

function sublime_create_and_open_project {
  sublime_create_project $1
  subl "${1%/}.sublime-project"
}

alias scpt='sublime_create_project'
alias scopt='sublime_create_and_open_project'

alias sur='set_up_repo'

# Call like:
# :~$ set_up_repo username/repo-name
function set_up_repo {
  array_form=(${1//\// })
  folder_name=${array_form[1]}

  cd ~/Documents/repos
  mkdir $folder_name
  cd ~/Documents/repos/$folder_name

  git clone 'git@github.com:'$1'.git'
  sublime_create_and_open_project $folder_name'/'
}

function set_up_candidate_repo {
  array_form=(${1//\// })
  gh_username=${array_form[0]}
  folder_name=${array_form[1]}

  cd ~/candidates

  mkdir $gh_username
  cd $gh_username

  mkdir $folder_name
  cd $folder_name

  git clone 'git@github.com:'$1'.git'
  sublime_create_and_open_project $folder_name'/'
}

alias hrrc='heroku run rails console --app shearwater'
alias hrrcs='heroku run rails console --app shearwater-staging'
alias hrrcd='heroku run rails console --app shearwater-demo'
alias hrrcpm='heroku run rails console --app shearwater-prodmirror'

alias hlt='heroku logs --tail --app shearwater'
alias hlts='heroku logs --tail --app shearwater-staging'
alias hltd='heroku logs --tail --app shearwater-demo'
alias hltpm='heroku logs --tail --app shearwater-prodmirror'

alias hpgbc='heroku pg:backups capture -a shearwater'
alias hpgbcs='heroku pg:backups capture -a shearwater-staging'
alias hpgbcd='heroku pg:backups capture -a shearwater-demo'

alias hppas='heroku pipelines:promote -a shearwater-staging'

# MSR means Model-specific register. 0x19a has something to do with clock modulation / power
# conservation.
#
# See: http://askubuntu.com/questions/792605/ubuntu-16-04-lts-too-slow-after-suspend-and-resume
alias rd_speed_msr='sudo rdmsr -a 0x19a'
alias wr_speed_msr='sudo wrmsr -a 0x19a 0x0'

# to_mp3 only works on one file per command-- if you want to convert multiple files, you'll need
# something like:
# for f in *; do to_mp3 "$f"; done
function to_mp3 {
  input=$1
  avconv -i "$input" -qscale:a 0 "${input%.*}.mp3"
}

alias changed_relative_to_master='g diff --name-only master'
alias crm='changed_relative_to_master'

# Install youtube-dl (ffmpeg should already be installed)
# sudo youtube-dl -U to update
function dl_yt_audio {
  youtube-dl -f 'bestaudio' -o 'download.%(ext)s' $1

  if [ ! -f download.webm ]; then
      echo "Didn't get a webm"
      return
  fi

  ffmpeg -i "download.webm" -vn -acodec copy "audio.opus"

  if [ ! -f audio.opus ]; then
      echo "No audio.opus file"
      return
  fi

  # ffmpeg -i "audio.opus" "audio.flac"
  rm download.webm
  # rm audio.opus
}

function wtm {
  input=$1
  # ffmpeg -i $1 -qscale 0 "${input%.*}.mp4"
  ffmpeg -i $1 -movflags faststart -profile:v high -level 4.2 "${input%.*}.mp4"
}

function ren {
  rename -v 's/ /-/g' *
  rename -v 's/_/-/g' *
  rename -v 's/[0-9]//g' *
  rename -v 's/[)(]//g' *
  rename -v 's/\.(?=[^.]*\.)/-/g' *
}


# Drop all databases in Postgres:
#
# sudo -u postgres psql
#
# select 'drop database "'||datname||'";'
# from pg_database
# where datistemplate=false;
#
# psql -d postgres -f dd.sql


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
    xterm-color|*-256color) color_prompt=yes;;
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
  # Edited by Max:
  #
  # Note to self: I tried customizing this to add the current working git branch (__git_ps1), but
  # that seemed to make the terminal too slow for my liking.
  if [ $(hostname) = "mkw-M4800" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@M4600\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  fi
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# Update, 2018-02-04: use xbacklight instead.
# Update, 2019-01-02: use the Ubuntu brightness GUI.
alias br='brightness'
function brightness {
  if [ $(hostname) = "mkw-p1gen2" ]; then
    echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
  else
    sudo su -c "echo $1 > /sys/class/backlight/acpi_video0/brightness"
  fi
}

alias rbr='read_brightness'
function read_brightness {
  if [ $(hostname) = "mkw-p1gen2" ]; then
    cat /sys/class/backlight/intel_backlight/brightness
  else
    cat /sys/class/backlight/acpi_video0/brightness
  fi
}


# I changed the heroku directory to be added to the end of the PATH rather than the beginning--
# this was causing issues with RVM.

# Added by the Heroku Toolbelt:
export PATH="$PATH:/usr/local/heroku/bin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Also see functions sr and srcm above for search-and-replace tasks.
#
# If you need a newline in a string, you must use $'\n'.
# rff "^.*binding.pry"$'\n' $(fr | gpv 'bin/')
alias rff='runhaskell ~/Documents/my-repos/hsutils/hsutils/regex-remove-from-files.hs'

function crff {
  git commit -am "Remove lines matching $1"
}

# Does not work for some reason :(
# function rbp {
#   rff "^.*binding.pry"$'\n' $(fr | gpv 'bin/')
# }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ $(hostname) = "mkw-p1gen2" ]; then
  alias python=python3
fi

# Via https://stackoverflow.com/a/53825858/1067145, to fix Hugo error
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0