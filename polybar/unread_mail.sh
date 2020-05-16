#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

maildir="$HOME/Mail/icloud/INBOX"

case $1 in
"show")
    python ~/.config/polybar/count_unread_mail.py $maildir
    return $?
    ;;
"text")
    text=$(python ~/.config/polybar/count_unread_mail.py $maildir)
    echo " $text"
    ;;
"click")
    kitty neomutt >/dev/null 2>&1 &
    ;;
*)
    exit 0
    ;;
esac
