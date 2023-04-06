--[[ Library gathering functions to create
    and manage GUI ]]

V_LUAWIDGET = 0.522
	 
luaWidget = {}
luaWidget.tabobj = {}
luaWidget.tabwidget = {}	-- Collections table
luaWidget.tabwidget.nb = 0	-- Objects table
TBUTTON = 1      -- Button type
TTEXTBOX = 2     -- Textbox type
TCHECKBOX = 3    -- CheckBox type
TRADIOBUTTON = 4 -- RadioButton type
TLINK = 5   	  -- Link type
TNUMUPDOWN = 6   -- NumericUpDown type
TPROGRESSBAR = 7 -- ProgressBar type
TLISTVIEW = 8	  -- List type
TTABLEVIEW = 9	  -- TableView type
TCOMBOBOX = 10	  -- ComboBox type

_ALEFT = 1   -- Left alignment
_ARIGHT = 2  -- Right alignment
_ACENTER = 3 -- Centre alignment
_ATRONQ = 4  -- Left alignment + truncation of sentences

_BSTART = 1
_BSELECT = 2
_BA = 3
_BB = 4
_BX = 5
_BY = 6

luaWidget.newWidget = function(scr)
	luaWidget.tabwidget.nb = luaWidget.tabwidget.nb +1
	luaWidget.tabobj[luaWidget.tabwidget.nb] = {}
	luaWidget.tabwidget[luaWidget.tabwidget.nb] = {}
	luaWidget.tabwidget[luaWidget.tabwidget.nb].scr = scr
	return luaWidget.tabwidget.nb
end

luaWidget.widgetHide = function(widget,hide)
	local show = not hide
	local obj, i
	for i, obj in pairs(luaWidget.tabobj[widget]) do
		obj.visible = show
	end
end

luaWidget.changeScreen = function(widget, scr)
	luaWidget.tabwidget[widget].scr = scr
end

luaWidget.newObj = function (parent, typeobj, x, y, width, height, opt1, opt2, opt3, opt4)
	local obj = {}
	local i
	obj.type = typeobj
	obj.parent = parent
	obj.x = x
	obj.y = y
	obj.width = width
	obj.height = height
	obj.text = ""
	obj.element = {}
	obj.image = 0
	obj.min = 0
	obj.max = 0
	obj.pos = 0
	obj.inc = 1
	obj.cFond = Color.new(31,31,31)
	obj.cCadre = Color.new(0,0,0)
	obj.cText = obj.cCadre
	obj.cFleche = obj.cCadre
	obj.cSel = Color.new(15,15,31)
	obj.cTextSel = Color.new(27,27,27)
	obj.visible = true
	obj.active = true
	obj.check = false
	obj.newPress = false
	obj.doubleClick = false
	obj.align = _ALEFT
	obj.num = #luaWidget.tabobj[parent] + 1
--****************************** OPTIONS **********************
--****************************** BUTTON ***********************
	if(obj.type == TBUTTON) then
		obj.cCadre = Color.new(31,31,31)
		obj.cFond = Color.new(20,20,20)
		obj.cText = Color.new(31,31,31)
		if(opt1 ~= nil) then obj.text = opt1 end
		if(opt2 ~= nil) then obj.align = opt2 end
		if(opt3 ~= nil) then obj.min = opt3 end
		if(opt4 ~= nil) then obj.image = Image.load(opt4,VRAM) end		
--****************************** TEXTBOX ***********************
	elseif(obj.type == TTEXTBOX) then
		if(opt1 ~= nil) then obj.text = opt1 end
		if(opt2 ~= nil) then obj.align = opt2 end
		if(opt3 ~= nil) then
			if(opt3) then
			-- Calcul du nombre de ligne affichable
				obj.max = math.floor((obj.height-4)/10)
			end
		end
--****************************** LINK ***********************
	elseif(obj.type == TLINK) then
		if(opt1 ~= nil) then obj.text = opt1 end
		obj.cText = Color.new(3,0,30)
		obj.width = string.len(obj.text)*6
		obj.height = 9
--****************************** RADIOBUTTON ***********************
	elseif(obj.type == TRADIOBUTTON) then
		if(opt1 ~= nil) then
			for i=1,#opt1 do
				local buff = {}
				buff.text = opt1[i]
				buff.check = false
				table.insert(obj.element,buff)
				obj.height = #obj.element * 11
			end
		end
		if(opt2 ~= nil) then obj.align = opt2 end
--****************************** CHECKBOX ***********************
	elseif(obj.type == TCHECKBOX) then
		obj.cSel = Color.new(0,0,0)
		if(opt1 ~= nil) then obj.text = opt1 end
		if(opt2 ~= nil) then obj.align = opt2 end
--****************************** NUMERIC UP/DOWN ***********************
	elseif(obj.type == TNUMUPDOWN) then
		obj.width = 10
		obj.height = 20
		if(opt1 ~= nil) then obj.min = opt1 end
		if(opt2 ~= nil) then obj.max = opt2 end
		if(opt3 ~= nil) then obj.pos = opt3 end
--****************************** PROGRESSBAR ***********************
	elseif(obj.type == TPROGRESSBAR) then
		if(opt1 ~= nil) then obj.text = opt1 end
		if(opt2 ~= nil) then obj.max = opt2 end
--****************************** LISTVIEW ***********************
	elseif(obj.type == TLISTVIEW) then
		if(opt1 ~= nil) then
			for i=1,#opt1 do
				local buff = {}
					buff.text = opt1[i]
					table.insert(obj.element,buff)
			end
			obj.max = #obj.element
			obj.pos = 1
		end
		obj.min = 1
