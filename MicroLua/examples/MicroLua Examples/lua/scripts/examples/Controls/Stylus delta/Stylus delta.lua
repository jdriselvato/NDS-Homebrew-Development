--[[

        ==>[ MICROLUA EXAMPLE ]<==
                ==>{ Stylus delta }<==
        
        About using stylus moves to play
                      with images.

]]--

img = Image.load("flag.png", VRAM)

deltaAngle = 0
angle = 0
newWidth = Image.width(img)
newHeight = Image.height(img)

inertiaTimer = Timer.new()                                                                                                                                                                   -- This timer is used to show some intertia
inertiaTimer:start()

while not Keys.newPress.Start do
	Controls.read()

	screen.drawFillRect(SCREEN_DOWN, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, Color.new(31, 31, 31))
	screen.print(SCREEN_UP, 0, 0, "Move your stylus horizontally and")
	screen.print(SCREEN_UP, 0, 8, "release it quickly to move the flag")
	screen.print(SCREEN_UP, 0, 16, "Press R to zoom in")
	screen.print(SCREEN_UP, 0, 24, "Press L to zoom out")
	screen.print(SCREEN_UP, 0, 32, "Press START to quit")
	screen.print(SCREEN_UP, 0, 184, "FPS: "..NB_FPS)
    
    screen.blit(SCREEN_DOWN, 96, 64, img)
    
    -- This rectangle is to show the zone where the movement will be taken in consideration
    screen.setAlpha(50)
    screen.drawFillRect(SCREEN_DOWN, 0, 0, 256, 96, Color.new(0,0,0))

	Image.rotateDegree(img, angle, Image.width(img)/2, Image.height(img)/2)
	
	if Keys.held.R then
		newWidth = newWidth + 2
		newHeight = newHeight + 2
		Image.scale(img, newWidth, newHeight)
	end
	if Keys.held.L then
		newWidth = newWidth - 2
		newHeight = newHeight - 2
		if newWidth < 1 then newWidth = 1 end
		if newHeight < 1 then newHeight = 1 end
		Image.scale(img, newWidth, newHeight)
	end	
    
    if inertiaTimer:getTime() > 80 then                                                                                                                                                         -- Some code to handle inertia
        inertiaTimer:reset()
        inertiaTimer:start()
        
        if deltaAngle > 0 then deltaAngle = deltaAngle - 1
        elseif deltaAngle < 0 then deltaAngle = deltaAngle + 1 end
        angle = angle + deltaAngle
        if angle > 360 then angle = angle - 360
        elseif angle < 0 then angle = 360 + angle end
    end
    
    if Stylus.held and Stylus.Y < 96 then                                                                                                                                               -- The movement is only taken above the flag, and with deltaX
        deltaAngle = Stylus.deltaX                                                                                                                                                          -- Because handling deltaY and other positions is useless here (and too long to code!)
    end

	render()
end

Image.destroy(img)
img = nil
angle = nil
deltaAngle = nil
newWidth = nil
newHeight = nil
inertiaTimer:stop()
inertiaTimer = nil
