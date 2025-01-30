BasePiece = { spriteX = 0, spriteY = 0, posX = 0, posY = 0 }

function BasePiece:draw()
    sspr(self.spriteX, self.spriteY, 16, 16, self.posX * 16, self.posY * 16)
end

function BasePiece:new(posX, posY)
    local obj = { posX = posX, posY = posY }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

Gop = { spriteX = 0, spriteY = 32 }
setmetatable(Gop, { __index = BasePiece })

Pawn = { spriteX = 16, spriteY = 32 }
setmetatable(Pawn, { __index = BasePiece })

Rook = { spriteX = 32, spriteY = 32 }
setmetatable(Rook, { __index = BasePiece })

Knight = { spriteX = 16, spriteY = 32 }
setmetatable(Knight, { __index = BasePiece })

Pawn = { spriteX = 16, spriteY = 32 }
setmetatable(Pawn, { __index = BasePiece })

function drawPlayerOutline(posx, posy)
    sspr(0, 48, 16, 16, posx * 16, posy * 16)
end

function drawMoveOutline(posx, posy)
    sspr(16, 48, 16, 16, posx * 16, posy * 16)
end