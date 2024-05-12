local assetDirectory = ""

local Spritesheet = {}
Spritesheet.__index = Spritesheet

function Spritesheet.SetAssetDirectory(dirName)
    if not love.filesystem.read(dirName) then
        error("Spritesheet not found at: " .. dirName)
    else
        assetDirectory = dirName
    end
end

return Spritesheet