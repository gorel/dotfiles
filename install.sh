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
echo "Copy .bashrc"
cp .bashrc $HOME/.bashrc
echo "Copy .gitconfig"
cp .gitconfig $HOME/.gitconfig
echo "Copy .hgrc"
cp .hgrc $HOME/.hgrc
echo "Copy .inputrc"
cp .inputrc $HOME/.inputrc
echo "Copy .vimrc"
cp .vimrc $HOME/.vimrc
echo "Copy .tmux.conf"
cp .tmux.conf $HOME/.tmux.conf

echo "Installing vim plugins"
mkdir -p "$HOME/.vim/bundle/"
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
fi
vim +PluginInstall +qall

echo "All done! You should run 'source ~/.bashrc' now to get the new changes."
