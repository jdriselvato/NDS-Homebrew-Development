--[[

        ==>[ MICROLUA EXAMPLE ]<==
                     ==>{ Map }<==
        
            About using maps to make a
                     super good RPG.

]]--

img = Image.load("tiles.png", VRAM)                         -- Load the tiles image
map = Map.new(img, "map.map", 15, 15, 32, 32)        -- Load the map file (map structure)

scrollX = 0
scrollY = 0

Map.setTile(map, 0, 0, 0)                                           -- Dynamically change a tile

while not Keys.newPress.Start do
	Controls.read()
	
	if Keys.held.Up then scrollY = scrollY - 1 end
	if Keys.held.Down then scrollY = scrollY + 1 end
	if Keys.held.Left then scrollX = scrollX - 1 end
	if Keys.held.Right then scrollX = scrollX + 1 end
	
	Map.scroll(map, scrollX, scrollY)                           -- Scroll the map

	Map.draw(SCREEN_DOWN, map, 10, 10, 5, 5)      -- Display the map
	screen.print(SCREEN_UP, 0, 0, "+ to scroll")
	screen.print(SCREEN_UP, 0, 16, "Press START to quit")
	screen.print(SCREEN_DOWN, 0, 184, "FPS: "..NB_FPS)
	
	render()
end

img = Image.destroy(img)                                        -- Destroy the tiles image
img = nil
map = Map.destroy(map)                                         -- Destroy the map structure
map = nil
scrollX = nil
scrollY = nil

