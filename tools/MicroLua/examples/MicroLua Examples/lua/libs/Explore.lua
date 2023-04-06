V_EXPLORE = 0.203

Explore = {}

--Création du clavier
Explore.clavier = libClavier.new()
libClavier.addKey(Explore.clavier,1,1,"Esc",1,-1,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,1,1,"Esc",1,-1,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,9,1,21,2,-2,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,9,1,21,2,-2,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,1,2,"1")
libClavier.addKey(Explore.clavier,1,2,"1")
libClavier.addKey(Explore.clavier,2,2,"2")
libClavier.addKey(Explore.clavier,2,2,"2")
libClavier.addKey(Explore.clavier,3,2,"3")
libClavier.addKey(Explore.clavier,3,2,"3")
libClavier.addKey(Explore.clavier,4,2,"4")
libClavier.addKey(Explore.clavier,4,2,"4")
libClavier.addKey(Explore.clavier,5,2,"5")
libClavier.addKey(Explore.clavier,5,2,"5")
libClavier.addKey(Explore.clavier,6,2,"6")
libClavier.addKey(Explore.clavier,6,2,"6")
libClavier.addKey(Explore.clavier,7,2,"7")
libClavier.addKey(Explore.clavier,7,2,"7")
libClavier.addKey(Explore.clavier,8,2,"8")
libClavier.addKey(Explore.clavier,8,2,"8")
libClavier.addKey(Explore.clavier,9,2,"9")
libClavier.addKey(Explore.clavier,9,2,"9")
libClavier.addKey(Explore.clavier,10,2,"0")
libClavier.addKey(Explore.clavier,10,2,"0")
libClavier.addKey(Explore.clavier,1,3,"a")
libClavier.addKey(Explore.clavier,1,3,"A")
libClavier.addKey(Explore.clavier,2,3,"z")
libClavier.addKey(Explore.clavier,2,3,"Z")
libClavier.addKey(Explore.clavier,3,3,"e")
libClavier.addKey(Explore.clavier,3,3,"E")
libClavier.addKey(Explore.clavier,4,3,"r")
libClavier.addKey(Explore.clavier,4,3,"R")
libClavier.addKey(Explore.clavier,5,3,"t")
libClavier.addKey(Explore.clavier,5,3,"T")
libClavier.addKey(Explore.clavier,6,3,"y")
libClavier.addKey(Explore.clavier,6,3,"Y")
libClavier.addKey(Explore.clavier,7,3,"u")
libClavier.addKey(Explore.clavier,7,3,"U")
libClavier.addKey(Explore.clavier,8,3,"i")
libClavier.addKey(Explore.clavier,8,3,"I")
libClavier.addKey(Explore.clavier,9,3,"o")
libClavier.addKey(Explore.clavier,9,3,"O")
libClavier.addKey(Explore.clavier,10,3,"p")
libClavier.addKey(Explore.clavier,10,3,"P")
libClavier.addKey(Explore.clavier,1,4,"q")
libClavier.addKey(Explore.clavier,1,4,"Q")
libClavier.addKey(Explore.clavier,2,4,"s")
libClavier.addKey(Explore.clavier,2,4,"S")
libClavier.addKey(Explore.clavier,3,4,"d")
libClavier.addKey(Explore.clavier,3,4,"D")
libClavier.addKey(Explore.clavier,4,4,"f")
libClavier.addKey(Explore.clavier,4,4,"F")
libClavier.addKey(Explore.clavier,5,4,"g")
libClavier.addKey(Explore.clavier,5,4,"G")
libClavier.addKey(Explore.clavier,6,4,"h")
libClavier.addKey(Explore.clavier,6,4,"H")
libClavier.addKey(Explore.clavier,7,4,"j")
libClavier.addKey(Explore.clavier,7,4,"J")
libClavier.addKey(Explore.clavier,8,4,"k")
libClavier.addKey(Explore.clavier,8,4,"K")
libClavier.addKey(Explore.clavier,9,4,"l")
libClavier.addKey(Explore.clavier,9,4,"L")
libClavier.addKey(Explore.clavier,10,4,"m")
libClavier.addKey(Explore.clavier,10,4,"M")
libClavier.addKey(Explore.clavier,2,5,"w")
libClavier.addKey(Explore.clavier,2,5,"W")
libClavier.addKey(Explore.clavier,3,5,"x")
libClavier.addKey(Explore.clavier,3,5,"X")
libClavier.addKey(Explore.clavier,4,5,"c")
libClavier.addKey(Explore.clavier,4,5,"C")
libClavier.addKey(Explore.clavier,5,5,"v")
libClavier.addKey(Explore.clavier,5,5,"V")
libClavier.addKey(Explore.clavier,6,5,"b")
libClavier.addKey(Explore.clavier,6,5,"B")
libClavier.addKey(Explore.clavier,7,5,"n")
libClavier.addKey(Explore.clavier,7,5,"N")
libClavier.addKey(Explore.clavier,8,5,"-")
libClavier.addKey(Explore.clavier,8,5,"-")
libClavier.addKey(Explore.clavier,9,5,".")
libClavier.addKey(Explore.clavier,9,5,".")
libClavier.addKey(Explore.clavier,10,5,"_")
libClavier.addKey(Explore.clavier,10,5,"_")
libClavier.addKey(Explore.clavier,1,6,"MAJ",1,2,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,1,6,"MIN",1,1,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,3,6,"Espace",5,-4)
libClavier.addKey(Explore.clavier,3,6,"Espace",5,-4)
libClavier.addKey(Explore.clavier,9,6,"Enter",2,-3,nil,coul.bleuf)
libClavier.addKey(Explore.clavier,9,6,"Enter",2,-3,nil,coul.bleuf)
libClavier.modScreen(Explore.clavier,2,1,7)
libClavier.activeScreen(Explore.clavier,true)

