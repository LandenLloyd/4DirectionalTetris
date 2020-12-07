TetriminoManager = Class{}

function TetriminoManager:init(util, centerBlockTable, tetriminoTable)
    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will varself.y on startup everself.y time
    math.randomseed(os.time())

    self.x = 0
    self.y = VIRTUAL_HEIGHT / 2
    -- these variables are for keeping track of our velocitself.y on both the 
    -- self.x and self.y axis, since the tetrominoes can move in two dimensions
    self.dx = 4
    self.dy = math.random(2) == 1 and -4 or 4

    -- four sides of screen 
    -- 1 is up
    -- 2 is right
    -- 3 is bottom
    -- 4 is left
    self.side = 4

    -- self.shape = numbers
    -- 'S' is 1
    -- 'Z' is 2
    -- 'J' is 3
    -- 'L' is 4
    -- 'I' is 5
    -- 'O' is 6
    -- 'T' is 7
    self.shape = 1

    -- We initialize the table from the start 

    -- this is for resetting self.shape angle
    self.resetShapeAngle = false

    -- self.block is 4x4
    self.block = 4

    -- distance between self.blocks
    self.blockDst = 0
end

function TetriminoManager:update(dt)
    if self.side == 1 then -- 1 is up
        -- if we reach the edge of the screen
        -- go back to start
        if self.y > VIRTUAL_HEIGHT - self.block then
            tetriminoManager:reset()
        else
            self.x = self.x + self.dx * dt
            self.y = self.y + self.dy * dt
        end

    elseif self.side == 2 then -- 2 is right
        -- if we reach the edge of the screen
        -- go back to start
        if self.x < 0 then
            tetriminoManager:reset()
        else
            self.x = self.x + self.dx * dt
            self.y = self.y + self.dy * dt
        end
    
    elseif self.side == 3 then -- 3 is bottom
        -- if we reach the edge of the screen
        -- go back to start
        if self.y < 0 then
            tetriminoManager:reset()
        else
            self.x = self.x + self.dx * dt
            self.y = self.y + self.dy * dt
        end
    
    elseif self.side == 4 then -- 4 is left
        -- if we reach the edge of the screen
        -- go back to start
        if self.x > VIRTUAL_WIDTH - self.block then
            tetriminoManager:reset()
        else
            self.x = self.x + self.dx * dt
            self.y = self.y + self.dy * dt
        end
    end
end

function TetriminoManager:render()
    tetriminoManager:shapes()
end

-- resets tetromino
function TetriminoManager:reset()
    self.resetShapeAngle = true
    self.side = math.random(1, 4) 
    self.shape = math.random(1, 7) 

    if self.side == 1 then -- 1 is up
        self.x = math.random(0, (VIRTUAL_WIDTH - 12) / self.block) * self.block
        self.y = 0
    
        if self.x >=0 and self.x <= 64 then
            self.dx = self.block
            self.dy = self.block
        elseif self.x >=65 and self.x <= 128 then
            self.dx = self.block
            self.dy = self.block
        elseif self.x >= 129 and self.x <= 192 then
            self.dx = math.random(2) == 1 and -self.block or self.block
            self.dy = self.block
        elseif self.x >= 193 and self.x <= 257 then
            self.dx = -self.block
            self.dy = self.block
        elseif self.x >= 258 and self.x <= VIRTUAL_WIDTH then
            self.dx = -self.block
            self.dy = self.block
        end

    elseif self.side == 2 then -- 2 is right
        self.x = VIRTUAL_WIDTH 
        self.y = math.random(0, (VIRTUAL_HEIGHT - 12) / self.block) * self.block
    
        if self.y >=0 and self.y <= 60 then
            self.dx = -self.block
            self.dy = self.block
        elseif self.y >=61 and self.y <= 120 then
            self.dx = -self.block
            self.dy = math.random(2) == 1 and -self.block or self.block
        elseif self.y >= 121 and self.y <= VIRTUAL_HEIGHT then
            self.dx = -self.block
            self.dy = -self.block
        end
    
    elseif self.side == 3 then -- 3 is bottom
        self.x = math.random(0, (VIRTUAL_WIDTH - 12) / self.block) * self.block
        self.y = VIRTUAL_HEIGHT
    
        if self.x >=0 and self.x <= 64 then
            self.dx = self.block
            self.dy = self.block
        elseif self.x >=65 and self.x <= 128 then
            self.dx = self.block
            self.dy = self.block
        elseif self.x >= 129 and self.x <= 192 then
            self.dx = math.random(2) and -self.block or self.block
            self.dy = -self.block
        elseif self.x >= 193 and self.x <= 257 then
            self.dx = -self.block
            self.dy = -self.block
        elseif self.x >= 258 and self.x <= VIRTUAL_WIDTH then
            self.dx = -self.block
            self.dy = -self.block
        end
    
    elseif self.side == 4 then -- 4 is left
        self.x = 0
        self.y = math.random(0, (VIRTUAL_HEIGHT - 12) / self.block) * self.block
    
        if self.y >=0 and self.y <= 60 then
            self.dx = self.block
            self.dy = self.block
        elseif self.y >=61 and self.y <= 120 then
            self.dx = self.block
            self.dy = math.random(2) == 1 and -self.block or self.block
        elseif self.y >= 121 and self.y <= VIRTUAL_HEIGHT then
            self.dx = self.block
            self.dy = self.block
        end
    end
