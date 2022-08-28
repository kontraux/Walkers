local walker = {}

function walker:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = o

    walker.running = false
    function walker:create_grid(x, y)
    self.grid = {}
    self.color = {}
        for i = 1, x do
            self.grid[i] = {}
            self.color[i] = {}
            for j = 1, y do
                self.grid[i][j] = {}
                self.color[i][j] = 1
            end
        end
        return self
    end

    local timer = 0
    math.randomseed(os.clock())
    local co = coroutine.create (function(step)
        self.x = #walker.grid / 2;
        self.y = math.floor(#walker.grid[self.x] / 2);
        for x = 1, #walker.grid do
            for y = 1, #walker.grid[x] do
                ::retry::
                self.x = self.x + math.random(-step, step)
                self.y = self.y + math.random(-step, step)
                if self.x > 1 and self.x < #walker.grid and self.y > 1 and self.y < #walker.grid[x] then
                    walker.grid[self.x][self.y] = 1
                    walker.color[self.x][self.y] = walker.color[self.x][self.y] - 0.2
                else
                    goto retry
                end
                coroutine.yield()
            end
        end
        return walker.grid
    end)

    walker.running = false

    function walker:update()
        if walker.running == true then
            local dt = love.timer.getDelta()
            timer = timer + dt
            if timer > 0.02 then
                coroutine.resume(co, 1)
                timer = 0
            end
        end
    end

function walker.get_input()
    function love.keypressed(key)
        if key == 'space' then
            walker.running = true
        end
    end
end

    return self
end

return walker