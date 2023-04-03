Debug.ON()
Debug.setColor(Color.new(31,0,0))

dofile("standard.lua")
dofile("popup.lua")
dofile("luaWidget.lua")
dofile("Clavierc.lua")
dofile("miniSignal.lua")
clavier.activeScreen(clav,true)

_VDSIRC = 0.21
irc = {}
dofile("ircReponse.lua")

irc.user = {}
-- On verifie si le fichier de config existe
file = io.open("DSirc.ini","r")
if(file) then
	io.close(file)
	irc.user = INI.load("DSirc.ini")
-- Si il n'existe pas on configure le minimum
else
	math.randomseed(os.time())
	irc.user.nick = string.format("DSUser%d",math.random(1000))
	irc.user.server = {}
	irc.user.server[1] = {}
	irc.user.server[1].name = "irc.freenode.net"
	irc.user.server[1].port = 6667
	irc.user.server[1].chan = {}
	irc.user.server[1].chan[1] = "#microlua"
end
file = nil
-- Connection parameters table
tab_param = {}
tab_param.host = irc.user.server[1].name
tab_param.port = irc.user.server[1].port
tab_param.nick = irc.user.nick
tab_param.real = "microLuaDS_IRC"
tab_param.user = "guest"
tab_param.chan = irc.user.server[1].chan[1]

-- Colours
irc.color = {}
irc.color.gray = Color.new(20,20,20)
irc.color.white = Color.new(31,31,31)
irc.color.lsgreen = Color.new(3,21,20)
irc.color.blue = Color.new(0,0,31)
irc.color.red = Color.new(31,0,0)
irc.color.green = Color.new(0,31,0)

-- Global variables
irc.buffer = ""
irc.tab_text = {}
irc.pattern = string.format("%c%c",13,10)
irc.ok = true
irc.connect = 0
irc.erreur = ""
irc.tou = ""
irc.tempon = ""
irc.quit = false
irc.lnames = {}
irc.server_text = {}
irc.clnames = true
irc.affichage = ""
irc.cptping = 0
irc.dep = 1
--[[ mode : 	0 = Internet connection
				1 = IRC connection
				2 = Join channel
				3 = Discussion
			   -1 = Error  (Message in irc.erreur)
]]
irc.mode = 0

-- Buttons
fenP = {}
fenP.parent = luaWidget.newWidget(SCREEN_DOWN)
fenP.Bserveur = luaWidget.newObj(fenP.parent,TBUTTON,1,18,64,15,tab_param.host,_ACENTER)
fenP.BautoConnect = luaWidget.newObj(fenP.parent,TBUTTON,66,18,64,15,tab_param.chan,_ACENTER)
fenP.BlistUsers = luaWidget.newObj(fenP.parent,TBUTTON,131,18,64,15,"Users",_ACENTER)
luaWidget.set(fenP.parent,fenP.Bserveur,"visible",false)
luaWidget.set(fenP.parent,fenP.BautoConnect,"visible",false)
luaWidget.set(fenP.parent,fenP.BlistUsers,"visible",false)

-------------------------------------------------
-- tableau = recois()
-------------------------------------------------
-- Check for waiting data in wifi buffer, read it and fill
-- in the table with it.
-------------------------------------------------
irc.recois = function()
	local retour = {}
	retour.prefix = {}
	retour.prefix.norm = ""
	retour.prefix.nick = ""
	retour.prefix.nomcli = ""
	retour.prefix.domcli = ""
	retour.command = ""
	retour.param = {}
	retour.param.norm = ""
	local buff = ""
	local i, j
	if(Wifi.checkData(irc.socket) > 0) then 
		buff = Wifi.receive(irc.socket,256)
		irc.tempon = irc.tempon..buff
	end
	if(string.len(irc.tempon) > 1) then
		Debug.clear()-----------------------------
		buff = irc.tempon
-- Look for message end in case of beginning of the next
		i = string.find(buff, irc.pattern)
		if(i~= nil) then 
-- We have a complete message
			irc.tempon = string.sub(buff,i+2,-1)
			buff = string.sub(buff,1,i-1)
			Debug.print(buff)
