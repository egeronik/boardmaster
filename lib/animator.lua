Animator = { queue = {}, animation_time = 0.3, busy = false }

speed = 60 * Animator.animation_time

function Animator:move(piece, posX, posY, kill)
    sfx(0)
    dx = (posX * 16 - piece.posX * 16) / speed
    dy = (posY * 16 - piece.posY * 16) / speed
    piece.state = "hidden"
    add(
        self.queue, {
            fab = piece,
            start = cur_time,
            type = "move",
            kill = kill,
            trajectory = {
                oldX = piece.posX * 16,
                oldY = piece.posY * 16,
                step = 0,
                dx = dx,
                dy = dy,
                targetX = posX * 16,
                targetY = posY * 16
            }
        }
    )
end

function Animator:damage(piece, posX, posY)
    dx = (posX * 16 - piece.posX * 16) / speed * 2
    dy = (posY * 16 - piece.posY * 16) / speed * 2
    piece.state = "hidden"
    add(
        self.queue, {
            fab = piece,
            start = cur_time,
            type = "damage",
            trajectory = {
                oldX = piece.posX * 16,
                oldY = piece.posY * 16,
                step = 0,
                dx = dx,
                dy = dy,
                targetX = posX * 16,
                targetY = posY * 16
            }
        }
    )
end

function Animator:draw()
    -- Hide while animated
    if count(self.queue) > 0 then
        self.busy = true
        item = self.queue[1]
        -- If done
        if cur_time - self.queue[1].start >= self.animation_time then
            item.fab.state = "shown"
            if item.kill == true then
                sfx(1)
            end
            deli(self.queue, 1)
            if count(self.queue) > 0 then
                sfx(0)
                self.queue[1].start = cur_time
            end
        else
            if item.type == "move" then
                if item.trajectory.step <= speed then
                    newX = item.trajectory.oldX + (item.trajectory.dx * item.trajectory.step)
                    newY = item.trajectory.oldY + (item.trajectory.dy * item.trajectory.step)
                    item.fab:drawXY(newX, newY)
                    item.trajectory.step += 1
                end
            elseif item.type == "damage" then
                if item.trajectory.step <= speed / 2 then
                    newX = item.trajectory.oldX + (item.trajectory.dx * item.trajectory.step)
                    newY = item.trajectory.oldY + (item.trajectory.dy * item.trajectory.step)
                    item.fab:drawXY(newX, newY)
                    item.trajectory.step += 1
                elseif item.trajectory.step < speed then
                    newX = item.trajectory.targetX - (item.trajectory.dx * (item.trajectory.step - speed / 2))
                    newY = item.trajectory.targetY - (item.trajectory.dy * (item.trajectory.step - speed / 2))
                    item.fab:drawXY(newX, newY)
                    item.trajectory.step += 1
                end
            end
        end
        for i = 2, count(self.queue), 1 do
            item = self.queue[i]
            item.fab:drawXY(item.trajectory.oldX, item.trajectory.oldY)
        end
        return
    end
    self.busy = false
    return
end