--Suite configuration*
Explore.couleur = {}
Explore.couleur[0] = Color.new(13,17,18)
Explore.couleur[1] = Color.new(20,12,8)
Explore.couleur[2] = Color.new(24,4,5)
Explore.couleur[3] = Color.new(29,19,30)
Explore.couleur[4] = Color.new(27,17,4)
Explore.couleur[5] = Color.new(29,26,9)
Explore.couleur[6] = Color.new(22,26,6)
Explore.couleur[7] = Color.new(16,24,4)
Explore.couleur[8] = Color.new(7,17,7)
Explore.couleur[9] = Color.new(17,27,21)
Explore.couleur[10] = Color.new(12,23,26)
Explore.couleur[11] = Color.new(7,15,26)
Explore.couleur[12] = Color.new(10,8,25)
Explore.couleur[13] = Color.new(18,10,26)
Explore.couleur[14] = Color.new(24,11,26)
Explore.couleur[15] = Color.new(26,11,26)
Explore.ok = false
Explore.no = false
Explore.edit = false
Explore.fich = ""
Explore.timer = Timer.new()
Explore.filtre = ""
Explore.action = ""
Explore.showClav = false
Explore.modif = true
Explore.explore = luaWidget.newWidget(SCREEN_DOWN)
Explore.menu = luaWidget.newWidget(SCREEN_DOWN)
Explore.config={}
Explore.ci = Color.new(0,0,0)
Explore.lMeopt = {}


