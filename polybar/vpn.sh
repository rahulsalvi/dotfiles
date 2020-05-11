#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

case $1 in
"show")
    ! nmcli -f GENERAL.STATE con show id "US California" | grep activated >/dev/null 2>&1
    exit $?
    ;;
"text")
    echo ""
    ;;
"click")
    nmcli con up id "US California"
    ;;
*)
    exit 0
    ;;
esac
