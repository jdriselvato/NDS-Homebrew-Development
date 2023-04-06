shell = {}
shell.name = "Sarasvatï"
shell.editeur = {}
shell.editeur.chem = "/lua/scripts/Editeur/"
shell.readme = {}
shell.index = {}
shell.subMenu = false
shell.oldDir = ""
shell.co = Color.new(0,0,0)

shell.verif = function(first)
	if(first==nil) then first = false end
	local buff = luaWidget.getSel(Explore.explore,Explore.liste)
	local chemin
	if(string.sub(buff,1,1)=="[") then
		chemin = Explore.getDir()..luaWidget.get(Explore.explore,Explore.nom,"text").."/"
	else
		chemin = Explore.getDir()
	end
	if(first) then
		shell.editeur.exist = Explore.fExist(shell.editeur.chem.."index.lua")
	end
	shell.readme.exist = Explore.fExist(chemin.."README")
	shell.readme.file = chemin.."README"
	if(not shell.readme.exist) then
		shell.readme.exist = Explore.fExist(chemin.."README.txt")
		shell.readme.file = chemin.."README.txt"
	end
	shell.index.exist = Explore.fExist(chemin.."index.lua")
	shell.index.file = chemin.."index.lua"
end

shell.loadLibs = function()
	if(Explore == nil) then
		screen.print(SCREEN_UP,177,182,"Chargement...")
		render()
		dofile("/lua/libs/standard.lua")
		libs = loadLib({"luaWidget","popUp","libClavier","Explore"})
		Explore.new(Dir,true,nil,nil,nil,"/lua/libs/Explore.ini")
		Explore.index = false
		shell.logo = Image.load("/lua/libs/logo_shell.gif",VRAM)
		shell.icones = Image.load("/lua/libs/icones.gif",RAM)
	end
end

shell.unloadLibs = function()
	unloadLib(libs)
	libs = nil
	delStandard()
	Image.destroy(shell.icones)
	Image.destroy(shell.logo)
	collectgarbage("collect")
	screen.print(SCREEN_UP,177,182,"Chargement...")
	render()
end

shell.del = function()
	shell = nil
	package.loaded.shellFunc = nil
end

shell.init = function()
	Dir = "/lua/scripts"
	_VSHELL = 3.02
	shell.loadLibs()
end

shell.show = function()
	Explore.show()
	local buff
	screen.drawFillRect(SCREEN_UP,0,0,256,90,Color.new(31,31,31))
	screen.drawGradientRect(SCREEN_UP,0,90,256,192,Color.new(31,31,31),Color.new(31,31,31),Explore.ci,Explore.ci)
	screen.blit(SCREEN_UP,0,0,shell.logo)
	screen.print(SCREEN_UP,172,76,string.char(169).." RISIKE 2009",shell.co)
	screen.print(SCREEN_UP,82,96,"Microlua community 2009-2013",shell.co)
	buff = "Based on ".._VERSION
	screen.print(SCREEN_UP,250-(string.len(buff)*6),106,buff,shell.co)
	buff = ULUA_VERSION
	screen.print(SCREEN_UP,250-(string.len(buff)*6),66,buff,shell.co)
	screen.print(SCREEN_UP,104,130,os.date("%H:%M:%S"),shell.co)
	screen.print(SCREEN_UP,98,140,os.date("%d/%m/%Y"),shell.co)
	screen.print(SCREEN_UP,100,180,"shell v.".._VSHELL.." "..shell.name,shell.co)
	screen.blit(SCREEN_DOWN,231,0,shell.icones,240,0,25,25)
	screen.print(SCREEN_DOWN,242,6,"Y")
	if(shell.subMenu) then
		screen.drawRect(SCREEN_DOWN,0,60,256,132,Color.new(0,0,0))
		screen.drawFillRect(SCREEN_DOWN,0,61,256,131,Color.new(31,31,31))
		screen.drawFillRect(SCREEN_DOWN,0,65,256,127,Explore.ci)
		if(string.sub(luaWidget.get(Explore.explore,Explore.nom,"text"),-3) == "lua" or 
		  shell.index.exist) then
			screen.blit(SCREEN_DOWN,8,66,shell.icones,0,0,48,48)
			screen.print(SCREEN_DOWN,22,116,"[A]")
		end
		if(string.sub(luaWidget.getSel(Explore.explore,Explore.liste),1,1) == "[") then
			screen.blit(SCREEN_DOWN,72,66,shell.icones,192,0,48,48)
			screen.print(SCREEN_DOWN,86,116,"[B]")
		elseif(shell.editeur.exist) then
			screen.blit(SCREEN_DOWN,72,66,shell.icones,48,0,48,48)
			screen.print(SCREEN_DOWN,86,116,"[B]")
		end
		if(shell.readme.exist and shell.editeur.exist) then
			screen.blit(SCREEN_DOWN,136,66,shell.icones,96,0,48,48)
			screen.print(SCREEN_DOWN,150,116,"[X]")
		end
		screen.blit(SCREEN_DOWN,200,66,shell.icones,144,0,48,48)
		screen.print(SCREEN_DOWN,214,116,"[Y]")
	end
