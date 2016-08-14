# dotfiles
Configuration files for zsh, tmux, vim, and more.

## Requirements
  - OSX (untested on other operating systems, but shouldn't be hard to adapt)
  - zsh
    - Prezto (https://github.com/sorin-ionescu/prezto)
  - vim
    - vim-plug (https://github.com/junegunn/vim-plug)
  - tmux
    - Tmux Plugin Manager (https://github.com/tmux-plugins/tpm)
  - Velocity theme
    - A font with powerline characters
    - Python3
  - Some Unix know-how

## Setup
    chsh -s <Path to zsh>
    cd $HOME
    git clone https://github.com/rahulsalvi/dotfiles.git
    cd dotfiles
    ./install.sh
  - Terminal
    - Preferences --> Import "Solarized Dark.terminal"
    - Preferences --> Import "Solarized Light.terminal"
  - Karabiner (https://pqrs.org/osx/karabiner/)
    - Misc & Uninstall --> Open private.xml
    - Change contents to
        ```
        <?xml version="1.0"?>
        <root>
            <include once="true" path="{{ ENV_HOME }}/.karabiner.xml" />
        </root>
        ```
  - Seil (https://pqrs.org/osx/karabiner/seil.html.en)
    - Change Caps Lock to PC Application Key
  - Slate (https://github.com/jigish/slate)