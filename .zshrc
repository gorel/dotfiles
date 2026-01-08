#!/usr/bin/env zsh

# History
export HISTORY_IGNORE="&:ls:[bf]g:exit:k:q"

setopt rm_star_silent
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export MCFLY_KEY_SCHEME=vim

# Locale exports because some stuff is breaking on devserver?
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

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

killport(){
  lsof -ti:$1 | xargs kill -9
}

################################
# Private ENV vars and aliases #
################################
touch "$HOME/.env_vars"
source "$HOME/.env_vars"
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi
if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi
if [ -f "$HOME/.secure-aliases" ]; then
    source "$HOME/.secure-aliases"
fi

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  zgen oh-my-zsh

  # plugins

  zgen oh-my-zsh plugins/vi-mode
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/colored-man-pages
  zgen oh-my-zsh plugins/autojump # note: install autojump first

  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen load Tarrasch/zsh-autoenv

  # generate the init script from plugins above
  zgen save
fi

##############
# Enable vim #
##############
bindkey -v

###############
# Autcomplete #
###############
bindkey '^j' autosuggest-accept

################
# PATH exports #
################
export PATH="/usr/local/go/bin:$PATH"
export PATH="/$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotbin/:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
source "$HOME/.cargo/env"

##################################
# Hide stupid warnings in Python #
##################################
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1

#############
# Functions #
#############
function rename-wezterm-title {
  echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $1 | base64)\x07"
}

function squash-all { 
  git reset --soft $(git merge-base main HEAD)
  git commit -m "$1"
}

function colorcode {
  sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/''
}

##########
# prompt #
##########
eval "$(starship init zsh)"

###############
# ctrl+r hist #
###############
eval "$(mcfly init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


#####################
# NVM to manage npm #
#####################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##########
# direnv #
##########
eval "$(direnv hook zsh)"

##########
# devctl #
##########
if [ -f "$HOME/.devctl-completion.zsh" ]; then
  source "$HOME/.devctl-completion.zsh"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export AWS_VAULT_PROMPT=ykman

# Prioritize homebrew's version of Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Laptop setup script
export PATH="/tmp/engineering-laptop-setup/bin:$PATH"
function updateclaude() {
  laptop.update && laptop.upgrade --tags claude
}

source "$HOME/.cmp.zsh"