-- Is the message prefixed?
			if(string.sub(buff,1,1) == ":") then
-- Yes: read the prefix
				j = string.find(buff," ")
				retour.prefix.norm = string.sub(buff,2,j-1)
				buff = string.sub(buff,j+1,-1)
			else
-- No: empty prefix
			retour.prefix.norm = ""
			end
-- Are there parameters after the command?
			i = string.find(buff," ")
			if(i ~= nil)  then
-- Yes: read them
				retour.command = string.sub(buff,1,i-1)
				buff = string.sub(buff,i+1,-1)
				retour.param.norm = buff
-- Format them
-- Is there the 0x01 character?
				i = string.find(buff,string.char(1))
				if(i ~= nil) then
-- Yes: add command2 with its parameters
					buff = string.sub(buff,i+1,-2)
					i = string.find(buff, " ")
					if(i == nil) then
						retour.command2 = buff
					else
						retour.command2 = string.sub(buff,1,i-1)
						retour.param.com2 = string.sub(buff,i+1,-1)
					end
				else
-- No: format parameters
					i = string.find(buff," ")
					while(i~= nil) do
						if(string.sub(buff,1,1) == ":") then
							table.insert(retour.param,string.sub(buff,2,-1))
							buff = ""
						else
							table.insert(retour.param,string.sub(buff,1,i-1))
							buff = string.sub(buff,i+1,-1)
						end
						i = string.find(buff," ")
					end
					if(string.len(buff)>0) then
						if(string.sub(buff,1,1) == ":") then
							table.insert(retour.param,string.sub(buff,2,-1))
						else
							table.insert(retour.param,buff)
						end	
					end
				end
			else
-- No: only put the command
				retour.command = buff
			end
-- Format prefix
			i = string.find(retour.prefix.norm,"!")
			if(i ~= nil) then
				retour.prefix.nick = string.sub(retour.prefix.norm,1,i-1)
				j = string.find(retour.prefix.norm,"@",i+1)
				retour.prefix.nomcli = string.sub(retour.prefix.norm,i+1,j-1)
				retour.prefix.domcli = string.sub(retour.prefix.norm,j+1,-1)
			end
		end
	end
	return retour
end

-------------------------------------------------
-- attente()
-------------------------------------------------
-- Check Wifi status and display it in a popup
-- until AP association
-------------------------------------------------
irc.attente = function()
	local stat
	if(irc.ok) then
		stat = "ASSOCSTATUS_DISCONNECTED"
		irc.roll = 1
		irc.char = {"<","^",">","v"}
		irc.ok = false
	end
	stat = Wifi.status()
	if(stat == "ASSOCSTATUS_ASSOCIATED") then
		irc.ok = true
	elseif(stat == "ASSOCSTATUS_CANNOTCONNECT") then
		irc.mode = -1
		irc.erreur = "Association échoué."
	end
	popup.new(SCREEN_UP,"Association",stat.." "..irc.char[math.floor(irc.roll)],0,string.char(127))
	irc.roll = irc.roll + 0.1
	if(irc.roll > 4.9) then irc.roll = 1 end
end

