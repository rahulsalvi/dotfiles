local terminal = require('Terminal')
local mute     = require('Mute')

hs.urlevent.bind("ExitTerminal", terminal.exit)
hs.urlevent.bind("QuitTerminal", terminal.quit)

hs.urlevent.bind("ToggleMute",   mute.toggle)
