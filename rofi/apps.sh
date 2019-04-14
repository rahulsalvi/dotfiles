#!/usr/bin/env zsh

case "$@" in
    "chrome")
        app_to_run="google-chrome-stable"
    ;;
    "dc")
        app_to_run="SHELL:dc"
    ;;
    "htop")
        app_to_run="SHELL:htop"
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
    "ranger")
        app_to_run="SHELL:ranger"
    ;;
    "topydo")
        app_to_run="SHELL:topydo columns"
    ;;
    "transmission")
        app_to_run="transmission-qt"
    ;;
    "")
        echo "arandr"
        echo "chrome"
        echo "dc"
        echo "discord"
        echo "htop"
        echo "keepassxc"
        echo "khal"
        echo "kicad"
        echo "libreoffice"
        echo "mutt"
        echo "ncmpcpp"
        echo "pavucontrol"
        echo "radeon-profile"
        echo "ranger"
        echo "remmina"
        echo "seahorse"
        echo "spotify"
        echo "steam"
        echo "termite"
        echo "topydo"
        echo "transmission"
        echo "vlc"
        echo "yed"
        echo "zathura"
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
