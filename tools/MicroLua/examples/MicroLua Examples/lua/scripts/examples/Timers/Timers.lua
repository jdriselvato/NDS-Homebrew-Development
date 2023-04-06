--[[

        ==>[ MICROLUA EXAMPLE ]<==
                    ==>{ Timers }<==
        
        About using your console to cook
                         your eggs!

]]--

tmr = Timer.new()                   -- Create the timer
tmr:start()                               -- Start the timer

while not Keys.newPress.Start do
	Controls.read()
    
	if Keys.newPress.A then tmr:stop() end          -- Stop the timer
	if Keys.newPress.B then tmr:start() end
	if Keys.newPress.X then tmr:reset() end         -- Reset the timer

	tmrTime = tmr:getTime()                                     -- Get the timer's time
    
    -- Extract informations from the time
	hour = math.floor(tmrTime/3600000)
	rest = tmrTime % 3600000
	minut = math.floor(tmrTime/60000)
	rest = rest % 60000
	second = math.floor(rest/1000)
	rest = rest % 1000
	milli = rest
	
	screen.print(SCREEN_UP, 0, 0, "A: stop")
	screen.print(SCREEN_UP, 0, 8, "B: start")
	screen.print(SCREEN_UP, 0, 16, "X: reset")
	screen.print(SCREEN_UP, 0, 24, "Start: quit")
	screen.print(SCREEN_DOWN, 50, 50, ""..hour..":"..minut..":"..second..":"..milli)

    render()
end

tmr = nil
tmrTime = nil
rest = nil
minut = nil
second = nil
milli = nil

