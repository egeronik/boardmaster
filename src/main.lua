MainMenu = { name = "main", selected = 0, labels = { [0] = "start", "settings", "exit" } }

function drawMenu()
    posx = 25
    posy = 25
    for i = 0, count(MainMenu.labels), 1 do
        print(MainMenu.labels[i], posx, posy + i * 10)
        if i == MainMenu.selected then
            print(">", posx - 5, posy + i * 10)
        end
    end

    print("X - to enter", 64, 120)
end

function MainMenu:init()
    MainMenu.selected = 0
end

function MainMenu:draw()
    drawMenu()
    -- Mouse.draw()
end

function MainMenu:update()
    -- Mouse.updatePos()
    -- LMB
    if Mouse.btn == 1 then
        circfill(Mouse.posX, Mouse.posY, 5, t())
    end
    if btnp(2) and MainMenu.selected > 0 then
        MainMenu.selected = MainMenu.selected - 1
    elseif btnp(3) and MainMenu.selected < count(MainMenu.labels) then
        MainMenu.selected = MainMenu.selected + 1
    end
    if btnp(5) then
        if MainMenu.selected == 0 then
            changeLevel("board")
        end
    end
end