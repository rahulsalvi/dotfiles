#!/usr/bin/env zsh

if [ "$#" -ne 1 ]; then
    exit 0
fi

case $1 in
"text")
    if speakersactive; then
        echo " "
    else
        echo ""
    fi
    ;;
"click")
    if headphonesactive; then
        speakers
    else
        headphones
    fi
    ;;
*)
    exit 0
    ;;
esac
