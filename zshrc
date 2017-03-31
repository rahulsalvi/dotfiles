# Determine light or dark terminal
termname=$(osascript -e "tell first window of application \"Terminal\" to return name of current settings as string")
if [[ $termname == "Solarized Light" ]] ; then
    export BACKGROUND=light
else
    export BACKGROUND=dark
fi
unset termname

# Select modules to load
zstyle ':prezto:module:syntax-highlighting' color 'yes'
zstyle ':prezto:load' pmodule \
    'environment' \
    'utility' \
    'editor' \
    'directory' \
    'history' \
    'completion' \
    'git' \
    'macports' \
    'archive' \
    'syntax-highlighting' \
    'history-substring-search'

# Vi key bindings
zstyle ':prezto:module:editor' key-bindings 'vi'
bindkey -M vicmd '/' history-incremental-search-backward

# Syntax highlighting colors and styles
if [[ $BACKGROUND == "light" ]] ; then
    zstyle ':prezto:module:syntax-highlighting' styles \
        'unknown-token' 'fg=red' \
        'reserved-word' 'fg=red,bold' \
        'alias' 'fg=green' \
        'builtin' 'fg=green' \
        'function' 'fg=green' \
        'command' 'fg=green' \
        'precommand' 'fg=magenta' \
        'commandseparator' 'fg=magenta,bold' \
        'hashed-command' 'fg=red' \
        'path' 'fg=cyan' \
        'path-prefix' 'fg=cyan' \
        'globbing' 'fg=magenta' \
        'history-expansion' 'none' \
        'single-hyphen-option' 'none' \
        'double-hyphen-option' 'none' \
        'back-quoted-argument' 'none' \
        'single-quoted-argument' 'fg=cyan' \
        'double-quoted-argument' 'fg=cyan' \
        'dollar-quoted-argument' 'fg=cyan' \
        'back-double-quoted-argument' 'fg=cyan' \
        'back-dollar-quoted-argument' 'fg=cyan' \
        'assign' 'none' \
        'redirection' 'fg=magenta,bold' \
        'default' 'none'
else
    zstyle ':prezto:module:syntax-highlighting' styles \
        'unknown-token' 'fg=red' \
        'reserved-word' 'fg=red,bold' \
        'alias' 'fg=green' \
        'builtin' 'fg=green' \
        'function' 'fg=green' \
        'command' 'fg=green' \
        'precommand' 'fg=yellow' \
        'commandseparator' 'fg=magenta,bold' \
        'hashed-command' 'fg=red' \
        'path' 'fg=blue' \
        'path-prefix' 'fg=blue' \
        'globbing' 'fg=magenta' \
        'history-expansion' 'none' \
        'single-hyphen-option' 'none' \
        'double-hyphen-option' 'none' \
        'back-quoted-argument' 'none' \
        'single-quoted-argument' 'fg=cyan' \
        'double-quoted-argument' 'fg=cyan' \
        'dollar-quoted-argument' 'fg=cyan' \
        'back-double-quoted-argument' 'fg=cyan' \
        'back-dollar-quoted-argument' 'fg=cyan' \
        'assign' 'none' \
        'redirection' 'fg=magenta,bold' \
        'default' 'none'
fi

# Load Prezto modules
[ -f "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Load FZF modules
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set environment variables
export PATH=/Applications/CMake.app/Contents/bin:$PATH
export CC=clang
export CXX=clang++
export EDITOR=nvim
export EDITOR_OPTS="-p"
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND='ag -g ""'
export FZF_EDITOR_COMMAND='ag --follow -g ""'
export FZF_DEFAULT_OPTS="-m --reverse"

# Set window title
DISABLE_AUTO_TITLE="true"
echo -en "\033];Velocity\007"

# Set prompt
PROMPT='%n@%M %3d $ '

# Set ls colors
if [[ $BACKGROUND == "light" ]] ; then
    LS_COLORS=$LS_COLORS:'di=36:ln=35:ex=31'
else
    LS_COLORS=$LS_COLORS:'di=34:ln=33:ex=31'
fi
export LS_COLORS

# Functions
# Default to FZF for selecting file to edit if none given
function FZFEditor() {
    if [[ -z "$EDITOR" ]] ; then
        echo "no editor variable set"
        return
    fi
    if (( $# == 0 )) then
        setopt localoptions pipefail 2> /dev/null
        local files=()
        eval "${FZF_EDITOR_COMMAND:-$FZF_DEFAULT_COMMAND} | $(__fzfcmd) -m $FZF_EDITOR_OPTS" \
        | while read file; do
            files+=($file)
        done
        unset file
        $EDITOR $EDITOR_OPTS $files
    else
        $EDITOR $EDITOR_OPTS $@
    fi
}

# Indicator for normal/insert mode
function zle-line-init zle-keymap-select {
    RPROMPT=${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/}
    zle reset-prompt
}

# Exit detaches tmux
function exit() {
    if [[ -z "$TMUX" ]] ; then
        builtin exit
    else
        tmux detach
    fi
}

# Alias functions
alias extract='unarchive'
alias e='FZFEditor'

# General aliases
alias ls='ls -Fh --color=auto'
alias la='ls -A'
alias sl='ls'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias mkdir='mkdir -pv'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias ~='cd ~'
alias mux='tmuxinator'
alias todo='e ~/GDrive/TODO.txt'
alias t='todo'
alias c='clear'
alias s='cd ~;clear'

# Display a message if system hasn't been updated within a week
# To reset the counter, run
# touch ~/.lastupdate
if [[ $(expr $(date +%s) - $(date +%s -r ~/.lastupdate)) -gt 604800 ]] ; then
    echo -e "\033[31mWARNING: No updates within a week\033[0m"
fi

# Not connected through SSH
if [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]] && [[ -z "$SSH_CONNECTION" ]] ; then
    # Start a tmux session if not in one
    if [[ -z "$TMUX" ]] ; then
        tmux new-session -A -s 0
    else
        # display a fortune (max once per day, saved in ~/.lastfortune)
        if [[ $(expr $(date +%s) - $(date +%s -r ~/.lastfortune)) -gt 86400 ]] ; then
            fortune -a | tee ~/.lastfortune | cowsay
        fi
        # Load twitcher module
        export TWITCH_TOKEN=$(cat ~/GDrive/config/twitchtoken)
        [ -f "${TWITCHER_DIR:-$HOME}/.twitcher/twitcher.zsh" ] && source "${TWITCHER_DIR:-$HOME}/.twitcher/twitcher.zsh"
        # Load velocity module
        [ -f "${VELOCITY_DIR:-$HOME}/.velocity/velocity.zsh" ] && source "${VELOCITY_DIR:-$HOME}/.velocity/velocity.zsh"
    fi
fi
