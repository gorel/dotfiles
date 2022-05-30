#!/usr/bin/bash

echo "This will overwrite various .*rc files in your homedir."
read -rp "Continue? [Y/n] " continue_var
if [[ "$continue_var" != "y" && "$continue_var" != "Y" ]]; then
    echo "Exiting"
    exit 0
fi

read -rp "Should DEVSERVER env var be set? [Y/n] " devserver_env
if [[ "$devserver_env" == "y" || "$devserver_env" == "Y" ]]; then
    echo "Writing DEVSERVER=1 to .env_vars"
    echo "DEVSERVER=1" >> "$HOME/.env_vars"
fi

if command -v nvim &>/dev/null; then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim
fi

if command -v starship &>/dev/null; then
  echo "Installing starship"
  curl -sS https://starship.rs/install.sh | sh
fi

if command -v j &>/dev/null; then
  echo "Installing autojump"
  sudo apt-get install -y autojump
fi

if command -v mcfly &>/dev/null; then
  echo "Installing mcfly"
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
fi

if command -v batcat &>/dev/null; then
    echo "Installing bat"
    sudo apt-get install -y bat
fi

if command -v rg &>/dev/null; then
    echo "Installing ripgrep"
    sudo apt-get install ripgrep
fi

if command -v diff-so-fancy &>/dev/null; then
    sudo add-apt-repository ppa:aos1/diff-so-fancy
    sudo apt update
    sudo apt-get install -y diff-so-fancy
fi

cd "$(dirname "$0")" || exit 1
echo "Link .bashrc and .zshrc"
ln -nsf "$PWD/.bashrc" "$HOME/.bashrc"
ln -nsf "$PWD/.zshrc" "$HOME/.zshrc"
if [ ! -d "$HOME/.zgen" ]; then
  echo "Cloning zgen"
  git clone "https://github.com/tarjoilija/zgen.git" "${HOME}/.zgen"
fi
ln -nsf "$PWD/.aliases" "$HOME/.aliases"

echo "Link .dircolors"
ln -nsf "$PWD/.dircolors" "$HOME/.dircolors"

echo "Link .gitconfig"
ln -nsf "$PWD/.gitconfig" "$HOME/.gitconfig"

echo "Link .hgrc"
ln -nsf "$PWD/.hgrc" "$HOME/.hgrc"

echo "Link .inputrc"
ln -nsf "$PWD/.inputrc" "$HOME/.inputrc"

echo "Link .vimrc and neovim init.vim"
ln -nsf "$PWD/.vimrc" "$HOME/.vimrc"

echo "Link .tmux.conf"
ln -nsf "$PWD/.tmux.conf" "$HOME/.tmux.conf"

echo "Link nvim files"
mkdir -p "$HOME/.config/"
ln -nsf "$PWD/nvim/" "$HOME/.config/nvim"

echo "Run PackerSync"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Link starship config"
mkdir -p "$HOME/.config/"
ln -nsf "$PWD/starship.toml" "$HOME/.config/starship.toml"

echo "Link git_env_password.sh script"
mkdir -p "$HOME/bin/"
ln -nsf "$PWD/git_env_password.sh" "$HOME/bin/git_env_password.sh"

echo "All done! You should run 'source ~/.zshrc' now to get the new changes."
