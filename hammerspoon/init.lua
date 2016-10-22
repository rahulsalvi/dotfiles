local Terminal = require('Terminal')

hs.urlevent.bind("ExitTerminal", Terminal.exitTerminal)
hs.urlevent.bind("QuitTerminal", Terminal.quitTerminal)
