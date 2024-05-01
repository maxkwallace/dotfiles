### ~~ BASH ~~ ###


# May be useful to read https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md

# single vs. double quotes in Bash:
# - Single quotes perserve the literal value of each character in the quotes-- no interpolation.
# - Double quotes do the same, except for $, `, \, and !
# See http://stackoverflow.com/a/6697781/1067145

# filename_extension_test foo/asdf.mp4
# >> qqmp4
# >> qqfoo/asdf
function filename_extension_test {
  extension="qq${1##*.}"
  filename="qq${1%.*}"
  echo $extension
  echo $filename
}

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

function join { local IFS="$1"; shift; echo "$*"; }

alias cl='clear'

alias cb='cd ~/Documents/repos/dotfiles/'
alias se='source'

alias eb='subl ~/.bashrc'
alias ebp='subl ~/.bash_profile'
alias sb='source ~/.bashrc'
alias sbp='source ~/.bash_profile'



### ~~ CHEATSHEETS & NOTES FOR OTHER LANGUAGES ~~ ###

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


# Making random strings in Ruby:
# (0..37).to_a.map { (('A'..'z').to_a + ('0'..'9').to_a).sample }.join








### ~~ EDITORS ~~ ###

export VISUAL=subl
export EDITOR="$VISUAL"
export GIT_EDITOR=vim

alias s='subl'
alias v='code-insiders'

function csubl {
  if [ $(hostname) = "mxw-z490-e" ]; then
    c ~/.config/sublime-text/Packages/User/
  else
    c ~/.config/sublime-text-3/Packages/User/
  fi
}

function ess {
  if [ $(hostname) = "mxw-z490-e" ]; then
    vim ~/.config/sublime-text/Local/Session.sublime_session
  else
    vim ~/.config/sublime-text-3/Local/Session.sublime_session
  fi
}


function sgl {
  subl $(gpfr -l "$@")
}

function sglni {
  subl $(gpnifr -l "$@")
}


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












### ~~ NAVIGATION ~~ ###

function c {
  cd $1
  ls
}

alias c1='cd ..'
alias c2='cd ../..'
alias c3='cd ../../..'
alias c4='cd ../../../..'
alias c5='cd ../../../..'
alias c6='cd ../../../../..'

alias cdl='cd ~/Downloads'

alias cr="cd ~/Documents/repos"
alias crhl="cd ~/Documents/repos/haskell-learning"













### ~~ FILES & DIRECTORIES ~~ ###




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
alias fns='find . -type f ! -iregex "\./.+ .+" -print'

# Includes the test from fs to filter out filenames containing spaces.
alias frs='find . \( -name .git -o -name tmp -o -name elm-stuff -o -name node_modules -o -name bower_components -o -name Gemfile.lock -o -name public -o -name log -o -name coverage -o -name skylight.yml -o -name vcr_fixtures -o -name vendor -o -path ./test/reports -o -path ./db/migrate -o -name yarn.lock  -o -name npm-debug.log -o -name dist \) -prune -o -type f ! -iregex "\./.+ .+" -print'

alias fjr='find .  \( -path ./ia-writer \) -prune -o -type f -print'
# 2019-05-10 hacking on find commands.
# find . ! -iregex '.*/[\.a-z0-9-]*'
# "!" negates the following test, regexes match the whole file path.
#
# find everything:
# find . -iregex '\./.+'
#
# find everything that doesn't contain a space:
# find . ! -iregex '\./.+ .+'



# Unzip all zipfiles in subdirectories and delete the archives:
# find . -depth -name '*.zip' -execdir /usr/bin/unzip -n {} \; -delete


# Wordcount lines for each file in dirctory:
# find . -maxdepth 1 -type f -exec wc -l {} \;


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

# function ffncd {
#   find . -type f -name "$1"
# }

# Use the rename command to rename multiple files:
# rename 's/ /-/g' *

# ls -a | sort -> to get a row-by-row list of names only


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



# List total sizes of directories in current folder: du -sh -- *
alias dush='du -sh $(ls -A)'


