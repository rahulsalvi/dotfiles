#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

case $1 in
"show")
    ! vpnactive
    exit $?
    ;;
"text")
    echo ""
    ;;
"click")
    vpnon
    ;;
*)
    exit 0
    ;;
esac
