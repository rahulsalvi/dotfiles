#!/usr/bin/env zsh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ "$HOST" == "kyogre" ]]; then
    POLYBAR_MONITOR="DisplayPort-1" \
    polybar bar0 >/dev/null 2>&1 &
    POLYBAR_MONITOR="DisplayPort-0" \
    POLYBAR_TRAY_POS="none" \
    polybar bar0 >/dev/null 2>&1 &
    # POLYBAR_MONITOR=HDMI-A-1 polybar bar0 >/dev/null 2>&1 &
elif [[ "$HOST" == "darkrai" ]]; then
    POLYBAR_MONITOR="eDP-1" \
    POLYBAR_HEIGHT="60" \
    POLYBAR_MODULES_RIGHT="mail_sync calendar_sync vpn unread_mail battery date powermenu" \
    POLYBAR_TRAY_MAXSIZE="38" \
    POLYBAR_DPI="231" \
    polybar bar0 >/dev/null 2>&1 &
fi

echo "Polybar started"