-------------------------------------------------
-- verif_mode()
-------------------------------------------------
-- Action to be done according to the situation
-- irc.mode = -1: error, display it
-- irc.mode = 0 : association to the AP
-- irc.mode = 1 : Waiting for connection to a server
-- irc.mode = 2 : Connect to server and join channel
-- irc.mode = 3 : Join channel
-- irc.mode = 5 : Chatting
-------------------------------------------------
irc.verif_mode = function()
	if(irc.mode == -1) then
		--screen.print(SCREEN_DOWN,0,27,"** ERREUR * "..irc.erreur.." **")
		popup.new(SCREEN_UP,"ERREUR",irc.erreur,1,string.char(127))
		if(popup.rep == 1) then irc.quit = true end
	end
	if(irc.mode == 3) then
		local dem = "JOIN "..tab_param.chan.."\n"
		Wifi.send(irc.socket,dem)
		irc.mode = 5
	end
	if(irc.mode == 2) then
		local dem
		irc.socket = Wifi.createTCPSocket(tab_param.host,tab_param.port)
		if(irc.socket) then irc.mode = 1
			dem = "NICK "..tab_param.nick.."\n"
			Wifi.send(irc.socket,dem)
			dem = "USER "..tab_param.user.." a a "..tab_param.real.."\n"
			Wifi.send(irc.socket,dem)
			dem = "JOIN "..tab_param.chan.."\n"
			Wifi.send(irc.socket,dem)
			irc.mode = 5
		else 
			irc.mode = -1
			irc.erreur = "Impossible de créé le socket"
		end
	end
	if(irc.mode == 1) then
		luaWidget.set(fenP.parent,fenP.Bserveur,"visible",true)
		luaWidget.set(fenP.parent,fenP.BautoConnect,"visible",true)
	end
	if(irc.mode == 0) then
		if(irc.connect == 0) then
			--Wifi.init()
			--local rep = Wifi.autoConnect()
			--if(not rep) then
				dofile("GestConn.lua")
				del_GestCon()
				irc.mode = 1
			--end
			irc.connect = 1
		end
		irc.attente()
		if(irc.ok) then
			popup.close()
			irc.mode = 1
		end
	end
end

-------------------------------------------------
-- ajout_text(list, nick, text)
-------------------------------------------------
-- list : text list to add this
-- nick : message author's nickname
-- text : message to add
-------------------------------------------------
-- Add the text and format it to display
-------------------------------------------------
irc.ajout_text = function(list, nick, text)
	local buffer
	if(text ~= nil) then
		buffer = string.rep(" ",9-string.len(nick))..nick..":"..text
	else
		buffer = nick
	end
	table.insert(list,string.sub(buffer,1,41))
	buffer = string.sub(buffer,42,-1)

	while(string.len(buffer)>0) do
		buffer = string.rep(" ",10)..buffer
		table.insert(list,string.sub(buffer,1,41))
		buffer = string.sub(buffer,42,-1)				
	end
end

-------------------------------------------------
-- texte = commande(texte)
-------------------------------------------------
-- texte : text to interpret
-------------------------------------------------
-- Check whether the typed text is
-- a command or not; format and
-- send it if it is. Return if formated.
-------------------------------------------------
irc.commande = function(texte)
	local ret = false
	local comm = ""
	local opt1 = ""
	local opt2 = ""
	local i, j
	if(string.sub(texte,1,1) == "/") then
		i = string.find(texte," ")
		if(i == nil) then i = 0 end
		comm = string.upper(string.sub(texte,2,i-1))
		opt1 = string.sub(texte,i+1,-1)

		if(comm == "PING") then
			local opt1 = os.time()
			opt1 = opt1.." :"..string.char(1)..comm.." "..opt2..string.char(1)
			comm = "PRIVMSG"
		elseif(comm == "ME") then
			opt2 = string.char(1).."ACTION "..opt1..string.char(1)
			irc.ajout_text(irc.tab_text,tab_param.nick.." "..opt1)
			opt1 = tab_param.chan.." :"..opt2
			comm = "PRIVMSG"
		elseif(comm == "PART") then
			opt2 = tab_param.chan
			opt1 = opt2
		elseif(comm == "QUIT") then
			opt2 = "quit"
		elseif(comm == "VERSION") then
			opt2 = string.char(1).."VERSION"..string.char(1)
			opt1 = opt1.." :"..opt2
			comm = "PRIVMSG"
		end
		if(opt2 == "") then
			irc.ajout_text(irc.tab_text," ",comm.." Commande inconnue.")
		else 
			Wifi.send(irc.socket,comm.." "..opt1.."\n")
		end
		ret = true
	end
	return ret
end

-------------------------------------------------
-- pause(seconde)
-------------------------------------------------
-- seconde : time (seconds)
-------------------------------------------------
-- Make a x-seconds pause ; during
-- the pause the script is frozen
-------------------------------------------------
irc.pause = function(seconde)
	local tpsb1 = os.time()
	local tpsb2 = tpsb1+seconde
	while(tpsb1 < tpsb2) do
		tpsb1 = os.time()
	end
end

