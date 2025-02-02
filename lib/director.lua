Director = { spawnPoints = 100, level = 1, pointIter = 33, enemys = {} }

-- Todo move player to different
-- Still has to be global
player = Player:new(5, 5)
player:morph(Gop:new(5, 5))

-- Prices determine how many points costs one enemy for director
prices = {
    gop = { price = 100, fab = Gop },
    checker = { price = 200, fab = Checker },
    -- pawn = { price = 900, fab = Pawn },
    rook = { price = 450, fab = Rook },
    knight = { price = 600, fab = Knight }
}

function Director:new(level, boardHeight, boardWidth)
    local obj = { level = level, boardHeight = boardHeight, boardWidth = boardWidth, spawnPoints = 100, level = 1, pointIter = 33, enemys = {} }

    player = Player:new(5, 5)
    player:morph(Gop:new(5, 5))
    player.health = 3
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function getMaxPriceFor(value)
    maxV = nil
    for i, v in pairs(prices) do
        if v.price <= value then
            if maxV == nil then
                maxV = v
            elseif maxV.price < v.price then
                maxV = v
            end
        end
    end
    if maxV != nil then
        return maxV
    else
        return nil
    end
end

function Director:getPiece(posX, posY)
    for i, v in ipairs(self.enemys) do
        if v.posX == posX and v.posY == posY then
            return v
        end
    end
    return nil
end

function Director:killEnemy(posX, posY)
    for i, v in ipairs(self.enemys) do
        if v.posX == posX and v.posY == posY then
            deli(self.enemys, i)
            return v
        end
    end
    return nil
end

function Director:getSpots()
    free = {}
    for i = 0, self.boardHeight - 1, 1 do
        for j = 0, self.boardWidth - 1, 1 do
            occupied = false
            for _, v in ipairs(self.enemys) do
                if v.posX == i and v.posY == j then
                    occupied = true
                elseif player.posX == i and player.posY == j then
                    occupied = true
                end
            end
            if not occupied then
                add(free, { posX = i, posY = j })
            end
        end
    end
    return free
end

-- Spends points to prepare new list of enemys
-- Scaler - value form 0 to 16 (upd) determening how many enemys present on set
function Director:requestEnemys()
    -- toSpend = self.spawnPoints / (count(self.enemys) + 1)
    free = self:getSpots()
    printh("Spawning enemys")
    en = getMaxPriceFor(self.spawnPoints)
    while en != nil do
        -- Find space
        pos = del(free, rnd(free))
        add(self.enemys, en.fab:new(pos.posX, pos.posY))
        self.spawnPoints -= en.price
        en = getMaxPriceFor(self.spawnPoints)
    end
end

function Director:moveEnemys()
    for i, v in ipairs(self.enemys) do
        moves = v:getMoves(self:getSpots())
        if v:checkMove(player.posX, player.posY) then
            v:damage(player.posX, player.posY)
            player.health -= 1
        elseif count(moves) > 0 then
            newPos = rnd(moves)
            self.enemys[i]:move(newPos.posX, newPos.posY)
        end
    end
end

function Director:getDangerSpotsFor(posX, posY)
    res = {}
    for i, v in ipairs(self.enemys) do
        if v.posX == posX and v.posY == posY then
            moves = v:getMoves(self:getSpots())
            for move in all(moves) do
                add(res, { posX = move.posX, posY = move.posY })
            end
            return res
        end
    end
    return res
end

-- Handles point managment for director
function Director:iterPoints()
    self.spawnPoints += self.level * self.pointIter
    self.pointIter *= 1.05
end