Explore.new = function(dossier,shell,filtre,filtre_defaut,mode,config)
	local scr = SCREEN_DOWN
	if(mode == nil) then mode = 1 end -- mode= 1:ouvrir 2:enregistrer 3:selection Dossier
	dofile("/lua/libs/langue.lua")
	Explore.chemin = luaWidget.newObj(Explore.explore,TTEXTBOX,10,10,236,15,dossier,_ATRONQ)
	Explore.liste = luaWidget.newObj(Explore.explore,TLISTVIEW,10,30,236,110)
	Explore.bOk = luaWidget.newObj(Explore.explore,TBUTTON,180,147,66,15,Text.OK1.."[%B]",_ALEFT,_BA)
	Explore.bNo = luaWidget.newObj(Explore.explore,TBUTTON,180,167,66,15,Text.NO1.."[%B]",_ALEFT,_BB)
	if(shell) then luaWidget.set(Explore.explore,Explore.bNo,"text",Text.NO2.."[%B]") end
	if(mode == 2) then luaWidget.set(Explore.explore,Explore.bOk,"text",Text.OK2.."[%B]") end
	Explore.nom = luaWidget.newObj(Explore.explore,TTEXTBOX,10,147,160,15,"",_ALEFT)
	if(filtre ~= nil) then
		Explore.ext = luaWidget.newObj(Explore.explore,TCOMBOBOX,10,169,80,40,filtre)
		if(filtre_defaut ~= nil) then
			if(filtre_defaut > 0 and filtre_defaut < #filtre) then
				luaWidget.setSel(Explore.explore,Explore.ext,filtre_defaut) 
			else luaWidget.setSel(Explore.explore,Explore.ext,1) end
		else luaWidget.setSel(Explore.explore,Explore.ext,1) end
	else
		Explore.ext = luaWidget.newObj(Explore.explore,TCOMBOBOX,10,169,80,40,{"*.*","*.lua"})
		luaWidget.setSel(Explore.explore,Explore.ext,2)
	end
	Explore.changeDir(dossier)
	Explore.timer:start()
	Explore.filtre = luaWidget.get(Explore.explore,Explore.ext,"text")
	Explore.mode = mode
	Explore.showMenu = false
	Explore.mbOptions = luaWidget.newObj(Explore.menu,TBUTTON,100,167,70,15,Text.OP1.."[%B]",_ACENTER,_BX)
	local xxx = 152
	Explore.mbNewFold = luaWidget.newObj(Explore.menu,TBUTTON,100,xxx,120,15,Text.OP2,_ALEFT)
	xxx = xxx -15
	Explore.mbRename = luaWidget.newObj(Explore.menu,TBUTTON,100,xxx,120,15,Text.OP3,_ALEFT)
	xxx = xxx -15
	Explore.mbDel = luaWidget.newObj(Explore.menu,TBUTTON,100,xxx,120,15,Text.OP4,_ALEFT)
	xxx = xxx -15
	Explore.mbAbout = luaWidget.newObj(Explore.menu,TBUTTON,100,xxx,120,15,Text.OP5,_ALEFT)
	Explore.lMeOpt = {Explore.mbNewFold, Explore.mbRename, Explore.mbDel, Explore.mbAbout}
	Explore.menuSel = 1
	luaWidget.widgetHide(Explore.menu,true)
	luaWidget.set(Explore.menu,Explore.mbOptions,"visible",true)
	if(config ~= nil) then
		Explore.config = INI.load(config)
		if(Explore.config.pref.useCoulDef=="0")then
			if(Explore.config.pref.useCoulUser=="1") then
				Explore.ci=Explore.couleur[dsUser.color]
				luaWidget.set(Explore.explore,Explore.liste,"cSel",Explore.ci)
			else
				luaWidget.set(Explore.explore,Explore.liste,"cSel",Color.new(
					tonumber(Explore.config.coulSel.r),
					tonumber(Explore.config.coulSel.v),
					tonumber(Explore.config.coulSel.b)))
				luaWidget.set(Explore.explore,Explore.liste,"cTextSel",Color.new(
					tonumber(Explore.config.coulTextSel.r),
					tonumber(Explore.config.coulTextSel.v),
					tonumber(Explore.config.coulTextSel.b)))
				Explore.ci = Color.new(
					tonumber(Explore.config.coulFond.r),
					tonumber(Explore.config.coulFond.v),
					tonumber(Explore.config.coulFond.b))
				luaWidget.set(Explore.explore,Explore.liste,"cText",Color.new(
					tonumber(Explore.config.coulText.r),
					tonumber(Explore.config.coulText.v),
					tonumber(Explore.config.coulText.b)))
				luaWidget.set(Explore.explore,Explore.chemin,"cText",Color.new(
					tonumber(Explore.config.coulText.r),
					tonumber(Explore.config.coulText.v),
					tonumber(Explore.config.coulText.b)))
				luaWidget.set(Explore.explore,Explore.nom,"cText",Color.new(
					tonumber(Explore.config.coulText.r),
					tonumber(Explore.config.coulText.v),
					tonumber(Explore.config.coulText.b)))
				luaWidget.set(Explore.explore,Explore.ext,"cText",Color.new(
					tonumber(Explore.config.coulText.r),
					tonumber(Explore.config.coulText.v),
					tonumber(Explore.config.coulText.b)))
				luaWidget.set(Explore.explore,Explore.bOk,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.explore,Explore.bNo,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.menu,Explore.mbOptions,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.menu,Explore.mbNewFold,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.menu,Explore.mbRename,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.menu,Explore.mbDel,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.menu,Explore.mbAbout,"cText",Color.new(
					tonumber(Explore.config.coulTextButton.r),
					tonumber(Explore.config.coulTextButton.v),
					tonumber(Explore.config.coulTextButton.b)))
				luaWidget.set(Explore.explore,Explore.bOk,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.explore,Explore.bNo,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.menu,Explore.mbOptions,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.menu,Explore.mbNewFold,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.menu,Explore.mbRename,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.menu,Explore.mbDel,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))
				luaWidget.set(Explore.menu,Explore.mbAbout,"cFond",Color.new(
					tonumber(Explore.config.coulButton.r),
					tonumber(Explore.config.coulButton.v),
					tonumber(Explore.config.coulButton.b)))				
			end
			if(Explore.config.about == nil) then
				luaWidget.set(Explore.menu,Explore.mbAbout,"active",false)
			elseif(Explore.config.about.text=="") then
				luaWidget.set(Explore.menu,Explore.mbAbout,"active",false)
			end
		end
	else
		luaWidget.set(Explore.menu,Explore.mbAbout,"active",false)
	end
