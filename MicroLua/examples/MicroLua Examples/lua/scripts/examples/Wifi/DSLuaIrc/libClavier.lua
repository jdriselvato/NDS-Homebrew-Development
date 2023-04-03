_VCLAVIER = 2.21
clavier = {}
coul = {}
coul.blanc = Color.new(31,31,31)
coul.noir = Color.new(0,0,0)
coul.bleu = Color.new(0,0,31)
coul.bleuf = Color.new(1,3,15)
coul.bleuv = Color.new(1,29,19)

clavier.new = function()
	local cla = {}
	local i,j
	for i= 1,6 do
		cla[i] = {}
		for j= 1,10 do
			cla[i][j] = {}
		end
	end
	cla.ta = 1             -- Active panel
	cla.xscr = 1		   -- Screen X position
	cla.yscr = 1		   -- Screen Y position
	cla.lon = 1			   -- Screen length (in "boxes")
	cla.ascr = false	   -- Screen display
	cla.cc = coul.blanc	   -- Screen frame colour
	cla.cf = coul.noir	   -- Screen background colour
	cla.ct = coul.blanc	   -- Screen text colour
	cla.text = ""		   -- Typed text
	cla.ycurs = 1		   -- Screen cursor Y position
	cla.ydep = 1		   -- Beginning text position
	cla.canvas = Canvas.new()
	cla.modif = true
	cla.tabTApp = {}
	cla.timer = Timer.new()
	cla.timer:start()
	return cla
end

clavier.del = function(cla)
	if(cla == nil) then 
		clavier = nil
		coul = nil
		_VCLAVIER = nil
	else cla = nil end
end

clavier.addKey = function(cla,x,y,text,nbc,op,cc,cf,cs,ct)
	local key = {}
	local i
	if(type(text) == "number") then text = string.char(text) end
	key.t = text            	-- "[X]" panel colour
	if(cc == nil) then key.cc = coul.blanc
	else key.cc = cc end    	-- Frame colour
	if(cf == nil) then key.cf = coul.bleu
	else key.cf = cf end    	-- Background colour
	if(cs == nil) then key.cs = coul.bleuv
	else key.cs = cs end    	-- Selected background colour
	if(ct == nil) then key.ct = coul.blanc
	else key.ct = ct end    	-- Text colour
	if(op == nil) then key.op = 0
	else key.op = op end    	-- "[X]" panel activated if > 0
	if(nbc == nil) then key.nbc = 1
	else key.nbc = nbc end  	-- Boxes number covered by the key
	key.app = false         	-- The key is not held
	key.canvFond = 0			--  Key background canvas object
	table.insert(cla[y][x],key)
end

