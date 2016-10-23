local M = {}

M.device = hs.audiodevice.defaultInputDevice()
M.micVolume = 0.0

M.muteSound   = hs.sound.getByName("Mute"):  volume(0.35)
M.unmuteSound = hs.sound.getByName("Unmute"):volume(0.35)

function M.toggle()
    inputVolume = M.device:inputVolume()
    if inputVolume > 0.0 then
        M.micVolume = inputVolume
        M.device:setInputVolume(0.0)
        M.muteSound:play()
    else
        M.device:setInputVolume(M.micVolume)
        M.unmuteSound:play()
    end
end

return M
