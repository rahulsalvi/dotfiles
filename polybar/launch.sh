#!/usr/bin/env zsh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ "$HOST" == "Kyogre" ]]; then
    MONITOR=HDMI-A-0 polybar bar0 >/dev/null 2>&1 &
    sleep 2
    MONITOR=DisplayPort-0 polybar bar0 >/dev/null 2>&1 &
    # MONITOR=HDMI-A-1 polybar bar0 >/dev/null 2>&1 &
fi

echo "Polybar started"
