function toInt(value)
    return value - value % 1
end

function generateFreeSpots(h, w)
    free = {}
    for i = 0, h - 1, 1 do
        for j = 0, w - 1, 1 do
            add(free, { posX = i, posY = j })
        end
    end
    return free
end