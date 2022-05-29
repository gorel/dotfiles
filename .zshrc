# History
export HISTORY_IGNORE="&:ls:[bf]g:exit:k:q"

setopt rm_star_silent
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

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
if [ -f ~/.aliases ]; then
    . ~/.aliases
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
export PATH="$HOME/bin:$PATH"

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
