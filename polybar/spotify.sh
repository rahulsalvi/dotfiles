#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

case $1 in
"show")
    playerctl -p spotify status
    exit $?
    ;;
"text")
    text=$(playerctl -p spotify -f "{{title}} - {{artist}}" metadata)
    if playerctl -p spotify status | grep Playing >/dev/null 2>&1; then
        echo "$text - ⏸"
    else
        echo "$text - ▶"
    fi
    ;;
"click-left")
    playerctl -p spotify play-pause
    ;;
"click-right")
    i3-msg '[class="Spotify"] focus'
    ;;
*)
    exit 0
    ;;
esac
