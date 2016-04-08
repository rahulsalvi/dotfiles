#!/bin/bash

dotfilesdir=$HOME/dotfiles
files="bash_profile vimrc tmux.conf slate.js git_template"

for file in $files; do
    echo "Creating symlink to $HOME/.$file in $HOME"
    ln -s $dotfilesdir/.$file $HOME/.$file
    echo "Created symlink $HOME/.$file"
done
