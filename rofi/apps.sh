#!/usr/bin/env zsh

case "$@" in
    "chrome")
        app_to_run="google-chrome-stable"
    ;;
    "")
        echo "chrome"
        echo "discord"
        echo "keepassxc"
        echo "pavucontrol"
        echo "steam"
        echo "termite"
        echo "vlc"
    ;;
    *)
        app_to_run=$@
    ;;
esac

if [[ -n "$app_to_run" ]]; then
    $app_to_run >/dev/null 2>&1 &
fi
