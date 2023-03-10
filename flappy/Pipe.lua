Pipe = Class {}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_SPEED = 60

PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation
end

function Pipe:update(dt)

end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, -- image
    self.x, -- x start
    (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), -- y start
    0, -- rotation
    0.8, -- X scale
    self.orientation == 'top' and -1 or 1) -- Y scale if -1 it will mirror flip
end