-------------------------------------------------
-- text = verif_text(text)
-------------------------------------------------
-- text : text to check
-------------------------------------------------
-- Check whether the text contains
-- special characters or not, and
-- convert them if needed
-------------------------------------------------
irc.verif_text = function(text)
	local i, j
	if(text ~= nil) then
		i = string.find(text,string.char(195))
		while(i~= nil) do
			j = string.sub(text,i+1,i+1)
			j = string.char(string.byte(j)+64)
			text = string.sub(text,1,i-1)..j..string.sub(text,i+2,-1)
			i = string.find(text,string.char(195))
		end
		i = string.find(text,string.char(184))
		while(i~= nil) do
			j = string.sub(text,i+1,i+1)
			text = string.sub(text,1,i-1)..j..string.sub(text,i+2,-1)
			i = string.find(text,string.char(195))
		end
	end
	return text
end

-------------------------------------------------
-- resetBorder()
-------------------------------------------------
-- Reset button's border colour
-------------------------------------------------
irc.resetBorder = function()
	luaWidget.set(fenP.parent,fenP.BautoConnect,"cCadre",irc.color.white)
	luaWidget.set(fenP.parent,fenP.Bserveur,"cCadre",irc.color.white)
	luaWidget.set(fenP.parent,fenP.BlistUsers,"cCadre",irc.color.white)	
end

-------------------------------------------------
-- affBD(pos, max)
-------------------------------------------------
-- pos : beginning position
-- max : maximum lines number
-------------------------------------------------
-- Display scrolling bar on the right
-- of the text
-------------------------------------------------
irc.affBD = function(pos, max)
	local blanc = Color.new(31,31,31)
	local gris = Color.new(10,10,10)
	local noir = Color.new(0,0,0)
	local jaune = Color.new(28,28,0)
	local cc, cd, cu, y, yy
	if(max < 19) then 
		cc = gris
	else
		cc = blanc
		if(pos > 1) then cu = blanc else cu = gris end
		if(pos+19 == max) then cd = blanc else cd = gris end
	end
	screen.print(SCREEN_UP,248,1,string.char(19),cu)
	screen.print(SCREEN_UP,248,184,string.char(20),cd)
	screen.drawRect(SCREEN_UP,247,0,256,192,cc)
	screen.drawLine(SCREEN_UP,247,9,256,9,cc)
	screen.drawLine(SCREEN_UP,247,183,256,183,cc)
	if(max > 19) then
		yy = 172-(math.floor(172/max)*(max-19))
		if(yy < 4) then yy = 4 end
		y = (math.floor((pos*(172-yy))/max))+10
		screen.drawFillRect(SCREEN_UP,248,y,255,y+yy,jaune)
	end
end

-------------------------------------------------
-- Main
-------------------------------------------------
while(not irc.quit) do

	Controls.read()
	clavier.show(clav)
	showMiniWifiSignal(SCREEN_DOWN,_POSUR)
	irc.verif_mode()
	if(Keys.newPress.Start) then irc.quit = true end
	if(Stylus.newPress and irc.mode > 0) then
		irc.tou = clavier.held(clav,Stylus.X,Stylus.Y)
		if(irc.tou == "Enter") then
			local buff = ""
			buff = clavier.getText(clav)
			if(irc.socket ~= nil and buff ~= "") then
				if(not irc.commande(buff)) then
					Wifi.send(irc.socket,"PRIVMSG "..tab_param.chan.." :"..buff.."\n")
				end
				clavier.setText(clav,"")
				irc.ajout_text(irc.tab_text, tab_param.nick, buff)
			end
		end
		if(irc.tou == "Esc") then
			clavier.setText(clav,"")
		end
		luaWidget.held(fenP.parent)
		if(luaWidget.get(fenP.parent,fenP.BautoConnect,"check")) then
			luaWidget.set(fenP.parent,fenP.BautoConnect,"check",false)
			irc.resetBorder()
			luaWidget.set(fenP.parent,fenP.BautoConnect,"cCadre",irc.color.blue)
			luaWidget.set(fenP.parent,fenP.BautoConnect,"cFond",irc.color.gray)
			if(irc.mode == 1) then irc.mode = 2 end
			irc.affichage = "chan"
			irc.dep = #irc.tab_text - 18
		end
		if(luaWidget.get(fenP.parent,fenP.BlistUsers,"check")) then
			luaWidget.set(fenP.parent,fenP.BlistUsers,"check",false)
			irc.resetBorder()
			luaWidget.set(fenP.parent,fenP.BlistUsers,"cCadre",irc.color.blue)
			luaWidget.set(fenP.parent,fenP.BlistUsers,"cFond",irc.color.gray)
			irc.affichage = "users"
			irc.dep = #irc.lnames - 18
		end
		if(luaWidget.get(fenP.parent,fenP.Bserveur,"check")) then
			luaWidget.set(fenP.parent,fenP.Bserveur,"check",false)
			irc.resetBorder()
			luaWidget.set(fenP.parent,fenP.Bserveur,"cCadre",irc.color.blue)
			luaWidget.set(fenP.parent,fenP.Bserveur,"cFond",irc.color.gray)
			irc.affichage = "server"
			irc.dep = #irc.server_text - 18
		end
	end
	if(irc.mode > 2) then