end

Explore.del = function()
	V_EXPLORE = nil
	luaWidget.del(Explore.explore,Explore.chemin)
	luaWidget.del(Explore.explore,Explore.liste)
	luaWidget.del(Explore.explore,Explore.bOk)
	luaWidget.del(Explore.explore,Explore.bNo)
	luaWidget.del(Explore.explore,Explore.nom)
	luaWidget.del(Explore.explore,Explore.ext)
	luaWidget.del(Explore.menu,Explore.mbOptions)
	luaWidget.del(Explore.menu,Explore.mbNewFold)
	luaWidget.del(Explore.menu,Explore.mbRename)
	luaWidget.del(Explore.menu,Explore.mbDel)
	luaWidget.del(Explore.menu,Explore.mbAbout)	
	Text = nil
	Explore = nil
end

Explore.show = function()
	local buff = luaWidget.getSel(Explore.explore,Explore.liste)
	local fich = luaWidget.get(Explore.explore,Explore.nom,"text")
	if(Explore.mode == 2 and string.sub(buff,2,-2) ~= fich) then
		luaWidget.set(Explore.explore,Explore.bOk,"text",Text.OK2.."[%B]")
	end
	if(Explore.modif) then
		if(string.sub(buff,1,1) == "[") then
			luaWidget.set(Explore.explore,Explore.bOk,"text",Text.OK1.."[%B]")
		elseif(Explore.mode == 2) then
			luaWidget.set(Explore.explore,Explore.bOk,"text",Text.OK2.."[%B]")
		end
		buff = string.sub(buff,2)
		buff = string.gsub(buff,"]","")
		luaWidget.set(Explore.explore,Explore.nom,"text",buff)
		Explore.modif = false
	end
	screen.drawGradientRect(SCREEN_DOWN,0,0,256,192,Explore.ci,Explore.ci,Color.new(0,0,0),Color.new(0,0,0))
	luaWidget.show(Explore.explore)
	luaWidget.show(Explore.menu)
	popUp.show()
	if(Explore.showClav) then
		screen.drawFillRect(SCREEN_DOWN,1,30,256,192,Color.new(0,0,0))
		libClavier.show(Explore.clavier)
	end
end

