BasePiece = { spriteX = 0, spriteY = 0, posX = 0, posY = 0, state = "shown", health = 1 }

function BasePiece:new(posX, posY)
    local obj = { posX = posX, posY = posY }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function BasePiece:drawHealth()
    print(self.health, self.posX * 16 + 2, self.posY * 16 + 2, 8)
end

function BasePiece:draw()
    if self.state != "hidden" then
        sspr(self.spriteX, self.spriteY, 16, 16, self.posX * 16, self.posY * 16)
        print(self.health, self.posX * 16 + 2, self.posY * 16 + 2, 8)
    end
end

function BasePiece:drawXY(posX, posY)
    sspr(self.spriteX, self.spriteY, 16, 16, posX, posY)
    print(self.health, posX + 2, posY + 2, 8)
end

-- Never call from base
function BasePiece:getMoves(freeSpots)
    moves = {}
    for spot in all(freeSpots) do
        if self:checkMove(spot.posX, spot.posY) then
            add(moves, { posX = spot.posX, posY = spot.posY })
        end
    end
    return moves
end

function BasePiece:move(posX, posY)
    -- Animator:Add(self, "kek")
    Animator:move(self, posX, posY)
    self.posX = posX
    self.posY = posY
end

function BasePiece:damage(posX, posY)
    Animator:damage(self, posX, posY)
end

-- GOP ---------------------------------------
Gop = { spriteX = 0, spriteY = 32, name = "gop", points = 10 }
-- Check if piece allowed to move in that direction
function Gop:checkMove(posX, posY)
    if posX == self.posX and (posY == self.posY + 1 or posY == self.posY - 1) then
        return true
    elseif posY == self.posY and (posX == self.posX + 1 or posX == self.posX - 1) then
        return true
    end
    return false
end
setmetatable(Gop, { __index = BasePiece })

-- Checker ----------------------------------
Checker = { spriteX = 80, spriteY = 32, name = "Checker", points = 20 }
function Checker:checkMove(posX, posY)
    if posX == self.posX + 1 and posY == self.posY + 1 then
        return true
    elseif posX == self.posX - 1 and posY == self.posY - 1 then
        return true
    elseif posX == self.posX + 1 and posY == self.posY - 1 then
        return true
    elseif posX == self.posX - 1 and posY == self.posY + 1 then
        return true
    end
    return false
end
setmetatable(Checker, { __index = BasePiece })

-- function findSpot(posX, posY, freeSpots)
--     for spot in all(freeSpots) do
--         if spot.posX == posX and spot.posY == posY then
--             return false
--         end
--     end
--     return true
-- end

-- function Checker:checkJump(posX, posY, freeSpots)
--     if posX == self.posX + 2 and posY == self.posY + 2 and findSpot(self.posX + 1, self.posY + 1, freeSpots) then
--         return true
--     elseif posX == self.posX - 2 and posY == self.posY - 2 and findSpot(self.posX - 1, self.posY - 1, freeSpots) then
--         return true
--     elseif posX == self.posX + 2 and posY == self.posY - 2 and findSpot(self.posX + 1, self.posY - 1, freeSpots) then
--         return true
--     elseif posX == self.posX - 2 and posY == self.posY + 2 and findSpot(self.posX - 1, self.posY + 1, freeSpots) then
--         return true
--     end
--     return false
-- end

function Checker:getMoves(freeSpots)
    moves = {}
    for spot in all(freeSpots) do
        if self:checkMove(spot.posX, spot.posY) then
            add(moves, { posX = spot.posX, posY = spot.posY })
            -- elseif self:checkJump(spot.posX, spot.posY, freeSpots) then
            --     add(moves, { posX = spot.posX, posY = spot.posY, jump = true })
        end
    end

    return moves
end

-- Pawn Not Used ---------------
Pawn = { spriteX = 16, spriteY = 32, name = "Pawn" }
setmetatable(Pawn, { __index = BasePiece })

-- Rook ----------------------------------------
Rook = { spriteX = 32, spriteY = 32, name = "Rook", health = 2, points = 150 }

function Rook:checkMove(posX, posY)
    if posX == self.posX and posY != self.posY then
        return true
    elseif posY == self.posY and posX != self.posX then
        return true
    end
    return false
end

setmetatable(Rook, { __index = BasePiece })

-- Knight -----------------------------------
Knight = { spriteX = 48, spriteY = 32, name = "Knight", health = 2, points = 80 }
function Knight:checkMove(posX, posY)
    if posX == self.posX + 2 and (posY == self.posY + 1 or posY == self.posY - 1) then
        return true
    elseif posX == self.posX - 2 and (posY == self.posY + 1 or posY == self.posY - 1) then
        return true
    elseif posY == self.posY + 2 and (posX == self.posX + 1 or posX == self.posX - 1) then
        return true
    elseif posY == self.posY - 2 and (posX == self.posX + 1 or posX == self.posX - 1) then
        return true
    end
    return false
end
setmetatable(Knight, { __index = BasePiece })

function drawPlayerOutline(posx, posy)
    sspr(0, 48, 16, 16, posx * 16, posy * 16)
end

function drawMoveOutline(posx, posy)
    sspr(16, 48, 16, 16, posx * 16, posy * 16)
end

function drawDangerOutline(posx, posy)
    sspr(32, 48, 16, 16, posx * 16, posy * 16)
end