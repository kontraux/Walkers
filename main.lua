local walkers = require "walkers"

function love.load()
end

local walker = walkers:new()
walker:create_grid(70, 45)


function love.update(dt)
    fps = love.timer.getFPS()
    walker:update()
    walker.get_input()
end

local color = 1

local size = 16
local margin = 10
local text = "Press the spacebar to begin!"
local screenwidth, screenheight = love.graphics.getWidth(), love.graphics.getHeight()
local font = love.graphics.newFont(45); love.graphics.setFont(font)
local ox = font:getWidth(text) / 2
local oy = font:getHeight() / 2
function love.draw()
    color = color - 0.01
    for x = 1, #walker.grid do
        for y = 1, #walker.grid[x] do
            love.graphics.setColor(walker.color[x][y], walker.color[x][y], walker.color[x][y], walker.color[x][y])
            love.graphics.rectangle("fill", x * size + margin, y * size + margin, 15, 15)
            love.graphics.setColor(1,1,1,1)
        end
    end
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print(fps)
    love.graphics.setColor(1,1,1,1)
    if not walker.running then
        love.graphics.setColor(0,0,0,1)
        love.graphics.print(text, screenwidth / 2, screenheight / 2, 0, 1, 1, ox, oy)
        love.graphics.setColor(1,1,1,1)
    end
end