Explore.held = function()
	local reset = false
	local pos
	Explore.ok = false
	Explore.no = false
	if(popUp.isVisible() or Explore.showClav) then
		local rep = ""
		if(Explore.showClav) then
			if(Stylus.newPress) then rep = libClavier.held(Explore.clavier,Stylus.X,Stylus.Y) end
			if(rep == "Esc") then 
				rep = popUp.BNO 
				Explore.showClav = false
			end
			if(rep == "Enter") then
				rep = popUp.BOK
				Explore.showClav = false
			end
		else
			rep= popUp.held()
		end
		if(rep == popUp.BOK) then
			if(Explore.action == "Del") then
				local fich = luaWidget.get(Explore.explore,Explore.nom,"text")
				if(Explore.fExist(fich)) then
					System.remove(fich)
					local pos = luaWidget.get(Explore.explore,Explore.liste,"pos")
					luaWidget.delElement(Explore.explore,Explore.liste,pos)
					luaWidget.setSel(Explore.explore,Explore.liste,pos-1)
					Explore.modif = true
				end
			elseif(Explore.action == "DelFold") then
				local fich = luaWidget.get(Explore.explore,Explore.nom,"text")
				local liste = System.listDirectory(fich)
				if(#liste > 0) then
					if(#liste > 2) then
						popUp.create(Text.POPFNE,Text.POPITD,true)
						popUp.setVisible(true)
						Explore.action = "nothing"
					else
						System.remove(fich)
						Explore.changeDir(System.currentDirectory())
					end
				end
			elseif(Explore.action == "Rename") then
				local fich = libClavier.getText(Explore.clavier)
				if(Explore.fExist(fich)) then
					popUp.create(Text.POPFAE,Text.POPWYR,true,true)
					Explore.action = "RenameOk"
					popUp.setVisible(true)
				elseif(fich ~="") then
					System.rename(luaWidget.get(Explore.explore,Explore.nom,"text"),fich)
					Explore.changeDir(System.currentDirectory())
				end
			elseif(Explore.action == "RenameOk") then
				local fich = libClavier.getText(Explore.clavier)
				System.rename(luaWidget.get(Explore.explore,Explore.nom,"text"),fich)
				Explore.changeDir(System.currentDirectory())
			elseif(Explore.action == "NewFold") then
				local fich = libClavier.getText(Explore.clavier)
				if(Explore.fExist(fich)) then
					popUp.create(Text.POPFE..fich.."...",Text.POPAE,true)
					Explore.action = "nothing"
					popUp.setVisible(true)
				else
					System.makeDirectory(fich)
					Explore.changeDir(System.currentDirectory())
				end
			elseif(Explore.action == "EnterName") then
				local fich = libClavier.getText(Explore.clavier)
				luaWidget.set(Explore.explore,Explore.nom,"text",fich)
			elseif(Explore.action == "ENOk") then
				Explore.ok = true
				Explore.fich = luaWidget.get(Explore.explore,Explore.nom,"text")
			end
			luaWidget.set(Explore.menu,Explore.mbOptions,"check",false)
		elseif(rep == popUp.BNO) then
			luaWidget.set(Explore.menu,Explore.mbOptions,"check",false)		
		end
	else
		luaWidget.held(Explore.menu)
		if(luaWidget.get(Explore.menu,Explore.mbOptions,"check")) then
			if(not Explore.showMenu) then
				luaWidget.widgetHide(Explore.menu,false)
				luaWidget.set(Explore.menu,Explore.mbDel,"check",false)
				luaWidget.set(Explore.menu,Explore.mbRename,"check",false)
				luaWidget.set(Explore.menu,Explore.mbNewFold,"check",false)
				luaWidget.set(Explore.menu,Explore.mbAbout,"check",false)
				if(luaWidget.get(Explore.explore,Explore.nom,"text") == "..") then
					luaWidget.set(Explore.menu,Explore.mbDel,"active",false)
					luaWidget.set(Explore.menu,Explore.mbRename,"active",false)
				else
					luaWidget.set(Explore.menu,Explore.mbDel,"active",true)
					luaWidget.set(Explore.menu,Explore.mbRename,"active",true)
				end
				luaWidget.set(Explore.explore,Explore.bOk,"active",false)
				luaWidget.set(Explore.explore,Explore.bNo,"active",false)
				Explore.menuSel = 1
				Explore.oldColor = luaWidget.get(Explore.menu,Explore.lMeOpt[1],"cFond")
				luaWidget.set(Explore.menu,Explore.lMeOpt[1],"cFond",Explore.ci)
			end
			Explore.showMenu = true
		else
			if(Explore.showMenu) then
				luaWidget.widgetHide(Explore.menu,true)
				luaWidget.set(Explore.menu,Explore.mbOptions,"visible",true)
				luaWidget.set(Explore.explore,Explore.bOk,"active",true)
				luaWidget.set(Explore.explore,Explore.bNo,"active",true)
				luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"cFond",Explore.oldColor)
			end
			Explore.showMenu = false
		end
		if(Explore.showMenu) then 
			if(Explore.timer:getTime() > 150) then 
				if(Keys.newPress.Up or Keys.held.Up) then
					luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"cFond",Explore.oldColor)
					Explore.menuSel = Explore.menuSel+1
					if(Explore.menuSel > #Explore.lMeOpt) then Explore.menuSel = 1 end
					luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"cFond",Explore.ci)
					reset = true
				elseif(Keys.newPress.Down or Keys.held.Down) then
					luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"cFond",Explore.oldColor)
					Explore.menuSel = Explore.menuSel-1
					if(Explore.menuSel < 1) then Explore.menuSel = #Explore.lMeOpt end
					luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"cFond",Explore.ci)
					reset = true
				end
				if(reset) then
					Explore.timer:reset()
					Explore.timer:start()
				end
			end
			if(Keys.newPress.A) then
				if(luaWidget.get(Explore.menu,Explore.lMeOpt[Explore.menuSel],"active") == true) then
					luaWidget.set(Explore.menu,Explore.lMeOpt[Explore.menuSel],"check",true)
				end
			end
			if(luaWidget.get(Explore.menu,Explore.mbDel,"check")) then
				local objet = Text.POPFIL
				Explore.action = "Del"
				if(string.sub(luaWidget.getSel(Explore.explore,Explore.liste),1,1) == "[") then
					objet = Text.POPFOL
					Explore.action = "DelFold"
				end
				popUp.create(Text.POPWYD..objet,luaWidget.get(Explore.explore,Explore.nom,"text").." ?",true,true)
				popUp.setVisible(true)
			elseif(luaWidget.get(Explore.menu,Explore.mbRename,"check")) then
				Explore.action = "Rename"
				libClavier.setText(Explore.clavier,luaWidget.get(Explore.explore,Explore.nom,"text"))
				Explore.showClav = true
			elseif(luaWidget.get(Explore.menu,Explore.mbNewFold,"check")) then
				Explore.action = "NewFold"
				libClavier.setText(Explore.clavier,"")
				Explore.showClav = true
			elseif(luaWidget.get(Explore.menu,Explore.mbAbout,"check")) then
				popUp.create(Text.OP5,Explore.config.about.text,true)
				popUp.setVisible(true)
				Explore.action = "none"
			end
		else
			luaWidget.held(Explore.explore)
			if(Explore.timer:getTime() > 150) then 
				if(Keys.newPress.Up or Keys.held.Up) then
					pos = luaWidget.get(Explore.explore,Explore.liste,"pos")-1
					if(pos < 1) then pos = luaWidget.get(Explore.explore,Explore.liste,"max") end
					luaWidget.set(Explore.explore,Explore.liste,"pos",pos)
					reset = true
				elseif(Keys.newPress.Down or Keys.held.Down) then
					pos = luaWidget.get(Explore.explore,Explore.liste,"pos")+1
					if(pos > luaWidget.get(Explore.explore,Explore.liste,"max")) then pos = 1 end
					luaWidget.set(Explore.explore,Explore.liste,"pos",pos)
					reset = true
				elseif(Keys.newPress.Right) then
					if(string.sub(luaWidget.getSel(Explore.explore,Explore.liste),1,1)=="[") then
						Explore.changeDir(luaWidget.get(Explore.explore,Explore.nom,"text"))
					end
				elseif(Keys.newPress.Left) then
					Explore.changeDir("..")
				end
				if(reset) then
					Explore.timer:reset()
					Explore.timer:start()
					Explore.modif = true
				end
			end
			if(luaWidget.get(Explore.explore,Explore.liste,"doubleClick")) then
				luaWidget.set(Explore.explore,Explore.bOk,"check",true)
				luaWidget.set(Explore.explore,Explore.liste,"doubleClick",false)
			elseif(luaWidget.get(Explore.explore,Explore.liste,"check")) then
				Explore.modif = true
				luaWidget.set(Explore.explore,Explore.liste,"check",false)
			end
			if(luaWidget.get(Explore.explore,Explore.bOk,"check")) then
				local buff = luaWidget.getSel(Explore.explore,Explore.liste)
				local fich = luaWidget.get(Explore.explore,Explore.nom,"text")
				if(string.sub(buff,1,1) == "[" and string.sub(buff,2,-2) == fich) then
					Explore.changeDir(fich)
				else
					if(Explore.fExist(fich)) then
						if(Explore.mode == 2) then
							popUp.create(Text.POPFAE,Text.POPWYR,true,true)
							Explore.action = "ENOk"
							popUp.setVisible(true)
						else
							Explore.ok = true
							Explore.fich = fich
						end
					else
						if(Explore.mode == 2) then
							Explore.ok = true
							Explore.fich = fich
						else
							popUp.create(Text.POPFDNE,fich.." "..Text.POPNF,true)
							Explore.action = "nothing"
							popUp.setVisible(true)
						end
					end
				end
				luaWidget.set(Explore.explore,Explore.bOk,"check",false)
			elseif(luaWidget.get(Explore.explore,Explore.bNo,"check")) then
				Explore.no = true 
				luaWidget.set(Explore.explore,Explore.bNo,"check",false)
			elseif(luaWidget.get(Explore.explore,Explore.nom,"check")) then
				local fich = luaWidget.get(Explore.explore,Explore.nom,"text")
				libClavier.setText(Explore.clavier,fich)
				Explore.showClav = true
				Explore.action = "EnterName"
				luaWidget.set(Explore.explore,Explore.nom,"check",false)
			end
		--***************** Modification du filtre de recherche ******************
			if(luaWidget.get(Explore.explore,Explore.ext,"text") ~= Explore.filtre) then
				Explore.filtre = luaWidget.get(Explore.explore,Explore.ext,"text")
				Explore.changeDir(System.currentDirectory())
			end
		--****************** Test doubleClick *************
			if(Stylus.doubleClick and not Explore.showMenu) then luaWidget.DblClk(Explore.explore) end
		end
	end
