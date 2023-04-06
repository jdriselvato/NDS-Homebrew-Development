--[[

        ==>[ MICROLUA EXAMPLE ]<==
           ==>{ Alpha transparency }<==
        
       About displaying transparent things

]]--


img = Image.load("man.png", VRAM)
x, y = 0, 0

level = 99                                                                                                         -- Blending coefficient, from 0 to 99; 100 means everything is opaque (just like 99), but it also resets the transparency system (puts the layer index to 1)


while not Keys.newPress.Start do
    Controls.read()
    
    screen.print(SCREEN_UP, 0, 0, "Press L to make the man more transparent")
    screen.print(SCREEN_UP, 0, 8, "Press R to make the man more opaque")
    screen.print(SCREEN_UP, 0, 16, "You can move him with the D-Pad")
    
    screen.print(SCREEN_UP, 0, 32, "Blending coefficient:" .. level)
    
    screen.setAlpha(level, 1)                                                                               -- You need to give a layer index to blend the drawings (the 1 is the first), but this is actually handled by MicroLua so this is facultative
    screen.blit(SCREEN_DOWN, x, y, img)
    
    screen.setAlpha(25)                                                                                     -- Opaque 25% (transparent 75%)
    screen.drawFillRect(SCREEN_DOWN, 0, 0, 128, 96, Color.new(31, 0, 0))
    screen.drawFillRect(SCREEN_DOWN, 128, 96, 256, 192, Color.new(31, 31, 0))
    screen.setAlpha(50)                                                                                     -- Opaque 50%
    screen.drawFillRect(SCREEN_DOWN, 128, 0, 256, 96, Color.new(0, 31, 0))
    screen.drawFillRect(SCREEN_DOWN, 0, 96, 128, 192, Color.new(0, 0, 31))
    
    if Keys.held.Left then x = x - 1 end
    if Keys.held.Right then x = x + 1 end
    if Keys.held.Up then y = y - 1 end
    if Keys.held.Down then y = y + 1 end
    
    if Keys.held.L and level > 0 then level = level - 1 end
    if Keys.held.R and level < 99 then level = level + 1 end
    
    render()
end

Image.destroy(img)
img = nil
x, y = nil, nil
level = nil
