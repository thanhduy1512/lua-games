Ball = Class {}

function Ball:init(skin)
    self.dx = 0
    self.dy = 0

    self.width = 8
    self.height = 8

    self.skin = skin
end

function Ball:collides(target)
    -- check left edge
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- check top edge
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- if above arent true then its collides
    return true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.x >= VIRTUAL_WIDTH - 8 then
        self.x = VIRTUAL_WIDTH - 8
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall-hit']:play()
    end
end

function Ball:render()
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin], self.x, self.y)
end
