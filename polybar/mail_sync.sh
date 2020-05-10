#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

case $1 in
"show")
    ! systemctl --user is-active --quiet offlineimap-oneshot.timer
    exit $?
    ;;
"text")
    echo "MAIL/CALENDAR SYNC OFF"
    ;;
"click")
    systemctl --user start offlineimap-oneshot.timer
    systemctl --user start vdirsyncer.timer
    ;;
*)
    exit 0
    ;;
esac
