#!/bin/bash

dotfilesdir=$HOME/dotfiles
olddotfilesdir=$HOME/dotfiles_old
files="bash_profile zshrc vimrc tmux.conf slate.js ycm_extra_conf.py velocity.py karabiner.xml packages.sh git_template"

echo "Creating old dotfiles directory $olddotfilesdir"
mkdir -p $olddotfilesdir

for file in $files; do
    echo "Moving $HOME/.$file to $olddotfilesdir/.$file"
    mv $HOME/.$file $olddotfilesdir/.$file
    echo "Creating symlink to $dotfilesdir/$file in $HOME/.$file"
    ln -s $dotfilesdir/$file $HOME/.$file
done

# neovim config goes in ~/.config/nvim/
echo "Moving $HOME/.config/nvim/init.vim to $olddotfilesdir/init.vim"
mv $HOME/.config/nvim/init.vim $olddotfilesdir/init.vim
echo "Creating symlink to $dotfilesdir/vimrc in $HOME/.config/nvim/init.vim"
ln -s $dotfilesdir/vimrc $HOME/.config/nvim/init.vim

echo "Adding $HOME/.git_template to global git config as init.templatedir"
git config --global init.templatedir "$HOME/.git_template"
