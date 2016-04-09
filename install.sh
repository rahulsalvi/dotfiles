#!/bin/bash

dotfilesdir=$HOME/dotfiles
olddotfilesdir=$HOME/dotfiles_old
files="bash_profile vimrc tmux.conf slate.js git_template"

echo "Creating old dotfiles directory $olddotfilesdir"
mkdir -p $olddotfilesdir

for file in $files; do
    echo "Moving $HOME/.$file to $olddotfilesdir/.$file"
    mv $HOME/.$file $olddotfilesdir/.$file
    echo "Creating symlink to $dotfilesdir/.$file in $HOME/.$file"
    ln -s $dotfilesdir/.$file $HOME/.$file
done

echo "Adding $HOME/.git_template to global git config as init.templatedir"
git config --global init.templatedir '$HOME/.git_template'
