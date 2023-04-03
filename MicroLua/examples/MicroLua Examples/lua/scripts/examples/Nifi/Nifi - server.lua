--[[

        ==>[ MICROLUA EXAMPLE ]<==
                      ==>{ Nifi }<==
        
         About connecting many consoles
           together in ad-hoc (server part).

]]--


--[[
    This script allow you to control a stickman displayed on the other console.
    This is the server side.
]]--


Nifi.init(10)                                                -- Initialising Nifi on canal 10 (same as the client part).

while not Keys.newPress.Start do
	Controls.read()
	
	if Keys.held.Up then
		Nifi.sendMessage("up")                      -- This is used to send a String through Nifi (here, the direction)
	end
	if Keys.held.Down then
		Nifi.sendMessage("down")
	end
	if Keys.held.Right then
		Nifi.sendMessage("right")
	end
	if Keys.held.Left then
		Nifi.sendMessage("left")
	end
	
	screen.print(SCREEN_DOWN, 10, 10, "Use the D-Pad to control the stickman.")
	
	render()
end 

Nifi.stop()                                                 -- End Nifi connection.
