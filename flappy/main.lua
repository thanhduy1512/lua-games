push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/TitleScreenState'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- local BACKGROUND_LOOPING_POINT = 1157 - VIRTUAL_WIDTH
local BACKGROUND_LOOPING_POINT = 578

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy')

    smallFont = love.graphics.newFont('font/font.ttf', 8)
    mediumFont = love.graphics.newFont('font/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('font/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('font/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function()
            return TitleScreenState()
        end,
        ['play'] = function()
            return PlayState()
        end,
        ['score'] = function()
            return ScoreState()
        end,
        ['countdown'] = function()
            return CountdownState()
        end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end
