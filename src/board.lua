Board = { gridSize = 8, enemys = {} }

player = Gop:new(5, 2)

function Board.init()
    Board:drawGrid()
end

function Board:drawGrid()
    for i = 0, 8, 1 do
        for j = 0, 8, 1 do
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
    for i, v in ipairs(self.enemys) do
        v:draw()
    end
    player:draw()
end

function Board:update()
    Mouse:updatePos()
    if Mouse:isClicked() then
        player.posX = toInt(Mouse.posX / 16)
        player.posY = toInt(Mouse.posY / 16)
    end
end

function Board:draw()
    -- Bottom layer
    map()

    -- Pices
    Board:drawPices()

    -- Outlines
    drawMoveOutline(toInt(Mouse.posX / 16), toInt(Mouse.posY / 16))
    drawPlayerOutline(player.posX, player.posY)
    -- Mouse, do not move up
    Mouse:draw()
end