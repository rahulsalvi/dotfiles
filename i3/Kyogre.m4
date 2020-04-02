define(LOCKCMD, `xset s activate')dnl
define(DISCORD,`
# start discord
exec_always --no-startup-id discord')dnl
define(RADEON_PROFILE,`
# start radeon-profile
exec_always --no-startup-id radeon-profile')dnl
define(SCREENSAVER,`
# lock after 30 mins of inactivity
exec_always --no-startup-id xset s 1800 0
exec_always --no-startup-id xset dpms 2700 2700 2700
exec_always --no-startup-id xss-lock "/home/rahulsalvi/.i3/lock.sh"')dnl
