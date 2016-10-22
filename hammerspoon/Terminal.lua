local M = {}

function M.exitTerminal()
    hs.eventtap.keyStroke({"ctrl"}, "Space")
    hs.eventtap.keyStrokes("d")
    hs.timer.doAfter(0.15, function()
        hs.eventtap.keyStroke({"cmd"}, "w")
    end)
end

function M.quitTerminal()
    hs.eventtap.keyStroke({"ctrl"}, "Space")
    hs.eventtap.keyStrokes("d")
    hs.timer.doAfter(0.15, function()
        hs.eventtap.keyStroke({"cmd"}, "q")
    end)
end

return M
