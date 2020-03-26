define(HOSTNAME, `esyscmd(`printf $HOSTNAME')')dnl
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
ifelse(HOSTNAME,`darkrai',
`    "spotify")
        app_to_run="spotify --force-device-scale-factor=2"
    ;;
')dnl
    "todo")
        app_to_run="SHELL:todo"
    ;;
    "transmission")
        app_to_run="transmission-qt"
    ;;
ifelse(HOSTNAME,`Kyogre',
`    "vpnoff")
        app_to_run="sudo systemctl stop openvpn-client@US-California.service"
    ;;
    "vpnon")
        app_to_run="sudo systemctl start openvpn-client@US-California.service"
    ;;
')dnl
ifelse(HOSTNAME,`darkrai',
`    "write")
        app_to_run="write_stylus"
    ;;
')dnl
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
ifelse(HOSTNAME, `Kyogre',
`        echo "radeon-profile"
')dnl
        echo "ranger"
        echo "remmina"
        echo "seahorse"
        echo "sensors"
        echo "spotify"
        echo "steam"
        echo "stm32cubemx"
        echo "todo"
        echo "transmission"
        echo "vlc"
ifelse(HOSTNAME, `Kyogre',
`        echo "vpnoff"
        echo "vpnon"
')dnl
ifelse(HOSTNAME, `darkrai',
`        echo "write"
')dnl
        echo "yed"
        echo "zathura"
        echo "zoom"
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
    eval "$app_to_run >/dev/null 2>&1 &"
    exit 0
fi
