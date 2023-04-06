--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Canvas }<==
        
        About using canvas to display more
                        things faster.

]]--

img = Image.load("image.png", VRAM)
canvas = Canvas.new()                               -- Create a new canvas

nb = 0                                                      -- This will count how many images have been loaded and displayed

while not Keys.held.Start do
	Controls.read()

	-- for i=1, 3 do
		-- nb = nb + 3
		-- obj = Canvas.newImage(math.random(-10, 240), math.random(-10, 180), img)
		-- Canvas.add(canvas, obj)
	-- end
    
    local obj = Canvas.newImage(math.random(-10, 240), math.random(-10, 180), img)          -- Create a new canvas image object based on the image loaded at the beggining
    Canvas.add(canvas, obj)                                                                                             -- Add this object to the canvas
    nb = nb + 1
    
    Canvas.draw(SCREEN_UP, canvas, 0, 0)                                                                     -- Display the canvas
	screen.print(SCREEN_DOWN, 0, 0, "FPS: "..NB_FPS)
	screen.print(SCREEN_DOWN, 0, 8, "IMG: "..nb)
	screen.print(SCREEN_DOWN, 0, 50, "Press START to quit")
    
	render()
end

Image.destroy(img)
img = nil
Canvas.destroy(canvas)                                                                                                  -- Destroy the canvas
canvas = nil
nb = nil
