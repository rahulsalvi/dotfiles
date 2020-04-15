define(LOCKCMD, `systemctl suspend-then-hibernate')dnl
define(BACKLIGHT,`
# brightness key bindings
bindsym XF86MonBrightnessUp exec xbacklight -inc 10
bindsym XF86MonBrightnessDown exec xbacklight -dec 10
bindsym Shift+XF86MonBrightnessUp exec xbacklight -ctrl tpacpi::kbd_backlight -inc 50
bindsym Shift+XF86MonBrightnessDown exec xbacklight -ctrl tpacpi::kbd_backlight -dec 50')dnl
define(NM_APPLET,`
# start nm-applet
exec_always --no-startup-id nm-applet')dnl
define(TOUCHSCREEN,`
# turn on touchscreen gestures
exec_always --no-startup-id xsetwacom set "Wacom Pen and multitouch sensor Finger touch" Gesture on')dnl
define(TOUCHPAD,`
# enable natural scrolling on trackpad
exec_always --no-startup-id xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" "libinput Natural Scrolling Enabled" 1')dnl
define(SCREENROTATOR,`
# turn on screenrotator
exec_always --no-startup-id screenrotator')dnl
define(SCREENSAVER,`
# set up screensaver
exec_always --no-startup-id xset s 600 0
exec_always --no-startup-id xset dpms 1200 1200 1200
exec_always --no-startup-id xss-lock systemctl suspend-then-hibernate')dnl
