-- ********************************************************
-- * showMiniWifiSignal(scr, pos)
-- ********************************************************
-- *                     DESCRIPTION
-- * Display signal power
-- ********************************************************
-- *                       INPUTS
-- * scr : screen to display
-- * pos : corner to display
-- ********************************************************
-- *                      OUTPUTS
-- *
-- ********************************************************
_POSUL = 1	-- TOP-LEFT
_POSUR = 2	-- TOP-RIGHT
_POSDR = 3	-- BOTTOM-RIGHT
_POSDL = 4	-- BOTTOM-LEFT
function showMiniWifiSignal(scr,pos)
	local tabx = {2,240,2,240}
	local taby = {14,14,190,190}
	local x = tabx[pos]
	local y = taby[pos]
	local cGray = Color.new(15,15,15)
	local cGreen = Color.new(0,26,12)
	if(Wifi.numAP == nil) then Wifi.numAP = -1 end
	if(Wifi.numAP > -1) then
		local aps = Wifi.getAP(Wifi.numAP)
		local force = aps.rssi*100/175
		if(force > 1) then screen.drawFillRect(scr,x,y,x+3,y-4,cGreen) end
		if(force > 25) then screen.drawFillRect(scr,x+3,y,x+6,y-6,cGreen) end
		if(force > 50) then screen.drawFillRect(scr,x+6,y,x+9,y-8,cGreen) end
		if(force > 75) then screen.drawFillRect(scr,x+9,y,x+12,y-10,cGreen) end
		screen.drawRect(scr,x,y,x+4,y-4,cGray)
		screen.drawRect(scr,x+3,y,x+7,y-6,cGray)
		screen.drawRect(scr,x+6,y,x+10,y-8,cGray)
		screen.drawRect(scr,x+9,y,x+13,y-10,cGray)
	end
end

-- ********************************************************
-- * delMiniWifiSignal()
-- ********************************************************
-- *                     DESCRIPTION
-- * Free memory by destroying variables and
-- * functions created to display signal power
-- ********************************************************
-- *                       INPUTS
-- * 
-- ********************************************************
-- *                      OUTPUTS
-- *
-- ********************************************************
function delMiniWifiSignal()
	_POSUL = nil
	_POSUR = nil
	_POSDR = nil
	_POSDL = nil
	showMiniWifiSignal = nil
	delMiniWifiSignal = nil
	collectgarbage("collect")
end


