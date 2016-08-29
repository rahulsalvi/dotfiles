termname=$(osascript -e "tell first window of application \"Terminal\" to return name of current settings as string")
if [[ $termname == "Solarized Light" ]] ; then
    export BACKGROUND=light
else
    export BACKGROUND=dark
fi
unset termname

zstyle ':prezto:module:syntax-highlighting' color 'yes'
zstyle ':prezto:load' pmodule \
    'environment' \
    'utility' \
    'directory' \
    'history' \
    'completion' \
    'git' \
    'macports' \
    'archive' \
    'syntax-highlighting' \
    'history-substring-search'

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

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

CollapsePWD() {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

OpenInXcode() {
    touch "$@";
    open -a Xcode "$@"
}

ZipF () {
    zip -r "$1".zip "$1" ;
}

alias cpwd='CollapsePWD'
alias xcode='OpenInXcode'
alias zipf='ZipF'
alias extract='unarchive'

if [[ $BACKGROUND == "light" ]] ; then
    LS_COLORS=$LS_COLORS:'di=36:ln=35:ex=31'
else
    LS_COLORS=$LS_COLORS:'di=34:ln=33:ex=31'
fi

setopt PROMPT_SUBST
RPROMPT=''
precmd() {
    PROMPT=$(python3 ~/.velocity.py PROMPT)
}

TRAPWINCH() {
    PROMPT=$(python3 ~/.velocity.py PROMPT)
}

DISABLE_AUTO_TITLE="true"
echo -en "\033];Velocity\007"

export LS_COLORS
export CC=clang
export CXX=clang++
export EDITOR=vim
export LANG=en_US.UTF-8

alias ls='ls -Fh --color=auto'
alias la='ls -A'
alias sl='ls'
alias cp='cp -iv'
alias mv='mv -iv'
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
alias updatevim="vim -c ':PlugUpgrade | :PlugUpdate | :q! | :q!'"

if [[ -z "$TMUX" ]] && [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]] && [[ -z "$SSH_CONNECTION" ]] ; then
    tmux new-session -A -s 0
fi

function exit {
    if [[ -z "$TMUX" ]] ; then
        builtin exit
    else
        tmux detach
    fi
}

# Display a message if system hasn't been updated within a week
# To reset the counter, run
# touch ~/.lastupdate
if [[ $(expr $(date +%s) - $(date +%s -r ~/.lastupdate)) -gt 604800 ]] ; then
    echo -e "\033[31mWARNING: No updates within a week"
fi
