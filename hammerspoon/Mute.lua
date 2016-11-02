local M = {}

-- select mic and set volume
M.device = hs.audiodevice.defaultInputDevice()
M.micVolume = 75

-- load mute and unmute sounds
M.muteSound   = hs.sound.getByName("Mute"):  volume(0.35)
M.unmuteSound = hs.sound.getByName("Unmute"):volume(0.35)

-- load mute and unmute icons
M.muteIcon = hs.image.imageFromPath(
    "~/Dropbox/config/OSX/Hammerspoon/Images/muted.png"
    ):setSize({h=18, w=18}, false)
M.unmuteIcon = hs.image.imageFromPath(
    "~/Dropbox/config/OSX/Hammerspoon/Images/unmuted.png"
    ):setSize({h=18, w=18}, false)

-- toggle mic muted
function M.toggle()
    inputVolume = M.device:inputVolume()
    if inputVolume > 0.0 then
        M.micVolume = inputVolume
        M.device:setInputVolume(0.0)
        M.muteSound:play()
        M.menubar:setIcon(M.muteIcon)
    else
        M.device:setInputVolume(M.micVolume)
        M.unmuteSound:play()
        M.menubar:setIcon(M.unmuteIcon)
    end
end

-- create menubar icon that toggles mute
M.menubar = hs.menubar.new():setIcon(M.unmuteIcon):setClickCallback(M.toggle)

return M
