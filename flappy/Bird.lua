Bird = Class {}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth() * 0.8
    self.height = self.image:getHeight() * 0.8

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:collides(pipe)
    local offsetA = 4
    local offsetB = 8
    -- it should be +2 and then -4 because it will smaller from the start of the box and the end of the box
    if (self.x + offsetA) + (self.width - offsetB) >= pipe.x and self.x + offsetA <= pipe.x + PIPE_WIDTH then
        if (self.y + offsetA) + (self.height - offsetB) >= pipe.y and self.y + offsetA <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -5
        sounds['jump']:play()
    end

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.8, 0.8)
end
