OpenInXcode() {
    touch "$@";
    open -a Xcode "$@"
}

ParseGitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

alias ls='ls -F'
alias xcode='OpenInXcode'
export CC=clang
export CXX=clang++
export PS1="\u@\h \W\[\033[32m\]\$(ParseGitBranch)\[\033[00m\] $ "