end

shell.execute = function(fichier)
	if(string.sub(string.lower(fichier),-3) == "lua") then
		shell.unloadLibs()
		dofile(fichier)
		Debug.clear()
		Debug.OFF()
		Wifi.stop()
		dofile("/lua/libs/shellFunc.lua")
		shell.loadLibs()
	end
end

shell.editFile = function(file)
	shell.unloadLibs()
	require("DBus")
	DBus.newMess("editFich",file,10)
	System.changeDirectory(shell.editeur.chem)
	dofile("index.lua")
	DBus.del()
	package.loaded.DBus = nil
	Debug.clear()
	Debug.OFF()
	Wifi.stop()
	dofile("/lua/libs/shellFunc.lua")
	shell.loadLibs()
end

shell.activeButton = function(active)
	if(active == nil) then active=true end
	luaWidget.set(Explore.explore,Explore.bOk,"active",active)
	luaWidget.set(Explore.explore,Explore.bNo,"active",active)
	luaWidget.set(Explore.menu,Explore.mbOptions,"active",active)
end

shell.held = function()
	if(shell.subMenu) then
		shell.touchY = false
		shell.touchX = false
		shell.touchA = false
		shell.touchB = false
		if(Stylus.newPress) then
			if(estDedans(Stylus.X,Stylus.Y,square(8,62,56,110))) then shell.touchA = true end
			if(estDedans(Stylus.X,Stylus.Y,square(72,62,120,110))) then shell.touchB = true end
			if(estDedans(Stylus.X,Stylus.Y,square(200,62,248,110))) then shell.touchY = true end
			if(estDedans(Stylus.X,Stylus.Y,square(136,62,184,110))) then shell.touchX = true end
		end
		if(Keys.newPress.Y or shell.touchY) then
			shell.subMenu = false
			shell.activeButton(true)
		elseif(Keys.newPress.A or shell.touchA) then
			if(shell.index.exist) then
				Dir = Explore.getDir()
				Explore.changeDir(luaWidget.get(Explore.explore,Explore.nom,"text"))
				shell.execute("index.lua")
			else
				Dir = Explore.getDir()
				shell.execute(luaWidget.get(Explore.explore,Explore.nom,"text"))
			end			
		elseif(Keys.newPress.B or shell.touchB) then
			local nom = luaWidget.get(Explore.explore,Explore.nom,"text")
			if(string.sub(luaWidget.getSel(Explore.explore,Explore.liste),1,1) == "[") then
				Explore.changeDir(nom)
				shell.oldDir = Explore.getDir()
				shell.subMenu = false
				shell.activeButton(true)
			elseif(shell.editeur.exist) then
				Dir = Explore.getDir()
				shell.editFile(Dir..nom)
			end
		elseif((Keys.newPress.X or shell.touchX) and shell.readme.exist and shell.editeur.exist) then
			Dir = Explore.getDir()
			shell.editFile(shell.readme.file)
		end
	else
		Explore.held()
		if(Explore.ok)then
			Dir = Explore.getDir()
			shell.execute(Explore.fich)
		elseif(Explore.no) then
			Explore.changeDir("..")
		end
		if(shell.oldDir ~= Explore.getDir()) then
			if(Explore.fExist("index.lua")) then
				Dir = Explore.getDir()
				shell.execute("index.lua")
				shell.oldDir = Dir
			else
				shell.oldDir = ""
			end
		end
		if(Keys.newPress.Y or (Stylus.newPress and estDedans(Stylus.X,Stylus.Y,square(231,0,256,25)))) then
			if(luaWidget.get(Explore.explore,Explore.bOk,"active"))then
				shell.subMenu = true
				shell.verif(true)
				shell.activeButton(false)
			end
		end
	end
end
