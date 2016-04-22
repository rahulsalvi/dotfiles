# Path to your oh-my-zsh installation.
export ZSH=/Users/rahulsalvi/.oh-my-zsh

#ZSH_THEME="agnoster"

plugins=(git macports osx python)

# User configuration
source $ZSH/oh-my-zsh.sh

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

Extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

alias cpwd='CollapsePWD'
alias xcode='OpenInXcode'
alias zipf='ZipF'
alias extract='Extract'

if [[ $BACKGROUND == "light" ]] ; then
    LS_COLORS=$LS_COLORS:'di=34:ln=35:ex=31'
    DIRCOLOR=blue
    GITCOLOR=cyan
    GITCHANGECOLOR=red
else
    export BACKGROUND=dark
    LS_COLORS=$LS_COLORS:'di=34:ln=33:ex=31'
    DIRCOLOR=green
    GITCOLOR=cyan
    GITCHANGECOLOR=red
fi

PROMPT='%n@%M %{$fg[$DIRCOLOR]%}%1~%{$reset_color%} $(git_prompt_info)$ '
#RPROMPT='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$GITCOLOR]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[$GITCOLOR]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[$GITCHANGECOLOR]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

DISABLE_AUTO_TITLE="true"
echo -en "\033];Velocity\007"

export LS_COLORS
export CC=clang
export CXX=clang++
export EDITOR=/opt/local/bin/vim

alias ls='ls -Fh --color=auto'
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
alias updatevim="vim -c ':PlugUpgrade | :PlugUpdate | :q! | :q!'"
