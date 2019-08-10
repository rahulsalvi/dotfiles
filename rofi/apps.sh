#!/usr/bin/env zsh

case "$@" in
    "dc")
        app_to_run="SHELL:dc"
    ;;
    "htop")
        app_to_run="SHELL:htop"
    ;;
    "khal")
        app_to_run="SHELL:ikhal"
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
    "todo")
        app_to_run="SHELL:nvim /home/rahulsalvi/todo/todo.org"
    ;;
    "topydo")
        app_to_run="SHELL:topydo columns"
    ;;
    "transmission")
        app_to_run="transmission-qt"
    ;;
    "vpnoff")
        app_to_run="sudo systemctl stop openvpn-client@US-California.service"
    ;;
    "vpnon")
        app_to_run="sudo systemctl start openvpn-client@US-California.service"
    ;;
    "")
        echo "arandr"
        echo "dc"
        echo "discord"
        echo "firefox"
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
        echo "todo"
        echo "topydo"
        echo "transmission"
        echo "vlc"
        echo "vpnoff"
        echo "vpnon"
        echo "yed"
        echo "zathura"
    ;;
    *)
        app_to_run=$@
    ;;
esac

if [[ "$app_to_run" == SHELL:* ]]; then
    eval termite -e '${app_to_run#SHELL:}' >/dev/null 2>&1 &
    exit
fi

if [[ -n "$app_to_run" ]]; then
    eval $app_to_run >/dev/null 2>&1 &
    exit
fi
