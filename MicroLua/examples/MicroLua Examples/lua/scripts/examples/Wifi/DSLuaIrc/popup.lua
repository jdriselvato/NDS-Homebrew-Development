popup = {}

popup.text = {}
popup.active = false
popup.buttons = 0
popup.width = 0
popup.heigh = 0
popup.scr = SCREEN_DOWN
popup.rep = 0

popup.new = function(screen, title, text, button, border)
	if(title == nil) then title = "PopUp" end
	if(text == nil) then text = "" end
	if(button == nil) then button = 0 end
	if(border == nil) then border = "*" end
	if(string.len(border)>1) then border = string.sub(border,1,1) end
	local longmax = 34
	local long, longti, longte, longbo, i, j, add
	local buffer = {}
	popup.scr = screen
    -- Empty text table
	for i=1, #popup.text do
		table.remove(popup.text,1)
	end
    -- Prepare title
	title = " "..title.." "
	if(string.len(title)> 30) then
		title = string.sub(title,1,30)
		longti = longmax
	else
		longti = string.len(title)
	end
    -- Prepare text
	if(string.len(text)> 30) then
		for i=1, string.len(text), 30 do
			table.insert(buffer,string.sub(text,i,i+29))
		end
		longte = longmax
	else
		table.insert(buffer,text)
		longte = string.len(text)+4
	end
    -- Prepare buttons
	if(button == 1) then
		if(screen == SCREEN_DOWN) then longbo = 6
		else longbo = 9 end
	elseif(button == 2) then
		if(screen == SCREEN_DOWN) then longbo = 10
		else longbo = 13 end
	elseif(button == 3) then
		if(screen == SCREEN_DOWN) then longbo = 17
		else longbo = 23 end
	else longbo = 0
	end
	longbo = longbo+4
    -- Popup length
	if(longti > longte) then
		if(longti > longbo) then long = longti
		else
			long = longbo
		end
	else
		if(longte > longbo) then long = longte
		else
			long = longbo
		end
	end
	i = math.floor(long/2)
	if(i+i ~= long) then long = long+1 end
    -- Format title
	i = math.floor(string.len(title)/2)
	if(i+i ~= string.len(title)) then add = 1 else add = 0 end
	title = string.rep(border,math.floor(long/2)-(i+add))..title..
		string.rep(border,math.floor(long/2)-i)
    -- Insert title
	table.insert(popup.text,title)
    -- Insert empty line
	text = border..string.rep(" ",long-2)..border
	table.insert(popup.text,text)
    -- Insert text
	for i=1, #buffer do
		text = border.." "..buffer[i]..string.rep(" ",long-(3+string.len(buffer[i])))..border
		table.insert(popup.text,text)
	end
    -- Insert empty line
	text = border..string.rep(" ",long-2)..border
	table.insert(popup.text,text)
    -- Insert button
	if(button == 1 or button == 2) then
		text = border..string.rep(" ",math.floor((long-2)/2)-math.floor(longbo/2))..
			string.rep(border,longbo)..
			string.rep(" ",math.floor((long-2)/2)-math.floor(longbo/2))..border
	elseif(button == 3) then
		i = math.floor(long/4)-2
		text = border..string.rep(" ",i-4)..string.rep(border,9)..
			string.rep(" ",i-4)..string.rep(" ",i-4)..
			string.rep(border,13)..string.rep(" ",i-4)..border	
	end
	if(button~=0) then table.insert(popup.text,text) end
	if(button == 1) then
		text = border..string.rep(border,math.floor((long-2)/2)-math.floor(longbo/2))..
			border.." OK[A] "..border..
			string.rep(border,math.floor((long-2)/2)-math.floor(longbo/2))..border
	elseif(button == 2) then
		text = border..string.rep(border,math.floor((long-2)/2)-math.floor(longbo/2))..
			border.." ANNULE[B] "..border..
			string.rep(border,math.floor((long-2)/2)-math.floor(longbo/2))..border
	elseif(button == 3) then
		i = math.floor(long/4)-2
		text = border..string.rep(border,i-4)..border.." OK[A] "..border..
			string.rep(border,i-4)..string.rep(border,i-4)..
			border.." ANNULE[B] "..border..string.rep(border,i-4)..border
	else
		text = string.rep(border,long)	
	end
	table.insert(popup.text,text)
	popup.width = long*6
	popup.heigh = #popup.text *9
	popup.buttons = button
	popup.active = true
	popup.rep = 0
end

popup.del = function()
	popup = nil
end

popup.close = function()
	popup.active = false
end

popup.show = function()
	local i
	local x = (128-math.floor(popup.width/2))+2
	local y = 96- math.floor(popup.heigh/2)
	if(popup.active) then
		screen.drawFillRect(popup.scr,x+4,y+4,popup.width+x+6,popup.heigh+y+2,Color.new(0,0,0))
		screen.drawFillRect(popup.scr,x,y-1,popup.width+x+2,popup.heigh+y-2,Color.new(0,0,25))
		for i = 1, #popup.text do
			screen.print(popup.scr,x,y+((i-1)*9),popup.text[i])
		end
	end
	if(popup.scr == SCREEN_UP) then
		if(Keys.newPress.A) then
			if(popup.buttons == 1 or popup.buttons == 3) then
				popup.rep = 1
				popup.active = false
			end
		elseif(Keys.newPress.B) then
			if(popup.buttons > 1) then
				popup.rep = 2
				popup.active = false
			end
		end
	else
		if(Stylus.newPress) then
			local xx, yy
			x = Stylus.X
			y = Stylus.Y
			
		end
	end
end

