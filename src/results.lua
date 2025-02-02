ResultsMenu = { name = "main", selected = 0, labels = { [0] = "main menue", "restart" } }

function ResultsMenu:drawMenu()
    posx = 25
    posy = 25
    print("score: " .. tostr(score), posx, posy - 10)
    for i = 0, count(self.labels), 1 do
        print(self.labels[i], posx, posy + i * 10)
        if i == self.selected then
            print(">", posx - 5, posy + i * 10)
        end
    end

    print("X - to enter", 64, 120)
end

function ResultsMenu:init()
    self.selected = 0
end

function ResultsMenu:draw()
    self:drawMenu()
    Mouse:draw()
end

function ResultsMenu:update()
    Mouse:updatePos()
    -- LMB
    if Mouse.btn == 1 then
        circfill(Mouse.posX, Mouse.posY, 5, t())
    end
    if btnp(2) and self.selected > 0 then
        self.selected = self.selected - 1
    elseif btnp(3) and self.selected < count(self.labels) then
        self.selected = self.selected + 1
    end
    if btnp(5) then
        -- Todo settings
        if self.selected == 0 then
            changeLevel("main")
        elseif self.selected == 1 then
            changeLevel("board")
        end
    end
end