local M = {}

-- close tmux and terminal window
function M.exit()
    hs.eventtap.keyStroke({"ctrl"}, "Space")
    hs.eventtap.keyStrokes("d")
    hs.timer.doAfter(0.15, function()
        hs.eventtap.keyStroke({"cmd"}, "w")
    end)
end

-- close tmux and quit terminal
function M.quit()
    hs.eventtap.keyStroke({"ctrl"}, "Space")
    hs.eventtap.keyStrokes("d")
    hs.timer.doAfter(0.15, function()
        hs.eventtap.keyStroke({"cmd"}, "q")
    end)
end

return M
