#!/usr/bin/env zsh

case "$@" in
    "chrome")
        app_to_run="google-chrome-stable"
    ;;
    "khal")
        app_to_run="SHELL:khal"
    ;;
    "mutt")
        app_to_run="SHELL:neomutt"
    ;;
    "ncmpcpp")
        app_to_run="SHELL:ncmpcpp"
    ;;
    "topydo")
        app_to_run="SHELL:topydo columns"
    ;;
    "")
        echo "chrome"
        echo "discord"
        echo "keepassxc"
        echo "khal"
        echo "mutt"
        echo "ncmpcpp"
        echo "pavucontrol"
        echo "steam"
        echo "termite"
        echo "topydo"
        echo "vlc"
    ;;
    *)
        app_to_run=$@
    ;;
esac

if [[ "$app_to_run" == SHELL:* ]]; then
    termite -e ${app_to_run#SHELL:} >/dev/null 2>&1 &
    exit
fi

if [[ -n "$app_to_run" ]]; then
    $app_to_run >/dev/null 2>&1 &
    exit
fi
