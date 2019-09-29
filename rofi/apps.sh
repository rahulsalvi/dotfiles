#!/usr/bin/env zsh

case "$@" in
    "dc")
        app_to_run="SHELL:dc"
    ;;
    "htop")
        app_to_run="SHELL:htop"
    ;;
    "khal")
        app_to_run="SHELL:khal"
    ;;
    "minecraft")
        app_to_run="minecraft-launcher"
    ;;
    "mutt")
        app_to_run="SHELL:mutt"
    ;;
    "python")
        app_to_run="SHELL:python"
    ;;
    "ranger")
        app_to_run="SHELL:ranger"
    ;;
    "sensors")
        app_to_run="SHELL:sensors"
    ;;
    "todo")
        app_to_run="SHELL:todo"
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
        echo "kitty"
        echo "khal"
        echo "kicad"
        echo "libreoffice"
        echo "minecraft"
        echo "mutt"
        echo "pavucontrol"
        echo "python"
        echo "radeon-profile"
        echo "ranger"
        echo "remmina"
        echo "seahorse"
        echo "sensors"
        echo "spotify"
        echo "steam"
        echo "todo"
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
    eval kitty --session ~/.kitty/'${app_to_run#SHELL:}'.kitty >/dev/null 2>&1 &
    exit 0
fi

if [[ -n "$app_to_run" ]]; then
    $app_to_run >/dev/null 2>&1 &
    exit 0
fi
