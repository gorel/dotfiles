# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set up the history to be saved on exit
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend

# Combine multiline commands into one in history
shopt -s cmdhist

# Ignore duplicates, ls without options and builtin commands
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit:k"

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

# allow a 256 color terminal
if [ "$COLORTERM" == "gnome-terminal" ]; then
    export TERM=xterm-256color
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
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

# Go up N directories, or just 1 by default
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++)); do
    d=$d/..
  done

  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

vc(){
  if hg -q stat; then
    hg "$@"
  else
    git "$@"
  fi
}

fvim(){
  find . -iname "$1" -exec vim {} + ;
}

ffvim(){
  find . -iname "*$1*" -exec vim {} + ;
}

killport(){
  lsof -ti:$1 | xargs kill -9
}

fin(){
  find . -iname "*$1*"
}

killmosh(){
  kill $(ps --no-headers --sort=start_time -C mosh-server -o pid | head -n -1)
}

viewcsv(){
  sed 's/,,/, ,/g;s/,,/, ,/g' "$1" | column -s, -t | less -#2 -N -S
}

####################
# Private ENV vars #
####################
touch "$HOME/.env_vars"
source "$HOME/.env_vars"

###########
# Exports #
###########
export EDITOR=vim
export VISUAL=vim
export PYTHONDONTWRITEBYTECODE=True
export LANG=en_US.UTF-8

# Makefile autocomplete
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

########
# Tmux #
########
alias tmux="TERM=xterm-256color tmux -2"

###############
# Line editor #
###############
set -o vi
stty stop undef

################
# PATH exports #
################
export PATH="$HOME/bin:$PATH"

###############
# Final setup #
###############
mkdir -p "$HOME/.vim_backup"
