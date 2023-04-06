--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Sprites }<==
        
        About putting people in your RPG!

]]--

spr = Sprite.new("sprite.png", 24, 32, VRAM)                -- Load sprite image

-- Create animations; frame indexes begin at 0; 300ms is the delay between two frames
spr:addAnimation({0,1,2,1}, 300)                                   -- Walk up
spr:addAnimation({3,4,5,4}, 300)                                   -- Walk right
spr:addAnimation({6,7,8,7}, 300)                                   -- Walk down
spr:addAnimation({9,10,11,10}, 300)                              -- Walk left

x = 150
y = 80
direction = 1


while not Keys.newPress.Start do
	Controls.read()
    
    if Keys.held.Up or Keys.held.Down or Keys.held.Left or Keys.held.Right then
        spr:playAnimation(SCREEN_DOWN, x, y, direction)                                                     -- Play the right movement animation
    else                                                                                
        spr:drawFrame(SCREEN_DOWN, x, y, -2 + direction * 3)                                              -- Play the right idle frame (the calculation is just a trick to get the right frame)
    end

	if Keys.held.Up then direction = 1 y = y - 1 end
	if Keys.held.Right then direction = 2 x = x + 1 end
	if Keys.held.Down then direction = 3 y = y + 1 end
	if Keys.held.Left then direction = 4 x = x - 1 end

	screen.print(SCREEN_UP, 0, 184, "FPS: "..NB_FPS)
	screen.print(SCREEN_UP, 0, 0, "Press START to quit")

	render()
end

spr:destroy()                       -- Destroy the sprite
spr = nil
x = nil
y = nil
direction = nil

