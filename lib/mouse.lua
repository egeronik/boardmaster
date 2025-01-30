Mouse = { posX = 0, posY = 0, btn = 0 }

function Mouse:init()
    poke(0x5F2D, 1)
    -- circfill(10, 10, 10, 10)
    -- poke(0x5f2d, 0x1)
end

-- Needs to be ran at update loop
function Mouse:updatePos()
    self.posX = stat(32)
    self.posY = stat(33)
    -- 1-LMB
    -- 2-RMB
    -- 3-MMB
    self.btn = stat(34)
end

-- for _draw function
function Mouse:draw()
    spr(1, self.posX, self.posY)
end

function Mouse:isClicked()
    if self.btn == 1 then
        return true
    else
        return false
    end
end

Mouse:init()