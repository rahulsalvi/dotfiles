#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

maildirs=$(find ${HOME}/Mail -regex ".*/INBOX" | tr '\n' ' ')

case $1 in
"show")
    python ~/.config/waybar/count_unread_mail.py $maildirs >/dev/null 2>&1
    return $?
    ;;
"text")
    text=$(python ~/.config/waybar/count_unread_mail.py $maildirs)
    echo " $text"
    ;;
"click")
    kitty neomutt >/dev/null 2>&1 &
    ;;
*)
    exit 0
    ;;
esac
