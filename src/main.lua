MainMenu = { name = "main", selected = 0, labels = { [0] = "start", "exit" } }

function MainMenu:drawMenu()
    posx = 25
    posy = 65
    for i = 0, count(self.labels), 1 do
        print(self.labels[i], posx, posy + i * 10)
        if i == self.selected then
            print(">", posx - 5, posy + i * 10)
        end
    end
    sprx = 16
    spry = 0
    spr(128, sprx, spry, 4, 4)
    spr(132, sprx + 32, spry, 4, 4)
    print("boardmaster", sprx, spry + 34)
    print("X - to enter", 64, 120)
end

function MainMenu:init()
    self.selected = 0
end

function MainMenu:draw()
    self:drawMenu()
    Mouse:draw()
end

function MainMenu:update()
    Mouse:updatePos()
    if btnp() != 0 then
        printh(btnp())
    end
    -- LMB
    if btnp(2) and self.selected > 0 then
        self.selected = self.selected - 1
    elseif btnp(3) and self.selected < count(self.labels) then
        self.selected = self.selected + 1
    end
    if btnp(5) then
        -- Todo settings
        if self.selected == 0 then
            changeLevel("board")
        else
            stop()
        end
    end
end