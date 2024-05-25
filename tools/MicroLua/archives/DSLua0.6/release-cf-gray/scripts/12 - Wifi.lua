-- set up screens for text output
SCREEN_BOTTOM = 0
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

PCIP = ""
continue = true

-- say hello
BGBotText:PrintXY( 0, 0, "Connecting to Wifi!" )
if Wifi.ConnectWFC() then
	while continue do
        BGBotText:PrintXY( 0, 0, "Connected!         " )
		Buffer = string.rep(".", 16)
        BGBotText:PrintXY( 0, 3, "Press A to connect via UDP        " )
        BGBotText:PrintXY( 0, 4, "Press B to connect as a TCP Client" )
        BGBotText:PrintXY( 0, 5, "                                  " )
        BGBotText:PrintXY( 0, 6, "                                  " )
		while not Pads.A() and not Pads.B() and not Pads.X() and not Pads.Y() do
		end
		if(Pads.A()) then
			PCIP = ""
			Sock = Wifi.InitUDP(PCIP,9501)
			BGBotText:PrintXY( 0, 1, "UDP Connected" )
		else
			if(Pads.B()) then
				PCIP = "192.168.1.2"
				Sock = Wifi.InitTCP(PCIP,9501)
				BGBotText:PrintXY( 0, 1, "TCP Client Connected" )
			end
		end
		q = 1;
		a = 0
		b = 0
		x = 0
		y = 0
		l = 0
		r = 0
		start = 0
		select = 0
		up = 0
		down = 0
		left = 0
		right = 0
        BGBotText:PrintXY( 0, 3, "Press A to Receive Data           " )
        BGBotText:PrintXY( 0, 4, "Press B to Send Data              " )
        BGBotText:PrintXY( 0, 5, "                                  " )
        BGBotText:PrintXY( 0, 6, "                                  " )
		while q > 0 do
			if Pads.A() and a == 0 then
			a = 1
				Sock:RecvFrom("192.168.1.2", Buffer, 16)
				ip = "                                                                            "
				Sock:GetLastIP(ip)
				BGBotText:PrintXY( 0, 2, "Received " .. Buffer )
				BGBotText:PrintXY( 0, 15, "From: " .. ip .. "  ")
			end
			if not Pads.A() and a == 1 then
				BGBotText:PrintXY( 0, 0, math.random(10) .. " " )
			a = 0
			end
			if Pads.B() and b == 0 then
			b = 1
				Sock:SendTo("192.168.1.2", Buffer, 16)
				ip = "                                                         "
				Sock:GetLastIP(ip)
				BGBotText:PrintXY( 0, 2, "Sent " .. Buffer )
				BGBotText:PrintXY( 0, 15, "To: " .. ip .. "  ")
			end
			if not Pads.B() and b == 1 then
				BGBotText:PrintXY( 0, 0, math.random(10) .. " " )
			b = 0
			end
			if Pads.Select() then
			    Sock:Close()
				break
			end
			if Pads.Start() then
				continue = false
			    Sock:Close()
				break
			end
  Screen.WaitForVBL()
		end
  Screen.WaitForVBL()
		-- received = Sock:RecvFrom("192.168.1.2",Buffer, 6, 0)
		-- if received then
		-- print(Buffer)
		-- else
		-- print("Failed To Receieve")
		-- end
		-- Sock:Close()
	end
	Wifi.Disconnect()
    BGBotText:PrintXY( 0, 0, "Disconnected!      " )
end

-- wait until a key is pressed
DSLua.WaitForAnyKey()
