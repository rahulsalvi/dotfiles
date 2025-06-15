# see https://codeberg.org/dnkl/foot/wiki#shell-integration

autoload -U add-zsh-hook

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

function osc133a {
    print -Pn "\e]133;A\e\\"
}
add-zsh-hook -Uz precmd osc133a

function pipe-command-output-precmd {
    if ! builtin zle; then
        print -n "\e]133;D\e\\"
    fi
}
add-zsh-hook -Uz precmd pipe-command-output-precmd

function pipe-command-output-preexec {
    print -n "\e]133;C\e\\"
}
add-zsh-hook -Uz preexec pipe-command-output-preexec
