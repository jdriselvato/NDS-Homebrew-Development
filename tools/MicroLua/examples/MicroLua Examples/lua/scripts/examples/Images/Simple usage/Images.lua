--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Images }<==
        
             About displaying images and
                    playing with them.

]]--

img = Image.load("man.png", VRAM)                           -- Load image in VRAM (video memory)

x = 10
y = 10

while not Keys.newPress.Start do
	Controls.read()

	if Stylus.held then
		x = Stylus.X
		y = Stylus.Y
	end

	if Keys.held.Up then y = y - 2 end
	if Keys.held.Down then y = y + 2 end
	if Keys.held.Right then x = x + 2 end
	if Keys.held.Left then x = x - 2 end

	screen.blit(SCREEN_DOWN, x, y, img)                                                 -- Display the image
	screen.print(SCREEN_UP, 0, 0, "Use the stylus or + to move the man")
	screen.print(SCREEN_UP, 0, 8, "Press START to quit")
	screen.print(SCREEN_UP, 0, 184, "FPS: "..NB_FPS)
	
    render()
end

Image.destroy(img)                                                                                  -- Destroy the image
img = nil
x = nil
y = nil
