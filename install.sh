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

mkdir -p "$HOME/.config"

echo "Link .gitconfig and git-profiles"
mkdir -p ".config"
ln -nsf "$PWD/git/config" "$HOME/.gitconfig"
ln -nsf "$PWD/git/profiles" "$HOME/.config/git-profiles"
ln -nsf "$HOME/.config/git-profiles/personal" "$HOME/.git-profile"

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
		brew install --head neovim
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
files=(
	".aliases"
	".bashrc"
	".dircolors"
	".hgrc"
	".inputrc"
	".tmux.conf"
	".vimrc"
	".zshrc"
)
for f in "${files[@]}"; do
	ln -nsf "$PWD/$f" "$HOME/$f"
done

config_files=(
	"global_requirements.txt"
	"nvim"
	"starship.toml"
	"wezterm"
)
for f in "${config_files[@]}"; do
	ln -nsf "$PWD/$f" "$HOME/.config/$f"
done

if [ ! -d "$HOME/.zgen" ]; then
	echo "Cloning zgen"
	git clone "https://github.com/tarjoilija/zgen.git" "${HOME}/.zgen"
fi

echo "Run PackerSync"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "All done! You should run 'source ~/.zshrc' now to get the new changes."