# ${1:-5} uses 5 if $1 is null or unset.
function find_largest_files {
  find -type f -exec du -Sh {} + | sort -rh | head -n ${1:-5}
}
alias flf='find_largest_files'

# If run with no arguments, deletes the largest file in subdirectories.
# Pass an argument to delete additional files.
function find_largest_files_delete {
  find_largest_files ${1:-1} | cut -d$'\t' -f 2- | xargs -d'\n' rm -v
}
alias flfd='find_largest_files_delete'


# "find" backwards-- find a file upwards in the tree
#
# All credit to http://stackoverflow.com/a/24642735/1067145
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


# Mostly for papers in sources/
function ren {
  rename -v 's/ /-/g' *
  rename -v 's/_/-/g' *
  rename -v 's/[0-9]//g' *
  rename -v 's/[)(]//g' *
  rename -v 's/\.(?=[^.]*\.)/-/g' *
}

# Fixing filenames for Windows
function renw {
  rename -v 's/
/_/g' *
  rename -v 's/\?/_/g' *
  rename -v 's/:/_/g' *
}

# For music files
function ren2 {
  rename -v 's/ /-/g' *
  rename -v 's/[)(]//g' *
}













### ~~ GREP ~~ ###


alias gp='grep -E -i'
alias gpni='grep -E'
alias gpvni='grep -E -v'
alias gpv='grep -E -v -i'

# function gpf {
#   grep -E "$2" $(ffncd $1)
# }

# -n
function srn {
  gpni -l $1 $(fr)
}

function gpf {
  gp --color "$@" $(f)
}

function gpfns {
  gp --color "$@" $(fns)
}

