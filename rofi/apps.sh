#!/usr/bin/env zsh

apps="${(@f)"$(<~/.config/rofi/apps.txt)"}"

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
    app_to_run="SHELL:ikhal"
    ;;
"minecraft")
    app_to_run="minecraft-launcher"
    ;;
"mutt")
    app_to_run="SHELL:neomutt"
    ;;
"python")
    app_to_run="SHELL:python"
    ;;
"ranger")
    app_to_run="SHELL:ranger"
    ;;
"sensors")
    app_to_run="SHELL:watch sensors"
    ;;
"spotify")
    app_to_run="spotify"
    [[ $HOST == "darkrai" ]] && app_to_run="spotify --force-device-scale-factor=2"
    ;;
"todo")
    eval kitty --directory ~/todo $EDITOR todo.org >/dev/null 2>&1 &
    exit 0
    ;;
"transmission")
    app_to_run="transmission-qt"
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
    eval kitty ${app_to_run#SHELL:} >/dev/null 2>&1 &
    exit 0
fi

if [[ -n "$app_to_run" ]]; then
    eval "$app_to_run >/dev/null 2>&1 &"
    exit 0
fi
