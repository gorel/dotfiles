echo "This will overwrite various .*rc files in your homedir."
read -p "Continue? [Y/n] " continue_var
if [[ "$continue_var" != "y" && "$continue_var" != "Y" ]]; then
    echo "Exiting"
    exit 0
fi

read -p "Should DEVSERVER env var be set? [Y/n] " devserver_env
if [[ "$devserver_env" == "y" || "$devserver_env" == "Y" ]]; then
    echo "Writing DEVSERVER=1 to .env_vars"
    echo "DEVSERVER=1" >> "$HOME/.env_vars"
fi

cd "$(dirname "$0")"
echo "My directory is $(pwd)"
echo "Link .bashrc"
ln -s "$PWD/.bashrc" "$HOME/.bashrc"
ln -s "$PWD/.bash_aliases" "$HOME/.bash_aliases"

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
mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"

echo "Link .tmux.conf"
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"

echo "Installing neovim"
mkdir "$HOME/bin"
curl -fLO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
tar xzf nvim-linux64.tar.gz
mv nvim-linux64/bin/nvim "$HOME/bin/nvim"
rm nvim-linux64.tar.gz
rm -rf nvim-linux64/

echo "All done! You should run 'source ~/.bashrc' now to get the new changes."