function gpfr {
  gp --color "$@" $(fr)
}
function gpfj {
  cd ~/Dropbox/personal/journals
  gp --color "$@" $(fjr)
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












### ~~ SEARCH & REPLACE ~~ ###

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

# If you need a newline in a string, you must use $'\n'.
# rff "^.*binding.pry"$'\n' $(fr | gpv 'bin/')
alias rff='runhaskell ~/Documents/repos/hsutils/hsutils/regex-remove-from-files.hs'

function crff {
  git commit -am "Remove lines matching $1"
}

# Does not work for some reason :(
# function rbp {
#   rff "^.*binding.pry"$'\n' $(fr | gpv 'bin/')
# }






### ~~ TALON ~~ ###

function rt {
  cd ~/Documents/talon-linux-114-0.3.1/talon
  ./run.sh
}

function ct {
  cd ~/.talon/user/mxw-talon
}

function ctp {
  cd ~/Documents/talon-linux-114-0.3.1/talon/resources/python/lib/python3.9/site-packages/talon
}

function back_up_talon {
  cd "/home/mjw/Dropbox/everything-else/talon-backup"
  FOLDERNAME=$(date "+%Y-%m-%d-%H-%M")
  mkdir $FOLDERNAME
  cd $FOLDERNAME
  cp -r ~/.talon/user/* .
  rm -rf cursorless-talon/ knausj_talon/ rango-talon/
}












### ~~ AUDIO & VIDEO ~~  ###

# to_mp3 only works on one file per command-- if you want to convert multiple files, you'll need
# something like:
# for f in *; do to_mp3 "$f"; done
function to_mp3 {
  input=$1
  avconv -i "$input" -qscale:a 0 "${input%.*}.mp3"
}

# Convert to FLAC:
# mkdir flac
# for i in *; do ffmpeg -i "$i" "flac/${i::-4}.flac"; done

# for i in *.wav; do echo "$i"; echo "${i::-4}.flac"; done
# for i in *.wav; do ffmpeg -i "$i" "${i::-4}.flac"; done

# Convert all flac files to ogg (and delete after conversion)
function flac_to_ogg {
  for i in *.flac;
  do
    ffmpeg -i "$i" "${i::-5}.ogg"
    if [ ! -f "${i::-5}.ogg" ]; then
        echo "No ogg file"
        break
    fi
    rm "$i"
  done
}

function wav_to_flac {
  for i in *.wav;
  do
    ffmpeg -i "$i" "${i::-5}.flac"
    if [ ! -f "${i::-5}.flac" ]; then
        echo "No flac file"
        break
    fi
    rm "$i"
  done
}

function wav_to_ogg {
  for i in *.wav;
  do
    ffmpeg -i "$i" "${i::-5}.ogg"
    if [ ! -f "${i::-5}.ogg" ]; then
        echo "No ogg file"
        break
    fi
    rm "$i"
  done
}

function wav_to_16 {
  for i in *.wav;
  do
    ffmpeg -i "$i" -ar 44100 "${i::-4}-16.wav"
    if [ ! -f "${i::-4}-16.wav" ]; then
        echo "No output file"
        break
    fi
    rm "$i"
  done
}

function flac_to_ogg_subdir_1 {
  for g in *; do
      if [ -d "$g" ]; then
        echo $(pwd)/$g
        cd "$g"
        for i in *.flac;
        do
          pwdvar=$(pwd)
          tpwdvar=${pwdvar:0:40}
          if [ $tpwdvar != "/home/mjw/Dropbox/unsynced/music-on-phon" ]; then
            echo "ERROR"
            exit 1
          elif [ -f "$i" ]; then
            echo $(pwd)/$i
            ffmpeg -i "$i" -vsync 0 "${i::-5}.ogg"
            if [ ! -f "${i::-5}.ogg" ]; then
                echo "No ogg file"
                break
            fi
            rm "$i"
          fi
        done
        cd ..
      fi
  done
}

# 2022-02-25 Convert all 2nd subdirectories' flac files to ogg
# i.e. in directory of artists, use to convert song files in album folders
function flac_to_ogg_subdir_2 {
  for f in *; do
      if [ -d "$f" ]; then
        echo $(pwd)/$f
        cd "$f"
        for g in *; do
            if [ -d "$g" ]; then
              echo $(pwd)/$g
              cd "$g"
              for i in *.flac;
              do
                pwdvar=$(pwd)
                tpwdvar=${pwdvar:0:40}
                if [ $tpwdvar != "/home/mjw/Dropbox/unsynced/music-on-phon" ]; then
                  echo "ERROR"
                  exit 1
                elif [ -f "$i" ]; then
                  echo $(pwd)/$i
                  ffmpeg -i "$i" -vsync 0 "${i::-5}.ogg"
                  if [ ! -f "${i::-5}.ogg" ]; then
                      echo "No ogg file"
                      break
                  fi
                  rm "$i"
                fi
              done
              cd ..
            fi
        done
        cd ..
      fi
  done
}


# Splitting FLAC with cue file
# cuebreakpoints file.cue | shnsplit -o flac file.flac


function dl_yt_audio {
  # yt-dlp -f 'bestaudio' --cookies-from-browser firefox:~/snap/firefox/common/.mozilla/firefox/DIRECTORY -o 'download.%(ext)s' $1
  yt-dlp -f 'bestaudio' -o 'download.%(ext)s' $1

  if [ ! -f download.webm ]; then
      echo "Didn't get a webm"
      return
  fi

  ffmpeg -i "download.webm" -vn -acodec copy "audio.opus"

  if [ ! -f audio.opus ]; then
      echo "No audio.opus file"
      return
  fi

  ffmpeg -i "audio.opus" "audio.flac"
  rm download.webm
  rm audio.opus
}

function to_yt_audio {
  ffmpeg -i "$1" -vn -acodec copy "audio.opus"

  if [ ! -f audio.opus ]; then
      echo "No audio.opus file"
      return
  fi

  ffmpeg -i "audio.opus" "audio.flac"
  rm download.webm
  rm audio.opus
}



function wtm {
  input=$1
  # ffmpeg -i $1 -qscale 0 "${input%.*}.mp4"
  ffmpeg -i $1 -movflags faststart -profile:v high -level 4.2 "${input%.*}.mp4"
}

function compressv {
  input=$1

  ffmpeg -i $1 -vcodec libx265 -crf 26 "${input%.*}-1.mp4"
  if [ -f "${input%.*}-1.mp4" ]; then
      rm "$1"
  else
      echo "error: no output file"
      break
  fi
}



function wmv_to_mp4 {
  for input in *.wmv;
  do
    ffmpeg -i $input -vcodec libx265 -crf 21 -preset slow "${input%.*}__1.mp4"
    if [ -f "${input%.*}__1.mp4" ]; then
        # rm "$input"
        echo "would have deleted"
    else
        echo "error: no output file"
        break
    fi
  done
}

function rm_to_mp4 {
  for input in *.rm;
  do
    ffmpeg -i $input -vcodec libx265 -crf 21 -preset slow "${input%.*}__6.mp4"
    if [ -f "${input%.*}__6.mp4" ]; then
        # rm "$input"
        echo "would have deleted"
    else
        echo "error: no output file"
        break
    fi
  done
}

function wmv_to_mp4_subdir_1 {
  for g in *; do
      if [ -d "$g" ]; then
        echo $(pwd)/$g
        cd "$g"

        for input in *.wmv;
        do
          pwdvar=$(pwd)
          tpwdvar=${pwdvar:0:25}
          if [ $tpwdvar != "/home/mxw/Documents/qccp-" ]; then
            echo "ERROR"
            exit 1
          elif [ -f "$input" ]; then
            echo $(pwd)/$input

            ffmpeg -i $input -vcodec libx265 -crf 21 -preset slow "${input%.*}__6.mp4"
            if [ -f "${input%.*}__6.mp4" ]; then
                # rm "$input"
                echo "would have deleted"
                sleep 5
            else
                echo "error: no output file"
                exit 1
            fi
          fi
        done

        cd ..
        sleep 5
      fi
  done
}


function halfframev {
  input=$1

  ffmpeg -i $1 -vf "scale=trunc(iw/4)*2:trunc(ih/4)*2" -c:v libx264 -crf 24 "${input%.*}-1.mp4"
  if [ -f "${input%.*}-1.mp4" ]; then
     rm "$1"
  else
     echo "error: no output file"
  fi
}


function mtm {
  input=$1
  # ffmpeg -i $1 -qscale 0 "${input%.*}.mp4"
  ffmpeg -i $1 -movflags faststart -profile:v high -level 4.2 "${input%.*}-2.mp4"
}

# slice_video asdf.mp4 00:02:41.000 45
# https://superuser.com/questions/377343/cut-part-from-video-file-from-start-position-to-end-position-with-ffmpeg
function slice_video {
  filename=$1
  start=$2
  duration=$3
  ffmpeg -ss $start -i $filename -t $duration -map 0 -c copy "${filename%.*}-excerpt.${filename##*.}"
}























### ~~ IMAGES ~~  ###

# Convert webp:
# dwebp file.webp -o abc.png
#
# for file in $(ls *.webp)
# do
#   dwebp $file -o ${file:0:-5}.png
# done
function wtp {
  input=$1
  dwebp "$input" -o "${input%.*}.png"
}

# Remove EXIF data from an image:
# mogrify -strip a.jpg

# "present directory"
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



















### ~~ SYSTEM ~~ ###

alias spo='sudo poweroff'


alias sa='sudo apt'
alias sai='sudo apt install'
alias sdi='sudo dpkg -i'
alias sau='sudo apt update'
alias saug='sudo apt upgrade'

# "list installed packages"
alias lip='apt list --installed'

# To remove a package:
# sudo apt remove <application_name>


alias fix_wifi='sudo systemctl restart network-manager.service'

alias gcs='google-chrome-stable'


# Check motherboard, CPU, GPU temp readings:
# sensors

# To edit keymappings on Ubuntu 20.04, visit /usr/share/X11/xkb/symbols/
# and edit e.g. the pc file.
alias exkbpc='sudo vim /usr/share/X11/xkb/symbols/pc'

# https://unix.stackexchange.com/questions/202891/how-to-know-whether-wayland-or-x11-is-being-used
alias xorwayland="loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}'"

alias vc='veracrypt'


function save_power {
  sudo tlp start battery
  sudo pm-powersave battery
}

function go_fast {
  sudo tlp start ac
  sudo pm-powersave ac
}

# MSR means Model-specific register. 0x19a has something to do with clock modulation / power
# conservation.
#
# See: http://askubuntu.com/questions/792605/ubuntu-16-04-lts-too-slow-after-suspend-and-resume
alias rd_speed_msr='sudo rdmsr -a 0x19a'
alias wr_speed_msr='sudo wrmsr -a 0x19a 0x0'



















### ~~ DEVELOPMENT ~~ ###


alias untracked_files='git ls-files --others --exclude-standard'
alias utf='untracked_files'
alias sutf='subl $(untracked_files)'

alias glsm='git ls-files -m'

alias rmrfdt='rm -rf dist/* tmp/*'



alias umf='git diff --name-only --diff-filter=U'

# This will open a bunch of empty (new) files if I don't run it from the root
# of the repo. TODO: fix this.
# alias sumf='subl $(umf)'
# function sumf {
#   pushd EDIT
#   subl $(umf)
#   popd
# }


# export SET_IN_REDIS_IN_DEVELOPMENT='true'
alias start_redis='sudo /etc/init.d/redis_6379 start'

# 2022-05-01 commented out the following, new rvm doesn't seem to like it?
#
# For http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html#awscli-install-linux-path
# export PATH=~/.local/bin:$PATH

alias pf='pip freeze | grep -v 'pkg-resources==0.0.0''

function rpc {
  rm $(find -name *.pyc)
}

function drm {
  docker rm -f $(docker ps -a -q)
}

alias py='python3'
alias pt='pytest'


alias rdm='rake db:migrate'

alias es='ember serve --proxy http://localhost:3200'


function nsv {
  npm show $1 version
}

function egm {
  ember g model --pod true "$@"
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

alias rc='rails c'

function rbc {
  rubocop -D -a $(changed_relative_to_main | grep -v '\.html\.erb$' | grep -v Gemfile | grep -v '\.yml$' | grep -v '/templates/' | grep -v 'schema\.rb')
}

function rbcna {
  rubocop -D $(changed_relative_to_main | grep -v '\.html\.erb$' | grep -v Gemfile | grep -v '\.yml$' | grep -v '/templates/' | grep -v 'schema\.rb')
}

function rbca {
  rubocop -D -a "$@"
}

function rbd {
  rubocop -D "$@"
}

function catchmail {
  gem install mailcatcher
  mailcatcher
  google-chrome-stable http://127.0.0.1:1080
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







### ~~ GIT ~~ ###

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


function gdce {
  git diff --cached -- . ':(exclude)'$1
}

alias gdcep="git diff --cached -- . ':(exclude)package-lock.json'"


alias gs='git status'
alias gcma='git checkout main'
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
alias grm='git rebase main'
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

# "Last Commit Message"
alias lcm='git log -1 --pretty=%B'

function gdcm {
  local branch=$(current_branch)

  if [ "main" == $branch ];
  then
    echo 'Already on main'
    return
  fi
  git checkout main
  git branch -D $branch
}

# In the current feature branch-- how many commits do we have that aren't in main?
function commits_ahead_of_main {
  git rev-list $(current_branch) --not main | wc -l
}

# Rebase feature branch.
alias rfb='git rebase -i HEAD~$(commits_ahead_of_main)'

alias cam='commits_ahead_of_main'


function gssp {
  eval "git stash show -p stash@{$1}"
}

function gcount {
  git log $1..$2 --pretty=oneline | wc -l
}

function dno {
  git diff --name-only
}

function op {
  git status --short | awk '$1 ~ /^M|A|U/ {print $2}'
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


alias changed_relative_to_main='g diff --name-only main'
alias crm='changed_relative_to_main'


function delete_merged_branches {
  if [ "main" != $(current_branch) ];
  then
    echo 'The current branch is not main!'
    return
  fi
  # To delete local branches that have been merged, run:
  git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

function delete_elis_branches {
  if [ "main" != $(current_branch) ];
  then
    echo 'The current branch is not main!'
    return
  fi
  git branch | grep '^  eli-' | xargs -n 1 git branch -D
}

alias desbs='delete_elis_branches'









### ~~ MC ~~ ###

# MC_HOME is not exported, since no child process should need to access it.
# alias cs="cd $MC_HOME" doesn't work on OSX without using double quotes.
MC_HOME="$HOME/Documents/repos/mc"
MC_EMBER_HOME="$MC_HOME/mentorcollective-ember"
MC_RAILS_HOME="$MC_HOME/mentorcollective-rails"

# alias vepr='gcs https://github.com/shearwaterintl/mentorcollective-ember/pulls &'
# alias vrpr='gcs https://github.com/shearwaterintl/mentorcollective-ember/pulls &'
alias cm="cd ~/Documents/repos/mc/mentorcollective-rails/"

# alias hrrdm='heroku run rake db:migrate -a shearwater'
# alias hrrdmd='heroku run rake db:migrate -a shearwater-demo'
# alias hrrdms='heroku run rake db:migrate -a shearwater-staging'

# alias rcpts='rake copy_production_to_staging'

# TODO: rework the "force" versions of these commands to use:
#   git subtree push --prefix web heroku master
# or its ilk. When deleting and then re-creating the remote branch, Heroku's deploy hooks don't
# always pick it up.

# function rdd {
#   # Implement!
#   exit 1
# }

# function rrfpuc {
#   pushd $MC_RAILS_HOME
#   rake restore_from_most_recent_production_backup
#   popd
# }

# function rrfp {
#   pushd $MC_RAILS_HOME
#   rake restore_from_most_recent_saved_production_backup
#   popd
# }

# function rc {
#   pushd $MC_RAILS_HOME
#   bin/rails console
#   popd
# }

# function rt {
#   pushd $MC_RAILS_HOME
#   rake test
#   popd
# }

# function rtns {
#   pushd $MC_RAILS_HOME
#   SHEARWATER_DONT_SKIP_TESTS=true rake test
#   popd
# }

# alias hrrc='heroku run rails console --app shearwater' etc.
# alias hlt='heroku logs --tail --app shearwater'
# alias hpgbc='heroku pg:backups capture -a shearwater'
# alias hppas='heroku pipelines:promote -a shearwater-staging'










### ~~ RTR ~~ ###
alias crr="cd ~/Documents/repos/rtr/rtr"
alias crf="cd ~/Documents/repos/rtr/fe"

alias rs='crr && rails server'
alias fs='crf && npm run dev'










### ~~ OTHER ~~ ###


# Ecryption and decryption:
alias enc='gpg --pinentry-mode loopback --symmetric'
alias dec='gpg --pinentry-mode loopback --decrypt'
#
# Locally, --pinentry-mode loopback seems to use cmdline input instead of the
# UI dialog.

# Install Discord Update
function idu {
  echo "make it autodelete bitch"
  # cd ~/Downloads
  # sdi $(find -name discord* | head -n 1 | tr -d '\n')
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
  if [ $(hostname) = "mxw-z490-e" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@z490\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
alias l='ls -alF'
alias la='ls -A'
# alias l='ls -CF'

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
  if [ $(hostname) = "mjw-p1gen2" ]; then
    echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
  else
    sudo su -c "echo $1 > /sys/class/backlight/acpi_video0/brightness"
  fi
}

alias rbr='read_brightness'
function read_brightness {
  if [ $(hostname) = "mjw-p1gen2" ]; then
    cat /sys/class/backlight/intel_backlight/brightness
  else
    cat /sys/class/backlight/acpi_video0/brightness
  fi
}


# 2022-05-01 commented out the following, new rvm doesn't seem to like it?
  # I changed the heroku directory to be added to the end of the PATH rather than the beginning--
  # this was causing issues with RVM.

  # Added by the Heroku Toolbelt:
  # export PATH="$PATH:/usr/local/heroku/bin"

  # export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting





export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ $(hostname) = "mkw-p1gen2" ]; then
  alias python=python3
fi

# Via https://stackoverflow.com/a/53825858/1067145, to fix Hugo error
# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

[ -f "/home/mjw/.ghcup/env" ] && source "/home/mjw/.ghcup/env" # ghcup-env


# 2023-10-14 https://asdf-vm.com/guide/getting-started.html
if [ $(hostname) = "mxw-z490-e" ]; then
  . "$HOME/.asdf/asdf.sh"
  . "$HOME/.asdf/completions/asdf.bash"
fi

