define(HOST, `esyscmd(`printf $HOSTNAME')')dnl
include(i3/HOST.m4)dnl
# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font Input 8

# use these keys for focus, movement, and resize directions when reaching for
# the arrows is not convenient
set $up k
set $down j
set $left h
set $right l

# use Mouse+Mod1 to drag floating windows to their wanted position
floating_modifier Mod1

# start a terminal
bindsym Mod1+Return exec kitty

# start firefox
bindsym Mod1+c exec firefox

# start discord
bindsym Mod1+m exec discord

# start neomutt
bindsym Mod1+z exec kitty --session ~/.kitty/mutt.kitty

# start khal
bindsym Mod1+x exec kitty --session ~/.kitty/khal.kitty

# start todo
bindsym Mod1+t exec kitty --session ~/.kitty/todo.kitty

# lock
bindsym Mod1+Control+Escape exec LOCKCMD

# media key bindings
bindsym XF86AudioPlay exec playerctl play-pause
bindsym XF86AudioStop exec playerctl stop
bindsym XF86AudioPrev exec playerctl previous
bindsym XF86AudioNext exec playerctl next
ifdef(`BACKLIGHT', BACKLIGHT, `dnl')

# kill focused window
bindsym Mod1+q kill

# start rofi
bindsym Mod1+d exec rofi -show

# change focus
bindsym Mod1+$left focus left
bindsym Mod1+$down focus down
bindsym Mod1+$up focus up
bindsym Mod1+$right focus right

# alternatively, you can use the cursor keys:
bindsym Mod1+Left focus left
bindsym Mod1+Down focus down
bindsym Mod1+Up focus up
bindsym Mod1+Right focus right

# move focused window
bindsym Mod1+Shift+$left move left
bindsym Mod1+Shift+$down move down
bindsym Mod1+Shift+$up move up
bindsym Mod1+Shift+$right move right

# alternatively, you can use the cursor keys:
bindsym Mod1+Shift+Left move left
bindsym Mod1+Shift+Down move down
bindsym Mod1+Shift+Up move up
bindsym Mod1+Shift+Right move right

# split in horizontal orientation
bindsym Mod1+b split h

# split in vertical orientation
bindsym Mod1+v split v

# enter fullscreen mode for the focused container
bindsym Mod1+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym Mod1+s layout stacking
bindsym Mod1+w layout tabbed
bindsym Mod1+e layout splith

# toggle tiling / floating
bindsym Mod1+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym Mod1+space focus mode_toggle

# switch to workspace
bindsym Mod1+1 workspace 1
bindsym Mod1+2 workspace 2
bindsym Mod1+3 workspace 3
bindsym Mod1+4 workspace 4
bindsym Mod1+5 workspace 5
bindsym Mod1+6 workspace 6
bindsym Mod1+7 workspace 7
bindsym Mod1+8 workspace 8
bindsym Mod1+9 workspace 9
bindsym Mod1+0 workspace 10

# move focused container to workspace
bindsym Mod1+Shift+1 move container to workspace 1
bindsym Mod1+Shift+2 move container to workspace 2
bindsym Mod1+Shift+3 move container to workspace 3
bindsym Mod1+Shift+4 move container to workspace 4
bindsym Mod1+Shift+5 move container to workspace 5
bindsym Mod1+Shift+6 move container to workspace 6
bindsym Mod1+Shift+7 move container to workspace 7
bindsym Mod1+Shift+8 move container to workspace 8
bindsym Mod1+Shift+9 move container to workspace 9
bindsym Mod1+Shift+0 move container to workspace 10

new_window pixel
new_float pixel

mode "move" {
    bindsym c exec "~/.i3/new_workspace"; mode "default"
    bindsym n exec "~/.i3/next_workspace"; mode "default"
    bindsym p exec "~/.i3/prev_workspace"; mode "default"
    bindsym Shift+c exec "~/.i3/move_to_new_workspace"; mode "default"
    bindsym Shift+n exec "~/.i3/move_to_next_workspace"; mode "default"
    bindsym Shift+p exec "~/.i3/move_to_prev_workspace"; mode "default"
    bindsym q mode "default"
    bindsym Escape mode "default"
}

bindsym Mod1+Tab mode "move"

# resize window (you can also use the mouse for that)
mode "resize" {
    # These bindings trigger as soon as you enter the resize mode

    # Pressing left will shrink the window’s width.
    # Pressing right will grow the window’s width.
    # Pressing up will shrink the window’s height.
    # Pressing down will grow the window’s height.
    bindsym $left       resize shrink width 10 px or 10 ppt
    bindsym $down       resize grow height 10 px or 10 ppt
    bindsym $up         resize shrink height 10 px or 10 ppt
    bindsym $right      resize grow width 10 px or 10 ppt

    # same bindings, but for the arrow keys
    bindsym Left        resize shrink width 10 px or 10 ppt
    bindsym Down        resize grow height 10 px or 10 ppt
    bindsym Up          resize shrink height 10 px or 10 ppt
    bindsym Right       resize grow width 10 px or 10 ppt

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym Mod1+r mode "resize"

mode "passthrough" {
    bindsym Mod1+Control+Shift+F10 mode "default"
}

bindsym Mod1+Control+Shift+F10 mode "passthrough"

gaps inner 5
gaps outer 0

# launch feh for wallpaper
exec_always --no-startup-id ~/.fehbg

# launch picom
exec_always --no-startup-id picom

# launch polybar
exec_always --no-startup-id ~/.config/polybar/launch.sh

# start KeePassXC
exec_always --no-startup-id ~/.i3/start_keepassxc.sh

# start insync
exec_always --no-startup-id insync start

### GENERATED FROM M4 ###
ifdef(`RADEON_PROFILE', RADEON_PROFILE, `dnl')
ifdef(`NUMLOCK', NUMLOCK, `dnl')
ifdef(`NM_APPLET', NM_APPLET, `dnl')
ifdef(`BLUEMAN_APPLET', BLUEMAN_APPLET, `dnl')
ifdef(`DISCORD', DISCORD, `dnl')
ifdef(`TOUCHSCREEN', TOUCHSCREEN, `dnl')
ifdef(`TOUCHPAD', TOUCHPAD, `dnl')
ifdef(`SCREENROTATOR', SCREENROTATOR, `dnl')
ifdef(`SCREENSAVER', SCREENSAVER, `dnl')