end

-- defining shapes
function TetriminoManager:shapes()
    if self.shape == 1 then -- 'S' is 1
        -- setting reg color
        love.graphics.setColor(246/255, 0, 0, 1)
        tetriminoColor = {246/255, 0, 0, 1}
        if self.resetShapeAngle == true then
            s = math.random(1, 2) 
            self.resetShapeAngle = false
        end

        if s == 1 then
            ---**--
            --**---
            love.graphics.rectangle('fill', self.x  + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x  + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor}
        else 
            --*---
            --**--
            ---*--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        end

    elseif self.shape == 2 then -- 'Z' is 2
        -- setting dark-orange color
        love.graphics.setColor(255/255, 140/255, 0, 1)
        tetriminoColor = {255/255, 140/255, 0, 1}
        if self.resetShapeAngle == true then
            z = math.random(1, 2) 
            self.resetShapeAngle = false
        end

        if z == 1 then
            --**---
            ---**--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        else 
            ---*--
            --**--
            --*---
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        end

    elseif self.shape == 3 then -- 'J' is 3
        -- setting canary-yellow color
        love.graphics.setColor(255/255, 238/255, 0, 1)
        tetriminoColor = {255/255, 238/255, 0, 1}
        if self.resetShapeAngle == true then
            j = math.random(1, 4) 
            self.resetShapeAngle = false
        end

        if j == 1 then
            ---*--
            ---*--
            --**--
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        elseif j == 2 then
            --**--
            --*---
            --*---
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        elseif j == 3 then
            --***--
            ----*--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        else
            --*----
            --***--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        end
 
    elseif self.shape == 4 then -- 'L' is 4
        -- setting screamin-green color
        love.graphics.setColor(77/255, 233/255, 76/255, 1)
        tetriminoColor = {77/255, 233/255, 76/255, 1}
        if self.resetShapeAngle == true then
            l = math.random(1, 4) 
            self.resetShapeAngle = false
        end

        if l == 1 then
            --*---
            --*---
            --**--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        elseif l == 2 then
            --**---
            ---*---
            ---*---
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        elseif l == 3 then
            --***--
            --*----
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor}
        else
            ----*--
            --***--
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        end

    elseif self.shape == 5 then -- 'I' is 5
        -- setting brilliant-azure color
        love.graphics.setColor(55/255, 131/255, 255/255, 1)
        tetriminoColor = {55/255, 131/255, 255/255, 1}
        if self.resetShapeAngle == true then
            i = math.random(1, 2) 
            self.resetShapeAngle = false
        end
        
        if i == 1 then
            --*--
            --*--
            --*--
            --*--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 3) + (3 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 3) + (3 * self.blockDst)})] = tetriminoColor}
        else 
            --****--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 3) + (3 * self.blockDst), self.y, self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 3) + (3 * self.blockDst), self.y})] = tetriminoColor}
        end

    elseif self.shape == 6 then -- 'O' is 6
            -- setting american-violet color
            love.graphics.setColor(72/255, 21/255, 170/255, 1)
            tetriminoColor = {72/255, 21/255, 170/255, 1}
            --**--
            --**--
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x +(self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            postionsTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                             [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                             [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                             [util:toCoords({self.x +(self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}

    elseif self.shape == 7 then -- 'T' is 7
        -- setting cyan color
        love.graphics.setColor(0, 255/255, 255/255, 1)
        tetriminoColor = {0, 255/255, 255/255, 1}
        if self.resetShapeAngle == true then
            t = math.random(1, 4) 
            self.resetShapeAngle = false
        end

        if t == 1 then
            --***--
            ---*---
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        elseif t == 2 then
            ---*---
            ---**--
            ---*---
            love.graphics.rectangle('fill', self.x, self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x, self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        elseif t == 3 then
            ---*--
            --**--
            ---*--
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block * 2) + (2 * self.blockDst)})] = tetriminoColor}
        else
            ---*---
            --***--
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y, self.block, self.block)
            love.graphics.rectangle('fill', self.x, self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)
            love.graphics.rectangle('fill', self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst), self.block, self.block)

            tetriminoTable = {[util:toCoords({self.x + (self.block + self.blockDst), self.y})] = tetriminoColor,
                              [util:toCoords({self.x, self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block + self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor,
                              [util:toCoords({self.x + (self.block * 2) + (2 * self.blockDst), self.y + (self.block + self.blockDst)})] = tetriminoColor}
        end
    end
end
