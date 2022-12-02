# History
export HISTORY_IGNORE="&:ls:[bf]g:exit:k:q"

setopt rm_star_silent
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export GIT_ASKPASS="git_env_password.sh"
export MCFLY_KEY_SCHEME=vim

# Locale exports because some stuff is breaking on devserver?
export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"
export LC_CTYPE="en_US.UTF8"

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

####################
# Private ENV vars #
####################
touch "$HOME/.env_vars"
source "$HOME/.env_vars"

# Alias definitions.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

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

  # generate the init script from plugins above
  zgen save
fi

###############################
# Useful when mosh gets stuck #
###############################
killmosh(){
  kill $(ps --no-headers --sort=start_time -C mosh-server -o pid | head -n -1)
}

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
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
source "$HOME/.cargo/env"

##################################
# Hide stupid warnings in Python #
##################################
export PYTHONWARNINGS="ignore"

############
# FB Stuff #
############
function pwt() {
  eval "$* 2>&1" | pastry --title "$*";
}

function pwto() {
  eval "$* 2>&1" | tee >(pastry --title "$*");
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
