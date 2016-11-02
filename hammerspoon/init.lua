local mute        = require('Mute')
local terminal    = require('Terminal')

-- helper functions
function toggleMenuIcon()
    hs.menuIcon(not hs.menuIcon())
end

-- initial state
hs.menuIcon(false)

-- URL events
hs.urlevent.bind("ToggleMenuIcon", toggleMenuIcon)
hs.urlevent.bind("Reload",         hs.reload)

hs.urlevent.bind("ToggleMute",     mute.toggle)

hs.urlevent.bind("ExitTerminal",   terminal.exit)
hs.urlevent.bind("QuitTerminal",   terminal.quit)
