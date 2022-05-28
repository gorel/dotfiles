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

if command -v mcfly &>/dev/null; then
  echo "Installing mcfly"
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
fi

cd "$(dirname "$0")" || exit 1
echo "Link .bashrc and .zshrc"
ln -s "$PWD/.bashrc" "$HOME/.bashrc"
ln -s "$PWD/.zshrc" "$HOME/.zshrc"
if [ ! -d "$HOME/.zgen" ]; then
  echo "Cloning zgen"
  git clone "https://github.com/tarjoilija/zgen.git" "${HOME}/.zgen"
fi
ln -s "$PWD/.aliases" "$HOME/.aliases"

echo "Link .dircolors"
ln -s "$PWD/.dircolors" "$HOME/.dircolors"

echo "Link .gitconfig"
ln -s "$PWD/.gitconfig" "$HOME/.gitconfig"

echo "Link .hgrc"
ln -s "$PWD/.hgrc" "$HOME/.hgrc"

echo "Link .inputrc"
ln -s "$PWD/.inputrc" "$HOME/.inputrc"

echo "Link .vimrc and neovim init.vim"
ln -s "$PWD/.vimrc" "$HOME/.vimrc"

echo "Link .tmux.conf"
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"

echo "Link nvim files"
mkdir -p "$HOME/.config/"
ln -s "$PWD/nvim/" "$HOME/.config/nvim"

echo "Run PackerSync"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Link starship config"
mkdir -p "$HOME/.config/"
ln -s "$PWD/starship.toml" "$HOME/.config/starship.toml"

echo "All done! You should run 'source ~/.bashrc' now to get the new changes."
