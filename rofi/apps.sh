#!/usr/bin/env zsh

apps=("arandr" "dc" "discord" "firefox" "glances" "htop" "keepassxc" "kitty"
    "khal" "kicad" "libreoffice" "minecraft" "mutt" "pavucontrol" "python"
    "ranger" "remmina" "seahorse" "sensors" "spotify" "steam" "stm32cubemx"
    "todo" "transmission" "vlc" "zathura" "zoom")
darkrai_apps=("write")
Kyogre_apps=("radeon-profile" "vpnoff" "vpnon")

[[ $HOST == "darkrai" ]] && apps=($apps $darkrai_apps)
[[ $HOST == "Kyogre" ]] && apps=($apps $Kyogre_apps)

case "$@" in
"dc")
    app_to_run="SHELL:dc"
    ;;
"glances")
    app_to_run="SHELL:glances"
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
"spotify")
    app_to_run="spotify"
    [[ $HOST == "darkrai" ]] && app_to_run="spotify --force-device-scale-factor=2"
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
"write")
    app_to_run="write_stylus"
    ;;
"")
    IFS=$'\n' sorted=($(sort <<<"${apps[*]}"))
    unset IFS
    for app in "${sorted[@]}"; do
        echo "$app"
    done
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
