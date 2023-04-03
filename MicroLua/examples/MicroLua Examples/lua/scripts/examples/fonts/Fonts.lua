--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Fonts }<==
        
        About using custom fonts to make
                 your texts look better.

]]--

font = Font.load("forte.bin")                                       -- Load the custom font

while not Keys.newPress.Start do
	Controls.read()

	screen.print(SCREEN_UP, 0, 0, "Press START to quit")
	screen.print(SCREEN_DOWN, 0, 0, "This is default font")
    -- Display a text using the custom font
	screen.printFont(SCREEN_DOWN, 0, 36, "This is custom font", Color.new(31, 31, 0), font)
	
	render()
end

Font.destroy(font)                                                    -- Destroy the custom font
font = nil