clavier.nbPanel = function(cla)
	local i,j
	local nbp = 0
	for i = 1,6 do
		for j= 1,10 do
			if(#cla[i][j] > nbp) then nbp = #cla[i][j] end
		end
	end
	return nbp
end

clavier.modKey = function(cla,x,y,panneau,text,nbc,op,cc,cf,cs,ct)
	if(text ~= nil) then cla[y][x][panneau].t = text end -- "[X]" panel text
	if(cc ~= nil) then cla[y][x][panneau].cc = cc end    -- Frame colour
	if(cf ~= nil) then cla[y][x][panneau].cf = cf end    -- Background colour
	if(cs ~= nil) then cla[y][x][panneau].cs = cs end    -- Selected background colour
	if(ct ~= nil) then cla[y][x][panneau].ct = ct end    -- Text colour
	if(op ~= nil) then cla[y][x][panneau].op = op end     -- "[X]" panel activated if > 0
	if(nbc ~= nil) then cla[y][x][panneau].nbc = nbc end   -- Boxes number covered by the key
end

clavier.delKey = function(cla,x,y,panneau)
	table.remove(cla[y][x],panneau)
end

clavier.modScreen = function(cla,x,y,lon,cc,cf,ct)
	cla.xscr = x
	cla.yscr = y
	cla.lon = lon
	if(cc ~= nil) then cla.cc = cc end    -- Frame colour
	if(cf ~= nil) then cla.cf = cf end    -- Background colour
	if(ct ~= nil) then cla.ct = ct end    -- Text colour
end

clavier.activeScreen = function(cla,active)
	if active then cla.ascr = true
	else cla.ascr = false end
	cla.modif = true
end

clavier.setText = function(cla,text)
	cla.text = text
end

clavier.getText = function(cla)
	return cla.text
end

clavier.activePanel = function(cla,numPanel)
	local maxP = clavier.nbPanel(cla)
	if(numPanel > 0 and numPanel < maxP+1) then
		cla.ta = numPanel
	end
end

clavier.show = function(mat)
	if(mat.modif) then
		clavier.prep(mat)
		mat.modif = false
	end
	local i
	local tps = mat.timer:getTime()
	local cpt = 1
	for i=1, #mat.tabTApp do
		if(mat.tabTApp[cpt].time < tps) then
			Canvas.setAttr(mat.tabTApp[cpt].obj, ATTR_COLOR, mat.tabTApp[cpt].color)
			table.remove(mat.tabTApp, cpt)
		else
			cpt = cpt + 1
		end
	end
	if(mat.ascr) then
		Canvas.setAttr(mat.canvTxt, ATTR_TEXT, mat.text)
	end
	Canvas.draw(SCREEN_DOWN, mat.canvas, 0, 0)
end

clavier.prep = function(mat)
	local i,j,x,y,xx,yy,buff,lon
	local pan = mat.ta
	Canvas.destroy(mat.canvas)
	mat.canvas = Canvas.new()
	for i = 1,6 do
		y = ((i-1)*25)+42
		for j = 1,10 do
			if(mat[i][j][pan] ~= nil) then
				if(mat[i][j][pan].t ~= "") then
					x = ((j-1)*25)+3
					lon = (mat[i][j][pan].nbc -1)*25
					mat[i][j][pan].canvFond = Canvas.newFillRect(x+1,y+1,x+23+lon,y+23,mat[i][j][pan].cf)
					Canvas.add(mat.canvas, mat[i][j][pan].canvFond)
					Canvas.add(mat.canvas, Canvas.newRect(x,y,x+24+lon,y+24,mat[i][j][pan].cc))
					xx = 12-(string.len(mat[i][j][pan].t)*3)+x + math.floor(lon/2)
					yy = y +9
					buff = mat[i][j][pan].t
					Canvas.add(mat.canvas, Canvas.newText(xx,yy,buff,mat[i][j][pan].ct))
				end
			end
		end
	end
	if(mat.ascr) then
		y = ((mat.yscr -1)*25)+42
		x = ((mat.xscr -1)*25)+3
		lon = (mat.lon)*25
		Canvas.add(mat.canvas, Canvas.newFillRect(x+1,y+1,x+lon-2,y+23,mat.cf))
		Canvas.add(mat.canvas, Canvas.newRect(x,y,x+lon-1,y+24,mat.cc))
		lon = math.floor((lon-8)/6)
		buff = string.sub(mat.text,mat.ydep,lon)
		mat.canvTxt = Canvas.newText(x+3,y+9,buff,mat.ct)
		Canvas.add(mat.canvas, mat.canvTxt)
	end
end

clavier.held = function(mat,x,y)
	local i,j,xx,yy,lon
	local pan = mat.ta
	local kre
	local result = ""
	i = math.floor((y- 42)/25) +1
	j = math.floor((x - 3)/25) +1
	if (i > 0 and i < 7) then
		if (j >0 and j < 11) then
			if(mat[i][j][pan] ~= nil) then
				if(mat[i][j][pan].t == "") then
					xx = j-1
					if(xx > 0) then
						while(mat[i][xx][pan].t == "" and xx > 1) do
							xx = xx-1
						end
						if((mat[i][xx][pan].nbc + xx) > j) then j = xx end
					end
				end
				if(mat[i][j][pan].t ~= "") then
					lon = (mat[i][j][pan].nbc)*25
					if(mat[i][j][pan].op == 0) then 
						result = mat[i][j][pan].t
						mat.text = mat.text..result
					elseif(mat[i][j][pan].op > 0) then
						mat.ta = mat[i][j][pan].op
						mat.modif = true 
					else 
						if(mat[i][j][pan].op == -4) then 
							result =" "
							mat.text = mat.text..result
						elseif(mat[i][j][pan].op == -2) then 
							mat.text = string.sub(mat.text,1,-2) 
							result = mat[i][j][pan].t
						else result = mat[i][j][pan].t end
					end
					mat[i][j][pan].app = true
					Canvas.setAttr(mat[i][j][pan].canvFond, ATTR_COLOR, mat[i][j][pan].cs)
					local obj = {}
					obj.obj = mat[i][j][pan].canvFond
					obj.color = mat[i][j][pan].cf
					obj.time = mat.timer:getTime() + 200
					table.insert(mat.tabTApp, obj)
				end
			end
		end
	end
	return result
end
