assert(V_LUAWIDGET ~= nil,"Librairie LuaWidget manquante")

V_POPUP = 0.011

popUp = {}
popUp.color = {}
popUp.color.tfond = Color.new(10,10,31)
popUp.color.fcadre = Color.new(31,31,16)
popUp.color.ttexte = Color.new(0,0,0)
popUp.color.ftexte = Color.new(0,0,0)

fenPop = {}
fenPop.parent = luaWidget.newWidget(SCREEN_DOWN)
fenPop.titre = luaWidget.newObj(fenPop.parent,TTEXTBOX,10,79,236,15,"Titre",_ALEFT)
fenPop.texte = luaWidget.newObj(fenPop.parent,TTEXTBOX,10,95,236,15,"Texte",_ACENTER,true)
fenPop.bOk = luaWidget.newObj(fenPop.parent,TBUTTON,60,115,60,15,"Oui [%B]",_ACENTER,_BA)
fenPop.bNo = luaWidget.newObj(fenPop.parent,TBUTTON,120,115,60,15,"Non [%B]",_ACENTER,_BB)
fenPop.bCa = luaWidget.newObj(fenPop.parent,TBUTTON,180,115,60,15,"Annuler",_ACENTER,_BX)
luaWidget.set(fenPop.parent,fenPop.titre,"cFond",popUp.color.tfond)
luaWidget.set(fenPop.parent,fenPop.titre,"cCadre",popUp.color.tfond)
luaWidget.set(fenPop.parent,fenPop.texte,"cFond",popUp.color.fcadre)
luaWidget.set(fenPop.parent,fenPop.texte,"cCadre",popUp.color.fcadre)

popUp.visible = false
popUp.BOK = 1
popUp.BNO = 2
popUp.BCANCEL = 3
popUp.nbl = 1
popUp.up = 79

popUp.create = function(titre,texte,bok,bno,bca,ctitre,cttext,cfond,cftext)
	local numB = 0
	local xx = 98
	luaWidget.set(fenPop.parent,fenPop.titre,"text",titre)
	popUp.nbl = math.floor(string.len(texte)/39) +1
	popUp.up = 96 - math.floor(((popUp.nbl*10)+35)/2)
	luaWidget.set(fenPop.parent,fenPop.texte,"height",(10*popUp.nbl)+5)
	luaWidget.set(fenPop.parent,fenPop.titre,"y",popUp.up)
	luaWidget.set(fenPop.parent,fenPop.texte,"y",popUp.up+15)
	luaWidget.set(fenPop.parent,fenPop.bOk,"y",popUp.up+(10*popUp.nbl)+25)
	luaWidget.set(fenPop.parent,fenPop.bNo,"y",popUp.up+(10*popUp.nbl)+25)
	luaWidget.set(fenPop.parent,fenPop.bCa,"y",popUp.up+(10*popUp.nbl)+25)
	luaWidget.set(fenPop.parent,fenPop.texte,"text",texte)
	if(bok ~= nil) then if(bok) then numB = numB +1 end else bok = false end
	if(bno ~= nil) then if(bno) then numB = numB +1 end else bno = false end
	if(bca ~= nil) then if(bca) then numB = numB +1 end else bca = false end
	if(numB == 0) then 
		luaWidget.set(fenPop.parent,fenPop.bNo,"visible",false)
		luaWidget.set(fenPop.parent,fenPop.bCa,"visible",false)
		luaWidget.set(fenPop.parent,fenPop.bOk,"visible",false)	
	else
		xx = 128-(numB*32)
		luaWidget.set(fenPop.parent,fenPop.bOk,"visible",bok)
		luaWidget.set(fenPop.parent,fenPop.bNo,"visible",bno)
		luaWidget.set(fenPop.parent,fenPop.bCa,"visible",bca)
		if(bok) then luaWidget.set(fenPop.parent,fenPop.bOk,"x",xx) xx = xx + 64 end
		if(bno) then luaWidget.set(fenPop.parent,fenPop.bNo,"x",xx) xx = xx + 64 end
		if(bca) then luaWidget.set(fenPop.parent,fenPop.bCa,"x",xx) xx = xx + 64 end
	end
	if(numB == 1) then luaWidget.set(fenPop.parent,fenPop.bOk,"text","Ok [%B]")
	else luaWidget.set(fenPop.parent,fenPop.bOk,"text","Oui [%B]") end
	if(ctitre ~= nil) then
		luaWidget.set(fenPop.parent,fenPop.titre,"cFond",ctitre)
		luaWidget.set(fenPop.parent,fenPop.titre,"cCadre",ctitre)
	end
	if(cttext ~= nil) then
		luaWidget.set(fenPop.parent,fenPop.titre,"cText",cttext)
	end
	if(cfond ~= nil) then
		luaWidget.set(fenPop.parent,fenPop.texte,"cFond",cfond)
		luaWidget.set(fenPop.parent,fenPop.texte,"cCadre",cfond)
	end
	if(cftext ~= nil) then
		luaWidget.set(fenPop.parent,fenPop.texte,"cText",cftext)
	end
end

popUp.del = function()
	fenPop = nil
	popUp = nil
end

popUp.setVisible = function(show)
	if(show == nil) then show = false end
	popUp.visible = show
end

popUp.isVisible = function()
	return popUp.visible
end

popUp.show = function()
	if(popUp.visible) then
		screen.drawFillRect(SCREEN_DOWN,9,popUp.up,247,popUp.up+(popUp.nbl*10)+45,luaWidget.get(fenPop.parent,fenPop.texte,"cFond"))
		luaWidget.show(fenPop.parent)
	end
end

popUp.held = function()
	local rep = 0
	luaWidget.held(fenPop.parent)
	if(luaWidget.get(fenPop.parent,fenPop.bOk,"check"))then
		luaWidget.set(fenPop.parent,fenPop.bOk,"check",false)
		rep = 1
		popUp.visible = false
	end
	if(luaWidget.get(fenPop.parent,fenPop.bNo,"check"))then
		luaWidget.set(fenPop.parent,fenPop.bNo,"check",false)
		rep = 2
		popUp.visible = false
	end
	if(luaWidget.get(fenPop.parent,fenPop.bCa,"check"))then
		luaWidget.set(fenPop.parent,fenPop.bCa,"check",false)
		rep = 3
		popUp.visible = false
	end
	return rep
end
