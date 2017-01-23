#!/usr/bin/env python

import os
import shlex
import subprocess

try:
    home = os.environ['HOME']
except KeyError:
    print('Error: $HOME is not defined')

# The files to create symbolic links to
# The format of this array is:
#   (source, [destination1, destination2, ...])
files = [
            ('bash_profile',  ['.bash_profile']),
            ('git_template',  ['.git_template']),
            ('gitignore',     ['.config/git/ignore']),
            ('hammerspoon',   ['.hammerspoon']),
            ('karabiner.xml', ['Library/Application Support/Karabiner/private.xml']),
            ('pylintrc',      ['.pylintrc']),
            ('slate.js',      ['.slate.js']),
            ('tmux.conf',     ['.tmux.conf']),
            ('vimrc',         ['.vimrc', '.config/nvim/init.vim']),
            ('zshrc',         ['.zshrc'])
        ]

# Commands to run after creating symbolic links
# Each command should be a string with all paths/variables expanded
commands = [
               ''.join(['git config --global init.templatedir "', home, '/.git_template"'])
           ]

# The path, relative to $HOME, where the actual files are kept
sourcePrefix      = 'dotfiles'

# The path, relative to $HOME, to create symbolic links
destinationPrefix = ''

# The path, relative to $HOME, to place old dotfiles
oldPrefix         = 'dotfiles_old'

def createLinks():
    # resolve the full paths of directories
    if sourcePrefix != '':
        sourceFolder      = '/'.join([home, sourcePrefix])
    else:
        sourceFolder = home

    if destinationPrefix != '':
        destinationFolder = '/'.join([home, destinationPrefix])
    else:
        destinationFolder = home

    if oldPrefix != '':
        oldFolder         = '/'.join([home, oldPrefix])
    else:
        oldFolder = home

    # Abort if source is invalid
    if not os.path.isdir(sourceFolder):
        print('Error: invalid source folder')
        return

    # Create old dotfile directory
    if not os.path.isdir(oldFolder):
        print(' '.join(['Creating directory', oldFolder]))
        os.makedirs(oldFolder)

    for item in files:
        # Full path of source file/folder
        source = '/'.join([sourceFolder, item[0]])
        if os.path.isfile(source) or os.path.isdir(source):
            for suffix in item[1]:
                # Full path of destination
                destination = '/'.join([destinationFolder, suffix])
                # Destination file already exists
                if os.path.isfile(destination) or os.path.isdir(destination):
                    newLocation = '/'.join([oldFolder, suffix])
                    if not os.path.exists(os.path.dirname(newLocation)):
                        os.makedirs(os.path.dirname(newLocation))
                    print(' '.join(['Moving already existing', destination, 'to', newLocation]))
                    os.rename(destination, newLocation)
                # Destination directory doesn't exists -- must create it
                if not os.path.exists(os.path.dirname(destination)):
                    os.makedirs(os.path.dirname(destination))
                print(' '.join([source, '-->', destination]))
                os.symlink(source, destination)
        else:
            print(' '.join(['Error:', source, 'is not a file or folder']))

def executeExtraCommands():
    for command in commands:
        subprocess.call(shlex.split(command))

if __name__ == "__main__":
    createLinks()
    executeExtraCommands()
