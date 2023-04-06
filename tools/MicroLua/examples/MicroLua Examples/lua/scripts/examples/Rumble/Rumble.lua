--[[

        ==>[ MICROLUA EXAMPLE ]<==
               ==>{ Rumble }<==
        
            About shaking your console!

]]--

assert(Rumble.isInserted(), "No rumble device inserted")            -- To be sure the rumble device is here

while not Keys.newPress.Start do
	Controls.read()
	
	if Keys.newPress.A then Rumble.set(true) end                    -- Enable rumble
	if Keys.newPress.B then Rumble.set(false) end                   -- Disable rumble

	screen.print(SCREEN_UP, 0, 0, "Press START to quit")
	screen.print(SCREEN_DOWN, 0, 0, "[A]: Rumble ON")
	screen.print(SCREEN_DOWN, 0, 8, "[B]: Rumble OFF")

	render()
end

