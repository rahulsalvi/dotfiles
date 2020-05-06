define(HOSTNAME, `esyscmd(`printf $HOSTNAME')')dnl
[global]
    monitor = 0
    follow = keyboard
    ifelse(HOSTNAME,`kyogre',geometry = "300x5-15+40",
           HOSTNAME,`darkrai',geometry = "1000x5-15+40")
    indicate_hidden = yes
    shrink = no
    transparency = 15
    notification_height = 0
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    frame_width = 3
    frame_color = "#791E94"
    separator_color = frame
    sort = yes
    idle_threshold = 120
    font = Roboto 10
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    show_age_threshold = 60
    word_wrap = yes
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = false
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    max_icon_size = 32
    icon_path = /usr/share/icons/Papirus-Dark/32x32/status/:/usr/share/icons/Papirus-Dark/32x32/devices/:/usr/share/icons/Papirus-Dark/32x32/apps/
    sticky_history = yes
    history_length = 20
    dmenu = /usr/bin/dmenu -p dunst:
    browser = /usr/bin/firefox -new-tab
    always_run_script = true
    title = Dunst
    class = Dunst
    startup_notification = false
    force_xinerama = false
    corner_radius = 5

[experimental]
    per_monitor_dpi = false

[shortcuts]
    close = ctrl+space
    close_all = ctrl+shift+space
    history = ctrl+grave
    context = ctrl+shift+period

[urgency_low]
    background = "#2E2157"
    foreground = "#FFFFFF"
    frame_color = "#0D0221"
    timeout = 10
    #icon = /path/to/icon

[urgency_normal]
    background = "#2E2157"
    foreground = "#FFFFFF"
    frame_color = "#791E94"
    timeout = 10
    #icon = /path/to/icon

[urgency_critical]
    background = "#2E2157"
    foreground = "#FFFFFF"
    frame_color = "#FD1D53"
    timeout = 0
    #icon = /path/to/icon
