--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Nifi }<==
        
         About connecting many consoles
           together in ad-hoc (client part).

]]--


--[[
    This script displays the stickman controled on the other console.
    This is the client part.
]]--
	
	
Nifi.init(10)                                                           -- Initialising Nifi on canal 10 (same as the server part).

perso = Image.load("man.png", VRAM)

x = 140
y = 90

while not Keys.newPress.Start do
	Controls.read()
	
		if Nifi.checkMessage() then                           -- Returns true if a message is received through Nifi
            dir = Nifi.readMessage()                            -- Give the received message.
            
            -- Finding the wanted direction
            if dir == "up" then
                y = y - 2
            end
            if dir == "down" then
                y = y + 2
            end
            if dir == "right" then
                x = x + 2
            end
            if dir == "left" then
                x = x - 2
            end
		end	
		
	screen.blit(SCREEN_DOWN, x, y, perso)
	
	render()
end 

Nifi.stop()                                                         -- End Nifi connection.
Image.destroy(perso)
perso = nil
x = nil
y = nil
