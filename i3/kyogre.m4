define(LOCKCMD, `xset s activate')dnl
define(SPOTIFY, `spotify')dnl
define(NUMLOCK,`
# turn on numlock
exec_always --no-startup-id numlockx on')dnl
define(SCREENSAVER,`
# lock after 30 mins of inactivity
exec_always --no-startup-id xset s 1800 0
exec_always --no-startup-id xset dpms 2700 2700 2700
exec_always --no-startup-id xss-lock "/home/rahulsalvi/.config/lock/lock.sh"')dnl
