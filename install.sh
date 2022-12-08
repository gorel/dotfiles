#!/bin/bash

MAC=false
if command -v brew &>/dev/null; then
	MAC=true
fi

echo "This will overwrite various .*rc files in your homedir."
read -rp "Continue? [Y/n] " continue_var
if [[ "$continue_var" != "y" && "$continue_var" != "Y" ]]; then
	echo "Exiting"
	exit 0
fi

if ! command -v cargo &>/dev/null; then
	echo "Installing Cargo"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v nvim &>/dev/null; then
	echo "Installing neovim"
	if ! $MAC; then
		sudo add-apt-repository ppa:neovim-ppa/unstable
		sudo apt-get update
		sudo apt-get install -y neovim
	else
		brew -install --head neovim
	fi
fi

if ! command -v starship &>/dev/null; then
	echo "Installing starship"
	curl -sS https://starship.rs/install.sh | sh
fi

if ! command -v j &>/dev/null; then
	echo "Installing autojump"
	if ! $MAC; then
		sudo apt-get install -y autojump
	else
		brew install autojump
	fi
fi

if ! command -v mcfly &>/dev/null; then
	echo "Installing mcfly"
	curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
fi

if ! command -v batcat &>/dev/null; then
	echo "Installing bat"
	if ! $MAC; then
		sudo apt-get install -y bat
	else
		brew install bat
	fi
fi

if ! command -v rg &>/dev/null; then
	echo "Installing ripgrep"
	if ! $MAC; then
		sudo apt-get install ripgrep
	else
		brew install ripgrep
	fi
fi

if ! command -v delta &>/dev/null; then
	echo "Installing delta"
	cargo install git-delta
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

echo "Link .gitconfig and git-profiles"
ln -nsf "$PWD/.gitconfig" "$HOME/.gitconfig"
ln -nsf "$PWD/git-profiles" "$HOME/.git-profiles"

echo "Link .hgrc"
ln -nsf "$PWD/.hgrc" "$HOME/.hgrc"

echo "Link .inputrc"
ln -nsf "$PWD/.inputrc" "$HOME/.inputrc"

echo "Link .vimrc"
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

echo "Link wezterm files"
mkdir -p "$HOME/.config/"
ln -nsf "$PWD/wezterm/" "$HOME/.config/wezterm"

echo "Link global_requirements.txt"
mkdir -p "$HOME/.config/"
ln -nsf "$PWD/global_requirements.txt" "$HOME/.config/global_requirements.txt"

echo "Link starship config"
mkdir -p "$HOME/.config/"
ln -nsf "$PWD/starship.toml" "$HOME/.config/starship.toml"

echo "All done! You should run 'source ~/.zshrc' now to get the new changes."