-- Command reply
		irc.buffer = irc.recois()
		if(irc.buffer.command2 ~= nil) then
			if(irc.buffer.param.com2 == nil) then
				if(irc.buffer.command2 == "VERSION") then
					Wifi.send(irc.socket,"NOTICE "..irc.buffer.prefix.nick.." :"..
						string.char(1).."VERSION :DSLuaIRC V".._VDSIRC..string.char(1).."\n")
				end
			end
		end
		if(irc.buffer.command == "PING") then
			Wifi.send(irc.socket,"PONG "..irc.buffer.param.norm.."\n")
			irc.cptping = irc.cptping+1
		elseif(irc.buffer.command == "PONG") then
			local tpsp = os.time()
			tps = tonumber(irc.buffer.param[1])
			if(tps == nil) then tps = 0 end
			tpsp = tpsp - tps
			irc.ajout_text(irc.tab_text,irc.buffer.prefix.nick,
				"Reponse au ping: "..tpsp.." secondes")
			if(irc.affichage ~= "chan") then
				luaWidget.set(fenP.parent,fenP.BautoConnect,"cFond",irc.color.lsgreen)
			end
		elseif(irc.buffer.command == "353") then
			local i, j
			local buff = ""
			if(irc.clnames) then
				irc.clnames = false
				for i=1, #irc.lnames do
					table.remove(irc.lnames,1)
				end
				luaWidget.set(fenP.parent,fenP.BlistUsers,"visible",true)
			end
			buff = irc.buffer.param[#irc.buffer.param]
			i = string.find(buff," ")
			j = 1
			while(i~= nil) do
				table.insert(irc.lnames,string.sub(buff,j,i-1))
				j = i+1
				i = string.find(buff," ",j)
			end
			table.insert(irc.lnames,string.sub(buff,j,-1))
		elseif(irc.buffer.command == "366") then
			irc.clnames = true
		elseif(irc.buffer.command == "NICK") then
			if(irc.buffer.prefix.nick == tab_param.nick) then
				tab_param.nick = irc.buffer.param[1]
				irc.ajout_text(irc.tab_text,"","Votre Pseudo est maintenant: "..irc.buffer.param[1])
			else
				irc.ajout_text(irc.tab_text,"",irc.buffer.prefix.nick.." à changé son Pseudo par: "..
					irc.buffer.param[1])
			end
			local i
			i = 1
			while(irc.lnames[i] ~= irc.buffer.prefix.nick) do
				i = i+1
			end
			irc.lnames[i] = irc.buffer.param[1]
		elseif(irc.buffer.command == "JOIN") then
			table.insert(irc.lnames,irc.buffer.prefix.nick)
			irc.ajout_text(irc.tab_text,"",irc.buffer.prefix.nick.." a rejoind le chan.")
			if(irc.affichage ~= "chan") then
				luaWidget.set(fenP.parent,fenP.BautoConnect,"cFond",irc.color.lsgreen)
			end
		elseif(irc.buffer.command == "ERROR") then
			
		elseif(irc.buffer.command == "PART" or irc.buffer.command == "QUIT") then
			local i = 1
			while(irc.lnames[i] ~= irc.buffer.prefix.nick) do i=i+1 end
			table.remove(irc.lnames,i)
			if(irc.buffer.command == "PART") then
				irc.ajout_text(irc.tab_text,"",irc.buffer.prefix.nick.." a quitté le chan.")
			elseif(irc.buffer.command == "QUIT") then
				irc.ajout_text(irc.tab_text,"",irc.buffer.prefix.nick..
					" a quitté ("..tab_param.host..").")
			end
			if(irc.affichage ~= "chan") then
				luaWidget.set(fenP.parent,fenP.BautoConnect,"cFond",irc.color.lsgreen)
			end
		elseif(irc.buffer.command == "PRIVMSG" or irc.buffer.command == "TOPIC") then 
			local text = irc.verif_text(irc.buffer.param[#irc.buffer.param])
			if(irc.buffer.command == "PRIVMSG") then
				irc.ajout_text(irc.tab_text,irc.buffer.prefix.nick, text)
			else
				irc.ajout_text(irc.tab_text,irc.buffer.command, text)
			end
			if(irc.affichage ~= "chan") then
				luaWidget.set(fenP.parent,fenP.BautoConnect,"cFond",irc.color.lsgreen)
			end
		elseif(irc.buffer.command == "NOTICE") then
			local text
			if(irc.buffer.command2 ~= nil) then
				if(irc.buffer.command2 == "VERSION") then
					text = irc.buffer.param.comm2
				elseif(irc.buffer.command2 == "PING") then
					
				end
			else
				text = irc.verif_text(irc.buffer.param[#irc.buffer.param])
			end
			irc.ajout_text(irc.tab_text,irc.buffer.command, text)
		elseif(irc.buffer.command == "ACTION") then
			irc.ajout_text(irc.tab_text,irc.buffer.prefix.nick.." "..irc.buffer.param[1])
		elseif(irc.buffer.command == "VERSION") then
			Wifi.send(irc.socket,"NOTICE "..irc.buffer.prefix.nick.." :"..
				string.char(1).."VERSION :DSLuaIRC V".._VDSIRC..string.char(1).."\n")
		else
			if(irc.buffer.command ~= "") then
				irc.ajout_text(irc.server_text,irc.buffer.command..":"..irc.buffer.param.norm)
			end
		end
-- Display
		local dep , buff
		if(irc.affichage == "users") then buff = irc.lnames
		elseif(irc.affichage == "server") then buff = irc.server_text
		else
			buff = irc.tab_text -- irc.affichage == "chan"
		end
		if(Keys.held.X or Keys.held.Up) then
			irc.dep = irc.dep -1
		end
		if(Keys.held.B or Keys.held.Down) then
			irc.dep = irc.dep +1
		end
		if(irc.dep+19 >  #buff) then irc.dep = #buff - 18 end
		if(irc.dep < 1) then irc.dep = 1 end		
		local i,j

		j = 0
		for i=irc.dep, #buff do
			screen.print(SCREEN_UP,0,j,buff[i])
			j = j+10
		end
		irc.affBD(irc.dep, #buff)
	end
	luaWidget.show(fenP.parent)
	popup.show()
	screen.print(SCREEN_DOWN,220,180,irc.cptping)
	render()
end
if(irc.mode == 5) then 
	popup.new(SCREEN_UP,"DSirc","Aurevoir!",0,string.char(127))
	Wifi.send(irc.socket,"PART "..tab_param.chan.."\n")
	popup.show()
	render()
	Wifi.send(irc.socket,"QUIT Aurevoir!\n")
	popup.show()
	render()
-- Pause for 2s to send the commands
	irc.pause(2)
	Wifi.closeSocket(irc.socket)
	popup.show()
	render()
end
Wifi.disconnect()
Wifi.stop()
render()
_VDSIRC = nil
tab_param = nil
delMiniWifiSignal()
luaWidget.del(fenP.parent)
popup.del()
fenP = nil
irc = nil


