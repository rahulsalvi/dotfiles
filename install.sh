#!/bin/bash

dotfilesdir=$HOME/dotfiles
olddotfilesdir=$HOME/dotfiles_old
files="bash_profile zshrc vimrc tmux.conf slate.js velocity.py karabiner.xml git_template"

echo "Creating old dotfiles directory $olddotfilesdir"
mkdir -p $olddotfilesdir

for file in $files; do
    echo "Moving $HOME/.$file to $olddotfilesdir/.$file"
    mv $HOME/.$file $olddotfilesdir/.$file
    echo "Creating symlink to $dotfilesdir/$file in $HOME/.$file"
    ln -s $dotfilesdir/$file $HOME/.$file
done

# neovim config belongs at ~/.config/nvim/init.vim
echo "Moving $HOME/.config/nvim/init.vim to $olddotfilesdir/init.vim"
mv $HOME/.config/nvim/init.vim $olddotfilesdir/init.vim
echo "Creating symlink to $dotfilesdir/vimrc in $HOME/.config/nvim/init.vim"
ln -s $dotfilesdir/vimrc $HOME/.config/nvim/init.vim

# global gitignore belongs at ~/.config/git/ignore
echo "Moving $HOME/.config/git/ignore to $olddotfilesdir/ignore"
mv $HOME/.config/git/ignore $olddotfilesdir/ignore
echo "Creating symlink to $dotfilesdir/gitignore in $HOME/.config/git/ignore"
ln -s $dotfilesdir/gitignore $HOME/.config/git/ignore

echo "Adding $HOME/.git_template to global git config as init.templatedir"
git config --global init.templatedir "$HOME/.git_template"
