-- Inherited
-- posX
-- posY
-- currentPice - moves and sprite
-- health - 3 to 0
Player = { health = 3 }

-- Updates player current piece
function Player:morph(piece)
    self.currentPice = piece
    self.spriteX = self.currentPice.spriteX
    self.spriteY = self.currentPice.spriteY
end
setmetatable(Player, { __index = BasePiece })

function Player:move(posX, posY, kill)
    Animator:move(self, posX, posY, kill)
    -- Animator:damage(self, posX, posY)

    self.currentPice.posX = posX
    self.currentPice.posY = posY
    self.posX = posX
    self.posY = posY
end