--****************************** COMBOBOX ***********************
	elseif(obj.type == TCOMBOBOX) then
		local xx,yy,wd,hg
		if(obj.height > 96) then obj.height = 90 end
		if(obj.height+obj.y > 192) then
			xx = obj.x
			yy = obj.y-(obj.height-11)
			wd = obj.width
			hg = obj.height-10
			obj.height = 11
			table.insert(luaWidget.tabobj[parent],obj)
			obj.min = luaWidget.newObj(parent,TLISTVIEW,xx,yy,wd,hg,opt1)
		else
			xx = obj.x
			yy = obj.y+11
			wd = obj.width
			hg = obj.height-11
			obj.height = 11
			table.insert(luaWidget.tabobj[parent],obj)
			obj.min = luaWidget.newObj(parent,TLISTVIEW,xx,yy,wd,hg,opt1)
		end
		luaWidget.set(obj.parent,obj.min,"visible",false)
--****************************** TABLEVIEW ***********************
	elseif(obj.type == TTABLEVIEW) then
		local i
		obj.pos = 0
		if(opt1 ~= nil) then
			if(opt1[0] ~= nil) then
				for i =0, #opt1 do
					table.insert(obj.element,opt1[i])
				end
			else
				obj.element = opt1
			end
			local tab = {}
			local taillecol = math.floor((obj.width -10) / #obj.element[1])
			for i = 1, #obj.element[1] do
				table.insert(tab, taillecol)
			end
			obj.element[0] = tab
			obj.max = #obj.element -1
			obj.pos = 1
		end
		if(opt2 ~= nil) then
			obj.element[0] = opt2
		end
	end
	if(obj.type ~= TCOMBOBOX) then table.insert(luaWidget.tabobj[parent],obj) end
	return obj.num
end

luaWidget.del = function(parent, objet)
	local i,j
	if(parent ~= nil) then
		if(objet ~=nil) then
			luaWidget.tabobj[parent][objet].type = 0
			luaWidget.tabobj[parent][objet].element = 0
			if(luaWidget.tabobj[parent][objet].image ~= 0) then Image.destroy(luaWidget.tabobj[parent][objet].image) end
		else
			luaWidget.tabobj[parent] = nil
		end
	else
		-- tabobj = nil
		TBUTTON = nil
		TTEXTBOX = nil
		TCHECKBOX = nil
		TRADIOBUTTON = nil
		TLINK = nil
		TNUMUPDOWN = nil
		TLISTVIEW = nil
		TPROGRESSBAR = nil
		TTABLEVIEW = nil
		TCOMBOBOX = nil
		_ALEFT = nil
		_ARIGHT = nil
		_ACENTER = nil
		_BSTART = nil
		_BSELECT = nil
		_BA = nil
		_BB = nil
		_BX = nil
		_BY = nil
		V_LIBGUI = nil
		if(#luaWidget.tabobj > 0) then
			for i = 1, #luaWidget.tabobj do
				for j =1,#luaWidget.tabobj[i] do
					luaWidget.del(luaWidget.tabobj[i][j])
				end
			end
		end
		luaWidget = nil
	end
end

luaWidget.set = function(parent, obj, opt, value)
	local i
	if(luaWidget.tabobj[parent][obj][opt] ~= nil or opt == "multiline" or opt == "dimcol") then
--******************** IMAGE ********************
		if(opt == "image") then
			if(luaWidget.tabobj[parent][obj].image ~=0) then
				Image.destroy(luaWidget.tabobj[parent][obj].image)
				luaWidget.tabobj[parent][obj][opt] = Image.load(value,VRAM)
			else luaWidget.tabobj[parent][obj][opt] = Image.load(value,VRAM) end
--******************** ELEMENT ********************
		elseif(opt == "element") then
--******************** ELEMENT for COMBOBOX ********************
			if(luaWidget.tabobj[parent][obj].type == TCOMBOBOX) then
				luaWidget.set(parent,luaWidget.tabobj[parent][obj].min,"element",value)
			end
			for i=1,#luaWidget.tabobj[parent][obj].element do
				table.remove(luaWidget.tabobj[parent][obj].element)
			end
			for i=1,#value do
				local buff = {}
--******************** ELEMENT for RADIOBUTTON ********************
				if(luaWidget.tabobj[parent][obj].type == TRADIOBUTTON) then
					buff.text = value[i]
					buff.check = false
					table.insert(luaWidget.tabobj[parent][obj].element,buff)
					luaWidget.tabobj[parent][obj].height = #luaWidget.tabobj[parent][obj].element * 11
--******************** ELEMENT for LISTVIEW ********************
				elseif(luaWidget.tabobj[parent][obj].type == TLISTVIEW) then
					buff.text = value[i]
					table.insert(luaWidget.tabobj[parent][obj].element,buff)
--******************** ELEMENT for TABLEVIEW ********************
				elseif(luaWidget.tabobj[parent][obj].type == TTABLEVIEW) then
					table.insert(luaWidget.tabobj[parent][obj].element,value[i])
				end
			end
			--******************** LISTVIEW ********************
			if(luaWidget.tabobj[parent][obj].type == TLISTVIEW) then 
				luaWidget.tabobj[parent][obj].max = #luaWidget.tabobj[parent][obj].element
				luaWidget.tabobj[parent][obj].pos = 1
			--******************** TABLEVIEW ********************
			elseif(luaWidget.tabobj[parent][obj].type == TTABLEVIEW) then
				local tab = {}
				local i
				local taillecol = math.floor((luaWidget.tabobj[parent][obj].width -10) / #luaWidget.tabobj[parent][obj].element[1])
				for i = 1, #luaWidget.tabobj[parent][obj].element[1] do
					table.insert(tab, taillecol)
				end
				luaWidget.tabobj[parent][obj].element[0] = tab
				luaWidget.tabobj[parent][obj].max = #luaWidget.tabobj[parent][obj].element -1
				luaWidget.tabobj[parent][obj].pos = 1
			end
--******************** MIN ********************
		elseif(opt == "min") then
			luaWidget.tabobj[parent][obj].min = value
			if(luaWidget.tabobj[parent][obj].pos < value) then luaWidget.tabobj[parent][obj].pos = value end
--******************** MAX ********************
		elseif(opt == "max") then
			luaWidget.tabobj[parent][obj].max = value
			if(luaWidget.tabobj[parent][obj].pos > value) then luaWidget.tabobj[parent][obj].pos = value end
--******************** POS ********************
		elseif(opt == "pos") then
			if(value > luaWidget.tabobj[parent][obj].max) then value = luaWidget.tabobj[parent][obj].max end
			if(value < luaWidget.tabobj[parent][obj].min) then value = luaWidget.tabobj[parent][obj].min end
			luaWidget.tabobj[parent][obj].pos = value
--******************** MULTILINE ********************
		elseif(opt == "multiline" and luaWidget.tabobj[parent][obj].type == TTEXTBOX) then
			if(value) then
				luaWidget.tabobj[parent][obj].max = math.floor((luaWidget.tabobj[parent][obj].height-4)/10)
			else
				luaWidget.tabobj[parent][obj].max = 0
			end
--******************** HEIGHT AND TYPE= TTEXTBOX ********************
		elseif(opt == "height" and luaWidget.tabobj[parent][obj].type == TTEXTBOX) then
			if(luaWidget.tabobj[parent][obj].max > 0) then
				luaWidget.tabobj[parent][obj].max = math.floor((value-4)/10)
			end
--******************** DIMCOL (column dimensions) ********************
		elseif(opt == "dimcol") then
			luaWidget.tabobj[parent][obj].element[0] = value
--******************** Everything else ********************
		else
			luaWidget.tabobj[parent][obj][opt] = value
		end
		if(luaWidget.tabobj[parent][obj].type == TLINK and opt == "text") then
			luaWidget.tabobj[parent][obj].width = string.len(luaWidget.tabobj[parent][obj].text)*6
		end
	end
end

luaWidget.get = function(parent, obj, opt)
	if(opt == "multiline" and luaWidget.tabobj[parent][obj].type == TTEXTBOX) then
		if(luaWidget.tabobj[parent][obj].max > 0) then return true
		else return false end
	elseif(opt == "dimcol" and luaWidget.tabobj[parent][obj].type == TTABLEVIEW) then
		return luaWidget.tabobj[parent][obj].element[0]
	else
		return luaWidget.tabobj[parent][obj][opt]
	end
end

luaWidget.assocButton = function(parent, obj,bouton)
	if(luaWidget.tabobj[parent][obj].type == TBUTTON) then 
		luaWidget.tabobj[parent][obj].min = bouton
	end
end

luaWidget.move = function(parent, obj, x, y)
	if(x+luaWidget.tabobj[parent][obj].width > 256) then x = 256-luaWidget.tabobj[parent][obj].width end
	if(y+luaWidget.tabobj[parent][obj].height > 192) then y = 192-luaWidget.tabobj[parent][obj].height end
	if(x<0) then x = 0 end
	if(y<0) then y = 0 end
	luaWidget.tabobj[parent][obj].x = x
	luaWidget.tabobj[parent][obj].y = y
end

luaWidget.getSel = function(parent, obj)
	local i, result = 0,0
--******************** RADIOBUTTON ********************
	if(luaWidget.tabobj[parent][obj].type == TRADIOBUTTON) then
		for i=1,#luaWidget.tabobj[parent][obj].element do
			if(luaWidget.tabobj[parent][obj].element[i].check) then result = luaWidget.tabobj[parent][obj].element[i].text end
		end
--******************** LISTVIEW ********************
	elseif(luaWidget.tabobj[parent][obj].type == TLISTVIEW) then
		result = luaWidget.tabobj[parent][obj].element[luaWidget.tabobj[parent][obj].pos].text
--********************** COMBOBOX *********************
	elseif(luaWidget.tabobj[parent][obj].type == TCOMBOBOX) then
		result = luaWidget.get(parent,obj,"text")
	end
	return result
end

luaWidget.setSel = function(parent, obj, sel)
	local i
--********************** RADIOBUTTON *********************
	if(luaWidget.tabobj[parent][obj].type == TRADIOBUTTON) then
		if(type(sel) == "number") then
			if(luaWidget.tabobj[parent][obj].element[sel] ~= nil) then
				for i= 1, #luaWidget.tabobj[parent][obj].element do
					luaWidget.tabobj[parent][obj].element[i].check = false
				end	
				luaWidget.tabobj[parent][obj].element[sel].check = true 
			end
		else
			for i= 1, #luaWidget.tabobj[parent][obj].element do
				luaWidget.tabobj[parent][obj].element[i].check = false
				if(luaWidget.tabobj[parent][obj].element[i].text == sel) then luaWidget.tabobj[parent][obj].element[i].check = true end
			end
		end
--********************** LISTVIEW *********************
	elseif(luaWidget.tabobj[parent][obj].type == TLISTVIEW) then
		if(sel < 1) then sel = 1 end
		if(sel > #luaWidget.tabobj[parent][obj].element) then sel = #luaWidget.tabobj[parent][sel].element end
		luaWidget.tabobj[parent][obj].pos = sel
--********************** COMBOBOX *********************
	elseif(luaWidget.tabobj[parent][obj].type == TCOMBOBOX) then
		luaWidget.setSel(parent,luaWidget.tabobj[parent][obj].min,sel)
		luaWidget.set(parent,obj,"text",luaWidget.getSel(parent,luaWidget.tabobj[parent][obj].min))
	end
end

luaWidget.addElement = function(parent,obj,element)
--********************* LISTVIEW **********************
	if(luaWidget.tabobj[parent][obj].type == TLISTVIEW) then
		local buff = {}
		buff.text = element
		table.insert(luaWidget.tabobj[parent][obj].element,buff)
		luaWidget.tabobj[parent][obj].max = luaWidget.tabobj[parent][obj].max+1
	end
--********************* TABLEVIEW **********************
	if(luaWidget.tabobj[parent][obj].type == TTABLEVIEW) then
		table.insert(luaWidget.tabobj[parent][obj].element,element)
		luaWidget.tabobj[parent][obj].max = #luaWidget.tabobj[parent][obj].element -1
		luaWidget.tabobj[parent][obj].pos = #luaWidget.tabobj[parent][obj].element -1
	end
end

luaWidget.show = function(widget)
	local obj, a
	local scr = luaWidget.tabwidget[widget].scr
	local ombre = Color.new(10,10,10)
	for a, obj in pairs(luaWidget.tabobj[widget]) do
		if(obj.visible) then
-- ************** BUTTON *****************
			if(obj.type == TBUTTON) then
				local add, xx, yy, ximg, wimg
				local bout = ""
				if(obj.min == _BSTART) then bout = "START"
				elseif(obj.min == _BSELECT) then bout = "SELECT"
				elseif(obj.min == _BA) then bout = "A"
				elseif(obj.min == _BB) then bout = "B"
				elseif(obj.min == _BX) then bout = "X"
				elseif(obj.min == _BY) then bout = "Y"
				end
				if(obj.width > obj.height) then wimg = obj.height-6 else wimg = obj.width-6 end
				if(obj.image ~= 0) then Image.scale(obj.image, wimg, wimg) end
				screen.drawFillRect(scr, obj.x, obj.y, obj.x+obj.width, obj.y+obj.height, obj.cFond)
				if obj.check then add = 1 else add = 0 end
				screen.drawRect(scr, obj.x-add, obj.y-add, obj.x+obj.width-add, obj.y+obj.height-add, obj.cCadre)
				screen.drawRect(scr, obj.x-1, obj.y-1, obj.x+obj.width, obj.y+obj.height, ombre)
				local buff = string.gsub(obj.text,"%%B",bout)
				buff = string.sub(buff,1,(obj.width-6)/6)
				if (obj.align == _ACENTER) then
					xx = math.floor(obj.width/2)-(string.len(buff)*3)+obj.x
					if(obj.image ~= 0) then 
						ximg  = math.floor(obj.width/2)-(wimg/2)+obj.x
					end
				elseif (obj.align == _ARIGHT) then
					xx = obj.x+ obj.width -(string.len(buff)*6)-6
					if(obj.image ~= 0) then ximg  = obj.x+4 end
				else 
					xx = obj.x+4
					if(obj.image ~= 0) then ximg  = obj.width + obj.x - wimg -4 end
				end
				yy = obj.y+math.floor((obj.height/2)-4.5)+1
				if(obj.image ~= 0) then screen.blit(scr, ximg+add, obj.y+3+add, obj.image) end
				screen.print(scr,xx+1+add,yy+1+add,buff,ombre)
				screen.print(scr,xx+add,yy+add,buff,obj.cText)
-- ************** TEXTBOX *****************
			elseif(obj.type == TTEXTBOX) then
				screen.drawFillRect(scr, obj.x, obj.y, obj.x+obj.width, obj.y+obj.height, obj.cFond)
				screen.drawRect(scr, obj.x, obj.y, obj.x+obj.width, obj.y+obj.height, obj.cCadre)
				local buff = {}
				local posx = obj.x+2
				local posy = obj.y+math.floor((obj.height/2)-4.5)+1
				if(obj.max > 0) then posy = obj.y+math.floor((obj.height/2)-(5*obj.max))+1 end
				local maxcavi = (obj.width-6)/6
				if(obj.max == 0) then
					if string.len(obj.text) > maxcavi then 
						local buft = string.sub(obj.text,0,maxcavi)
						local w=0
						local ww
						while w~= nil do
							ww = w
							w = string.find(buft, "%s",w+1)
						end
						buft = string.sub(buft,0,ww-1)
						table.insert(buff,buft)
					else table.insert(buff,obj.text) end
				else
					if string.len(obj.text) > maxcavi then 
						local buft = string.sub(obj.text,0,maxcavi)
						local w=0
						local ww, i, dep
						for i = 1, obj.max do
							while w~= nil do
								ww = w
								w = string.find(buft, "%s",w+1)
							end
							table.insert(buff,string.sub(buft,0,ww-1))
							dep = ww+1
							buft = string.sub(obj.text,dep,dep+maxcavi)
						end
					else table.insert(buff,obj.text) end
				end
				local i
				for i= 1, #buff do
					if obj.align == _ARIGHT then
						posx = (obj.x+obj.width)-3-(string.len(buff[i])*6)
					elseif obj.align == _ACENTER then
						posx = (math.floor(obj.width/2)-(string.len(buff[i])*3))+obj.x
					elseif obj.align == _ATRONQ and obj.max < 1 then
						local maxcara = math.floor((obj.width-4)/6)
						local deb = math.floor(maxcara/3)
						if(deb<1) then deb = 1 end
						local dep = deb+3-maxcara
						if(string.len(obj.text) > maxcara) then
							buff[i] = string.sub(obj.text,1,deb).."..."..string.sub(obj.text,dep)
						end
					end
					screen.print(scr,posx,posy+((i-1)*10),buff[i],obj.cText)
				end
-- ************** CHECKBOX *****************
			elseif(obj.type == TCHECKBOX) then
				local xx = obj.x
				local yy = obj.y
				if (obj.align == _ARIGHT) then xx = obj.x+(string.len(obj.text)*6)+4 end
				screen.drawFillRect(scr,xx,yy,xx+10,yy+10, obj.cFond)
				screen.drawRect(scr, xx+1, yy+1, xx+11, yy+11, ombre)
				screen.drawRect(scr, xx, yy, xx+10, yy+10, obj.cCadre)
				if (obj.align == _ARIGHT) then
					screen.print(scr, obj.x, obj.y+2, obj.text, obj.cText)
				else
					screen.print(scr, obj.x+14, obj.y+2, obj.text, obj.cText)
				end
				if obj.check then
					screen.drawLine(scr, xx+2, yy+3, xx+8, yy+9, obj.cSel)
					screen.drawLine(scr, xx+8, yy+3, xx+2, yy+9, obj.cSel)
					screen.drawLine(scr, xx+2, yy+2, xx+8, yy+8, obj.cSel)
					screen.drawLine(scr, xx+8, yy+2, xx+2, yy+8, obj.cSel)
				end
-- ************** RADIOBUTTON *****************
			elseif(obj.type == TRADIOBUTTON) then
				local xx = obj.x
				local yy 
				local i, j
				for i=1,#obj.element do
					yy = obj.y+((i-1)*11)
					if (obj.align == _ARIGHT) then xx = obj.x+obj.width-10 end
					-- Circle contour
					screen.drawLine(scr,xx+3,yy,xx+7,yy,obj.cCadre)
					screen.drawLine(scr,xx+2,yy+1,xx+8,yy+1,obj.cCadre)
					screen.drawLine(scr,xx+1,yy+2,xx+9,yy+2,obj.cCadre)
					for j=3,6 do
					screen.drawLine(scr,xx,yy+j,xx+10,yy+j,obj.cCadre)
					end
					screen.drawLine(scr,xx+1,yy+7,xx+9,yy+7,obj.cCadre)
					screen.drawLine(scr,xx+2,yy+8,xx+8,yy+8,obj.cCadre)
					screen.drawLine(scr,xx+3,yy+9,xx+7,yy+9,obj.cCadre)
					-- Circle filling
					screen.drawLine(scr,xx+3,yy+1,xx+7,yy+1,obj.cFond)
					screen.drawLine(scr,xx+2,yy+2,xx+8,yy+2,obj.cFond)
					screen.drawLine(scr,xx+1,yy+3,xx+9,yy+3,obj.cFond)
					screen.drawLine(scr,xx+1,yy+4,xx+9,yy+4,obj.cFond)
					screen.drawLine(scr,xx+1,yy+5,xx+9,yy+5,obj.cFond)
					screen.drawLine(scr,xx+1,yy+6,xx+9,yy+6,obj.cFond)
					screen.drawLine(scr,xx+2,yy+7,xx+8,yy+7,obj.cFond)
					screen.drawLine(scr,xx+3,yy+8,xx+7,yy+8,obj.cFond)
					-- Check
					if obj.element[i].check then
						screen.drawLine(scr,xx+4,yy+2,xx+6,yy+2,obj.cSel)
						screen.drawLine(scr,xx+3,yy+3,xx+7,yy+3,obj.cSel)
						screen.drawLine(scr,xx+2,yy+4,xx+8,yy+4,obj.cSel)
						screen.drawLine(scr,xx+2,yy+5,xx+8,yy+5,obj.cSel)
						screen.drawLine(scr,xx+3,yy+6,xx+7,yy+6,obj.cSel)
						screen.drawLine(scr,xx+4,yy+7,xx+6,yy+7,obj.cSel)				
					end
					-- Text
					if (obj.align == _ARIGHT) then
						xx = (obj.x+obj.width)-((string.len(obj.element[i].text)*6)+14)
						screen.print(scr, xx, yy+1, obj.element[i].text, obj.cText)
					else
						screen.print(scr, obj.x+14, yy+1, obj.element[i].text, obj.cText)
					end
				end
-- ************** LINK LABEL *****************
			elseif(obj.type == TLINK) then
				local color = obj.cText
				if obj.check then color = obj.cTextSel end
				screen.print(scr, obj.x, obj.y,obj.text, color)
				screen.drawLine(scr, obj.x, obj.y+8, obj.x+(string.len(obj.text)*6)+2, obj.y+8, color)
-- ************** NUMERIC UP/DOWN *****************
			elseif(obj.type == TNUMUPDOWN) then
				screen.drawFillRect(scr,obj.x,obj.y,obj.x+10,obj.y+20,obj.cFond)
				screen.drawRect(scr,obj.x,obj.y,obj.x+10,obj.y+10,obj.cCadre)
				screen.drawRect(scr,obj.x,obj.y+10,obj.x+10,obj.y+20,obj.cCadre)
				-- Up arrow
				screen.drawLine(scr,obj.x+4,obj.y+2,obj.x+4,obj.y+8,obj.cFleche)
				screen.drawLine(scr,obj.x+5,obj.y+2,obj.x+5,obj.y+8,obj.cFleche)
				screen.drawLine(scr,obj.x+3,obj.y+3,obj.x+7,obj.y+3,obj.cFleche)
				screen.drawLine(scr,obj.x+2,obj.y+4,obj.x+8,obj.y+4,obj.cFleche)
				-- Down arrow
				screen.drawLine(scr,obj.x+4,obj.y+12,obj.x+4,obj.y+18,obj.cFleche)
				screen.drawLine(scr,obj.x+5,obj.y+12,obj.x+5,obj.y+18,obj.cFleche)
				screen.drawLine(scr,obj.x+3,obj.y+16,obj.x+7,obj.y+16,obj.cFleche)
				screen.drawLine(scr,obj.x+2,obj.y+15,obj.x+8,obj.y+15,obj.cFleche)
-- ************** PROGRESSBAR *****************
			elseif(obj.type == TPROGRESSBAR) then
				local pourcent = math.floor((obj.pos*100)/obj.max)
				local buff
				local xx, yy
				screen.drawFillRect(scr,obj.x,obj.y,obj.x+obj.width,obj.y+obj.height,obj.cFond)
				screen.drawRect(scr,obj.x,obj.y,obj.x+obj.width,obj.y+obj.height,obj.cCadre)
				--HORIZONTAL
				if obj.pos>0 then
					xx = (obj.pos*(obj.width-1))/obj.max
					screen.drawFillRect(scr,obj.x+1,obj.y+1,obj.x+xx,obj.y+obj.height-1,obj.cSel)
				end
				buff = string.gsub(obj.text, "%%P", pourcent)
				buff = string.gsub(buff, "%%p", obj.pos)
				buff = string.gsub(buff, "%%m", obj.max)
				buff = string.sub(buff,0,(obj.width-4)/6)
				xx = (obj.width/2) - (string.len(buff)*3) + obj.x
				yy = (obj.height/2) - 3 + obj.y
				screen.print(scr,xx,yy,buff,obj.cText)
-- ************** LISTVIEW ********************
			elseif(obj.type == TLISTVIEW) then
				local xx1 = obj.x
				local xx2 = obj.x+obj.width
				local yy1 = obj.y
				local yy2 = obj.y+obj.height
				local adx = 0
				local i, texte, posSel, ldep, lfin
				local nbelem = table.maxn(obj.element)
				local nbliaff = math.floor((obj.height - 2)/10)
				screen.drawFillRect(scr, xx1, yy1, xx2, yy2, obj.cFond)
				screen.drawRect(scr, xx1, yy1, xx2, yy2, obj.cCadre)
				posSel = obj.pos
				ldep = posSel - math.floor(nbliaff/2)
				if ldep <1 then ldep = 1 end
				lfin = ldep + nbliaff-1
				if lfin > nbelem then lfin = nbelem end
				if (lfin-ldep)<(nbliaff-1) then ldep = lfin-nbliaff+1 end
				if ldep <1 then ldep = 1 end
				if(obj.image ~= 0) then adx = 14 else adx = 2 end
				for i=ldep, lfin do
					texte = string.sub(obj.element[i].text,0,(xx2-xx1-13-adx)/6)
					if i == posSel then
						screen.drawFillRect(scr,xx1+1,yy1+1+((i-ldep)*10),xx2-10,yy1+11+((i-ldep)*10),obj.cSel)
						screen.print(scr,xx1+adx,yy1+2+((i-ldep)*10),texte,obj.cTextSel)
					else
						screen.print(scr,xx1+adx,yy1+2+((i-ldep)*10),texte,obj.cText)
					end
					if (obj.image ~= 0 and obj.element[i].img > 0) then
						screen.blit(scr,xx1+2,yy1+1+((i-ldep)*10),obj.image,1+(obj.element[i].img-1)*10,1,10,10)
					end
				end
				xx1 = xx2-10
				-- Up arrow
				screen.drawLine(scr,xx1+4,yy1+2,xx1+4,yy1+8,obj.cFleche)
				screen.drawLine(scr,xx1+5,yy1+2,xx1+5,yy1+8,obj.cFleche)
				screen.drawLine(scr,xx1+3,yy1+3,xx1+7,yy1+3,obj.cFleche)
				screen.drawLine(scr,xx1+2,yy1+4,xx1+8,yy1+4,obj.cFleche)
				-- Down arrow
				screen.drawLine(scr,xx1+4,yy2-2,xx1+4,yy2-8,obj.cFleche)
				screen.drawLine(scr,xx1+5,yy2-2,xx1+5,yy2-8,obj.cFleche)
				screen.drawLine(scr,xx1+3,yy2-4,xx1+7,yy2-4,obj.cFleche)
				screen.drawLine(scr,xx1+2,yy2-5,xx1+8,yy2-5,obj.cFleche)
				-- Cursor
				if obj.max > 0 then
					ep_curs = ((yy2-10)-(yy1+10))/obj.max
					po_curs = math.floor(ep_curs*(obj.pos-1))+10+yy1
					ep_curs = math.floor(ep_curs)
					if ep_curs == 0 then ep_curs = 1 end
					screen.drawFillRect(scr,xx1+1,po_curs,xx1+9,po_curs+ep_curs,obj.cSel)
				end
				-- Arrow frame
				screen.drawLine(scr,xx1,yy1+9,xx1+10,yy1+9,obj.cCadre)
				screen.drawLine(scr,xx1,yy2-10,xx2,yy2-10,obj.cCadre)
				-- Frame
				screen.drawRect(scr,xx1,yy1,xx2,yy2,obj.cCadre)
-- **************TABLEVIEW ********************
			elseif(obj.type == TTABLEVIEW) then
				local xx1 = obj.x
				local xx2 = obj.x+obj.width
				local yy1 = obj.y
				local yy2 = obj.y+obj.height
				screen.drawFillRect(scr,xx1,yy1,xx2,yy2,obj.cFond)
				screen.drawRect(scr,xx1,yy1,xx2,yy2,obj.cCadre)
				screen.drawLine(scr,xx1,yy1+11,xx2,yy1+11,obj.cCadre)
				xx1 = xx2-10
				yy1 = yy1+11
				-- Up arrow
				screen.drawLine(scr,xx1+4,yy1+2,xx1+4,yy1+8,obj.cFleche)
				screen.drawLine(scr,xx1+5,yy1+2,xx1+5,yy1+8,obj.cFleche)
				screen.drawLine(scr,xx1+3,yy1+3,xx1+7,yy1+3,obj.cFleche)
				screen.drawLine(scr,xx1+2,yy1+4,xx1+8,yy1+4,obj.cFleche)
				-- Down arrow
				screen.drawLine(scr,xx1+4,yy2-2,xx1+4,yy2-8,obj.cFleche)
				screen.drawLine(scr,xx1+5,yy2-2,xx1+5,yy2-8,obj.cFleche)
				screen.drawLine(scr,xx1+3,yy2-4,xx1+7,yy2-4,obj.cFleche)
				screen.drawLine(scr,xx1+2,yy2-5,xx1+8,yy2-5,obj.cFleche)
				-- Cursor
				local nbliaff = math.floor((obj.height - 15)/10)
				if obj.max > 0 then
					ep_curs = ((yy2-10)-(yy1+10))/obj.max
					po_curs = math.floor(ep_curs*(obj.pos-1))+10+yy1
					ep_curs = math.floor(ep_curs)
					if ep_curs == 0 then ep_curs = 1 end
					screen.drawFillRect(scr,xx1+1,po_curs,xx1+9,po_curs+ep_curs,obj.cSel)
				end
				-- Arrow frame
				screen.drawLine(scr,xx1,yy1+9,xx1+10,yy1+9,obj.cCadre)
				screen.drawLine(scr,xx1,yy2-10,xx2,yy2-10,obj.cCadre)
				-- Frame
				screen.drawRect(scr,xx1,yy1,xx2,yy2,obj.cCadre)
				-- Column delimitation
				if(obj.element[0] ~= nil) then
					local i
					yy1 = obj.y
					xx1 = obj.x
					for i=1, (#obj.element[0]-1) do
						if(xx1 < xx2) then
							screen.drawLine(scr,xx1+obj.element[0][i],yy1,xx1+obj.element[0][i],yy2,obj.cCadre)
						end
						xx1 = xx1 + obj.element[0][i]
					end
				-- Text
					local j,text,cx
					local xnbelem = #obj.element[1]
				-- Title
					cx = obj.x
					for j=1, xnbelem do
						text = string.sub(obj.element[1][j],1,math.floor((obj.element[0][j]-4)/6))
						if(cx+(string.len(text)*6) < xx2) then
							screen.print(scr,cx+2,yy1+2,text,obj.cText)
						end
						cx = cx + obj.element[0][j]
					end
				-- Everything else
					yy1 = yy1+12
					local posSel, ldep, lfin
					local ynbelem = #obj.element
					posSel = obj.pos
					ldep = posSel - math.floor(nbliaff/2)
					if(ldep < 2) then ldep = 2 end
					lfin = ldep + nbliaff-1
					if lfin > ynbelem then lfin = ynbelem end
					if((lfin-ldep) < (nbliaff-1)) then ldep = lfin-nbliaff+1 end
					if(ldep < 2) then ldep = 2 end
					for i=ldep, lfin do
						cx = obj.x
						-- Selection
						if(i == posSel+1) then
							screen.drawFillRect(scr,cx+1,yy1+((i-ldep)*10),xx2-10,yy1+12+((i-ldep)*10),obj.cSel)
						end
						-- Text
						for j=1, xnbelem do
							text = string.sub(obj.element[i][j],1,math.floor((obj.element[0][j]-4)/6))
							if(cx+(string.len(text)*6) < xx2) then
								screen.print(scr,cx+2,yy1+2+((i-ldep)*10),text,obj.cText)
							end
							cx = cx + obj.element[0][j]
						end
					end
				end
-- ************** COMBOBOX ********************
			elseif(obj.type == TCOMBOBOX) then
				local xx = obj.x
				local yy = obj.y
				local buff = obj.text
				screen.drawFillRect(scr, xx, yy, xx+obj.width, yy+12, obj.cFond)
				screen.drawRect(scr, xx, yy, xx+obj.width, yy+12, obj.cCadre)
				screen.drawLine(scr, xx+obj.width-12, yy, xx+obj.width-12, yy+12, obj.cCadre)
				buff = string.sub(buff,1,(obj.width-18)/6)
				screen.print(scr,xx+2,yy+2,buff,obj.cText)
				xx = xx+obj.width-12
				screen.drawLine(scr, xx+2, yy+6, xx+10, yy+6, obj.cCadre)
				screen.drawLine(scr, xx+3, yy+7, xx+9, yy+7, obj.cCadre)
				screen.drawLine(scr, xx+4, yy+8, xx+8, yy+8, obj.cCadre)
				screen.drawLine(scr, xx+5, yy+9, xx+7, yy+9, obj.cCadre)
			end
		end
	end
end

luaWidget.held = function(widget)
	local obj, i, kre
	for i, obj in pairs(luaWidget.tabobj[widget]) do
		if(obj.visible and obj.active) then
--******************** Check buttons associated to keys ********************
			if(obj.type == TBUTTON) then
				local ok = false
				if(Keys.newPress.A and obj.min == _BA) then ok = true end
				if(Keys.newPress.B and obj.min == _BB) then ok = true end
				if(Keys.newPress.X and obj.min == _BX) then ok = true end
				if(Keys.newPress.Y and obj.min == _BY) then ok = true end
				if(Keys.newPress.Start and obj.min == _BSTART) then ok = true end
				if(Keys.newPress.Select and obj.min == _BSELECT) then ok = true end
				if(ok) then obj.check = not obj.check end
			end
			local kre = square(obj.x, obj.y, obj.x+obj.width, obj.y+obj.height)
			if estDedans(Stylus.X, Stylus.Y, kre) and (luaWidget.tabwidget[widget].scr == SCREEN_DOWN) then
-- ************** All simple-click objects ********************
				if(Stylus.newPress) then
					obj.newPress = true
					obj.check = not obj.check
-- ************** RADIOBUTTON ********************
					if(obj.type == TRADIOBUTTON) then
						local i,numelem
						for i=1,#obj.element do obj.element[i].check = false end
						numelem = math.floor((Stylus.Y-obj.y)/11)+1
						obj.element[numelem].check = true
-- ************** NUMUPDOWN ********************
					elseif(obj.type == TNUMUPDOWN) then
						if((Stylus.Y-obj.y)<10) then obj.pos = obj.pos+obj.inc
						else obj.pos = obj.pos-obj.inc end
						if(obj.pos < obj.min) then obj.pos = obj.min end
						if(obj.pos > obj.max) then obj.pos = obj.max end
-- ************** LISTVIEW ********************
					elseif(obj.type == TLISTVIEW) then
						if(Stylus.X < obj.x+obj.width-10) then
							local numelem = math.floor((Stylus.Y-obj.y)/10)
							local nbliaff = math.floor((obj.height - 2)/10)
							local ldep = obj.pos - math.floor(nbliaff/2)
							if ldep <1 then ldep = 1 end
							local lfin = ldep + nbliaff-1
							if lfin > obj.max then lfin = obj.max end
							if (lfin-ldep)<(nbliaff-1) then ldep = lfin-nbliaff+1 end
							if ldep <1 then ldep = 1 end
							numelem = numelem + ldep
							if(numelem <= obj.max) then obj.pos = numelem end
						else
							if(Stylus.Y < obj.y+10) then
								obj.pos = obj.pos-1
								if(obj.pos < 1) then obj.pos = 1 end
							elseif(Stylus.Y > obj.y+obj.height-10) then
								obj.pos = obj.pos+1
								if(obj.pos > obj.max) then obj.pos = obj.max end
							end
						end
-- ************** TABLEVIEW ********************
					elseif(obj.type == TTABLEVIEW) then
						local nblaff = math.floor((obj.height-15)/10)
						if(Stylus.X < obj.x+obj.width-10) then
							local numelem = math.floor((Stylus.Y-(obj.y+12))/10)
							local nbliaff = math.floor((obj.height - 2)/10)
							local ldep = obj.pos - math.floor(nbliaff/2)
							if ldep <1 then ldep = 1 end
							local lfin = ldep + nbliaff-1
							if lfin > obj.max then lfin = obj.max end
							if (lfin-ldep)<(nbliaff-1) then ldep = lfin-nbliaff+1 end
							if ldep <1 then ldep = 1 end
							numelem = numelem + ldep
							if(numelem <= obj.max and numelem > 0) then obj.pos = numelem end
						else
						-- if(Stylus.X > obj.x+obj.width-10) then
							if(Stylus.Y > obj.y+11 and Stylus.Y < obj.y+21) then
								obj.pos = obj.pos-1
								if(obj.pos < 1) then obj.pos = 1 end
							elseif(Stylus.Y > obj.y+obj.height-10) then
								obj.pos = obj.pos+1
								if(obj.pos > obj.max) then obj.pos = obj.max end
								-- if(obj.pos + (nblaff-1) > obj.max) then obj.pos = obj.max - (nblaff-1) end
								-- if(obj.pos < 1) then obj.pos = 1 end
							end
						end
-- ************** COMBOBOX ********************
					elseif(obj.type == TCOMBOBOX) then
						local ok = false
						if(obj.pos == 1) then 
							if(Stylus.X > obj.x+obj.width-12 and Stylus.Y > obj.y+obj.height-12)
							then ok = true end
						else
							if(Stylus.X > obj.x+obj.width-12 and Stylus.Y < obj.y +12)
							then ok = true end
						end
						if(ok) then 
							luaWidget.tabobj[widget][obj.min].visible = not luaWidget.tabobj[widget][obj.min].visible
							local i, ob
							for i, ob in pairs(luaWidget.tabobj[widget]) do
								if(ob.num ~= obj.num and ob.num ~= luaWidget.tabobj[widget][obj.min].num) then
									ob.active = not ob.active
								end
							end
						end
					end
--********************** Double-click ************************************
				elseif(Stylus.doubleClick) then
					if(obj.type == TLISTVIEW and Stylus.X > obj.x+obj.width-10) then
						-- Pas bon
					else
						obj.doubleClick = true
					end
--********************** Delta Y ************************************
				elseif(Stylus.deltaY ~= 0) then
					local tmp = math.floor(Stylus.deltaY/3)
					if(obj.type == TLISTVIEW and Stylus.X > obj.x+obj.width-10) then
						obj.pos = obj.pos+tmp
						if(obj.pos > obj.max) then obj.pos = obj.max end
						if(obj.pos < 1) then obj.pos = 1 end
					end
				else
					obj.newPress = false
				end
			end
			if(obj.type == TCOMBOBOX) then
				if(luaWidget.tabobj[widget][obj.min].doubleClick) then
					obj.text = luaWidget.getSel(widget,obj.min)
					luaWidget.tabobj[widget][obj.min].visible = false
					luaWidget.tabobj[widget][obj.min].doubleClick = false
					local i
					for i, ob in pairs(luaWidget.tabobj[widget]) do
						ob.active = true
					end
				end
			end
		end
	end
end

luaWidget.DblClk = function(widget)
	local obj, i, kre
	for i, obj in pairs(luaWidget.tabobj[widget]) do
		if(obj.visible and obj.active) then
			local kre = square(obj.x, obj.y, obj.x+obj.width, obj.y+obj.height)
			if estDedans(Stylus.X, Stylus.Y, kre) then
				if(obj.type == TLISTVIEW and Stylus.X > obj.x+obj.width-10) then
					-- Pas bon
				else
					obj.doubleClick = true
				end
			end
		end
	end
end
