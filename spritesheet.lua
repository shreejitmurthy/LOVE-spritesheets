local Spritesheet = {}
Spritesheet.__index = Spritesheet

local Animation = {}
Animation.__index = Animation

function Animation.new(frames, delay)
    return setmetatable({
        frames = frames,
        delay = delay,
        currentTime = 0,
        currentIndex = 1
    }, Animation)
end

---@param spritesheet_path love.Image
---@param frameWidth integer
---@param frameHeight integer
function newSpritesheet(spritesheet_path, frameWidth, frameHeight)
    local self = setmetatable({}, Spritesheet)
    local path = spritesheet_path
    self.image = love.graphics.newImage(path)
    self.frameWidth = frameWidth
    self.frameHeight = frameHeight
    self.frames = {}
    self.delay = 0
    return self
end

function Spritesheet:getFrames(sx, sy, fx, fy)
    local frames = {}
    for y = sy, fy do
        for x = sx, fx do
            local quad = love.graphics.newQuad(
                (x - 1) * self.frameWidth,   -- x position in the spritesheet
                (y - 1) * self.frameHeight,  -- y position in the spritesheet
                self.frameWidth,             -- width of the frame
                self.frameHeight,            -- height of the frame
                self.image:getDimensions()   -- total dimensions of the spritesheet
            )
            frames[#frames+1] = quad
        end
    end

    return frames
end

function Spritesheet:newAnimation(s, f, delay)
    local sx, sy = unpack(s)
    local fx, fy = unpack(f)
    local frames = self:getFrames(sy, sx, fy + 1, fx)

    return Animation.new(frames, delay)
end

function Animation:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.delay then
        self.currentTime = self.currentTime - self.delay
        self.currentIndex = (self.currentIndex % #self.frames) + 1
        if self.currentIndex > #self.frames then
            self.currentIndex = 1
        end
    end
end
function Spritesheet:draw(animation, x, y)
    love.graphics.draw(self.image, animation.frames[animation.currentIndex], x, y)
end

return Spritesheet