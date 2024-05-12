# LOVE-spritesheets
Similar to my other love2d animation library but basically better in every way. I still use that other script a bunch though, it's best for quick prototyping, this is similar to anim8 but current missing a few features (left, top, border).

The script uses an almost coordinate based system, where you input the coordinates you want it to go through and it just does it.
## Usage
```lua
require "spritesheet"

function love.load()
    mySpritesheet = newSpritesheet("resources/player.png", 64, 64)
    -- args: start frame, end frame, delay
    local up = mySpritesheet:newAnimation({1, 2}, {2, 8}, 0.5) 
    current_animation = up
end

function love.update(dt)
    current_animation:update(dt)
end

function love.draw()
    mySpritesheet:draw(current_animation, 10, 10)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
```