end

Explore.changeDir = function(dir)
	System.changeDirectory(dir)
	local E_files = System.listDirectory(System.currentDirectory())
	local buftxt
	local cpt = 0
	local tableau = {}
	local filtre = luaWidget.get(Explore.explore,Explore.ext,"text")
	filtre = string.lower(filtre)
	cpt = string.find(filtre,"%.")
	filtre = string.sub(filtre,cpt+1)
	cpt = 0
	for a, file in pairs(E_files) do
		if(file.name ~= ".")then
			if(file.isDir) then buftxt = "["..file.name.."]"
			else buftxt = " "..file.name end		
			if(filtre == "*"
				or string.lower(string.sub(buftxt,string.len(filtre)*-1)) == filtre
				or string.sub(buftxt,1,1) == "[") then 
				cpt = cpt+1
				tableau[cpt]=buftxt
			end
		end
	end
	luaWidget.set(Explore.explore,Explore.liste,"element",tableau)
	luaWidget.set(Explore.explore,Explore.chemin,"text",System.currentDirectory())
	Explore.modif = true
end

Explore.getDir = function()
	return luaWidget.get(Explore.explore,Explore.chemin,"text")
end

Explore.fExist = function(fichier)
	local ok = false
	local fich = io.open(fichier,"r")
	if(fich) then
		io.close(fich)
		ok = true
	end
	return ok
end
