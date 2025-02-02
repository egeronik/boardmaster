Board = { boardHeight = 8, boardWidth = 8, cooldown = 0.5, lastTurn = 0, director = nil, turn = 0 }

score = 0

function Board:init()
    printh("Board:init")
    music(0)
    score = 0
    Board:drawGrid()
    Board.director = Director:new(1, 8, 8)
    Board.lastTurn = cur_time
    self.director:requestEnemys()
end

function Board:drawGrid()
    for i = 0, self.boardHeight, 1 do
        for j = 0, self.boardWidth, 1 do
            if ((j + i) % 2 == 0) then
                act_i = i * 2
                act_j = j * 2
                mset(act_i, act_j, 4)
                mset(act_i + 1, act_j, 5)
                mset(act_i, act_j + 1, 20)
                mset(act_i + 1, act_j + 1, 21)
            end
        end
    end
end

function Board:drawPices()
    for i, v in ipairs(self.director.enemys) do
        v:draw()
    end
    player:draw()
end

function Board:spawnPices()
end

function Board:Turn()
    self.turn += 1
    -- Move player TODO Grid limit check
    newX = toInt(Mouse.posX / 16)
    newY = toInt(Mouse.posY / 16)
    if not player.currentPice:checkMove(newX, newY) then
        return
    end

    -- Check if enemy on spot
    nep = self.director:getPiece(newX, newY)
    if nep != nil then
        if nep.health > 1 then
            player:damage(newX, newY)
            nep.health -= 1
        else
            nep = self.director:killEnemy(newX, newY)
            player:move(newX, newY, true)
            score += nep.points
            player:morph(nep)
            return
        end
    else
        player:move(newX, newY, false)
    end
    -- Move enemys
    self.director:moveEnemys()
    -- Check if enemy killed player

    self.director:iterPoints()
    if self.turn % 3 == 0 then
        self.director:requestEnemys()
    end
end

function Board:update()
    Mouse:updatePos()
    if not Animator.busy then
        if Mouse:isClicked() then
            self:Turn()
            self.lastTurn = cur_time
        end
    end
end

function Board:draw()
    -- Bottom layer
    map()

    -- Pices
    self:drawPices()

    Animator:draw()
    if player.health <= 0 and not Animator.busy then
        music(5)
        changeLevel("results")
        return
    end

    -- Move outlines
    free = generateFreeSpots(self.boardHeight, self.boardWidth)
    for move in all(player.currentPice:getMoves(free)) do
        drawMoveOutline(move.posX, move.posY)
    end
    -- MB use it
    -- drawPlayerOutline(player.posX, player.posY)

    -- Danger spots
    spots = self.director:getDangerSpotsFor(toInt(Mouse.posX / 16), toInt(Mouse.posY / 16))
    for spot in all(spots) do
        drawDangerOutline(spot.posX, spot.posY)
    end
    -- Mouse, do not move up
    Mouse:draw()
end