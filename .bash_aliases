alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias b="cd -"
alias ll="ls -l"
alias lo="ls -o"
alias lh="ls -lh"
alias la="ls -la"
alias sl="ls"
alias l="ls"
alias s="ls"
alias hist="history"
alias mkae="make"
alias apt-get="sudo apt-get"
alias c="clear"
alias cc='echo -q "\n\n\n\n\n\033[0;31mCLEAR SCREEN\033[0m\n\n\n\n\n"'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi="vim"
alias edit="vim"
alias py="python3"
alias py2="python2"
alias py3="python3"
alias g="git"
alias h="hg"
alias tt="tee /dev/tty"
alias T="tee /dev/tty"
alias ta="tmux attach"
alias td="tmux detach"
alias tl="tmux ls"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'
alias hc="hg ci -m"
alias fb="mosh fb"

if [ -z "$DEVSERVER" ]; then
  alias adp="jf s -n"
  alias al="arc lint"
  alias af="arc feature"
  alias afc="arc feature --cleanup"
  alias ham="hg amend"
  alias had="ham && jf s"
  alias hads="ham && jf s --draft"
  alias hdr="hg diff -r .^"

  # cd shortcuts
  alias CF="cd ~/configerator"
  alias FBC="cd ~/fbcode"
  alias LIFT="cd ~/dataswarm/tasks/adsatlas/adstudy"
  alias PL="cd ~/fbcode/measurement/private_lift/"
  alias PCS="cd ~/fbcode/fbpcs/"
  alias PCF="cd ~/fbcode/fbpcf/"
  alias PCP="cd ~/fbcode/fbpcp/"
fi
