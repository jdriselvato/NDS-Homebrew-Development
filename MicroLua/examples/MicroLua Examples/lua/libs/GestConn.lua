
_VGESTCONN = 0.43
GestConn = {}
dofile("Clavier.lua")
libClavier.activeScreen(clavv,true)	-- On active l'ecran texte du clavier

lAP = {}			-- Liste des APs
li = 0				-- numero de la ligne
conn = 0			-- connection
tps = Timer.new()	-- timer de refresh des AP trouvés
tps:start()
sel = 1				-- selection actuelle
i = 0
quit = false		
enr = true			-- enregistrement de la connection?

Wifi.initDefault()		-- Initialisation du Wifi
listeAPM = {}			-- Liste des AP Mémorisés
fichier = io.open("/lua/libs/lapm.ini","r")
if(fichier) then		-- création de la liste APM si il y en à une.
	key = fichier:read("*l")
	while(key ~= nil) do
		value = fichier:read("*l")
		listeAPM[key] = value
		key = fichier:read("*l")
	end
	fichier:close()
end
key = nil
value = nil
fichier = nil
collectgarbage("collect")

-- Configuration du mode scan du wifi
Wifi.scanAP()

-- ********************************************************
-- * saveLAPM()
-- ********************************************************
-- *                     DESCRIPTION
-- * Enregistre le fichier des connections connues
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local saveLAPM = function()
	local fich, key, value
	fich = io.open("/lua/libs/lapm.ini","w")
	for key, value in pairs(listeAPM) do
		fich:write(key.."\n"..value.."\n")
	end 
	fich:close()
end

-- ********************************************************
-- * addConnectionLAPM(ssid, wepkey)
-- ********************************************************
-- *                     DESCRIPTION
-- * Ajoute un enregistrement à la liste des points
-- * d'acces connu.
-- ********************************************************
-- *                      ENTREE(S)
-- * ssid : Le nom du réseau
-- * wepkey : la clef WEP
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local addConnectionLAPM = function(ssid,wepkey)
	local exist = true
	if(listeAPM[ssid] == nil) then
		exist = false
		listeAPM[ssid] = wepkey
		saveLAPM()
	end
	return not exist
end

-- ********************************************************
-- * delConnectionLAPM(ssid)
-- ********************************************************
-- *                     DESCRIPTION
-- * Supprime de la liste des connections connues la 
-- * connection du nom de ssid
-- ********************************************************
-- *                      ENTREE(S)
-- * ssid : Le nom de la connection à supprimer
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local delConnectionLAPM = function(ssid)
	local exist = false
	if(listeAPM[ssid] ~= nil) then
		exist = true
		listeAPM[ssid] = nil
		saveLAPM()
	end
	return exist
end

-- ********************************************************
-- * listeWifiAP()
-- ********************************************************
-- *                     DESCRIPTION
-- * Crée la liste des APs trouvés
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local listeWifiAP = function()
	local nbap = 0
	local liste = {}
	nbap = Wifi.getNumAP()
	for i=1, nbap do
		table.insert(liste, Wifi.getAP(i))
	end
	return liste
end

-- ********************************************************
-- * printInfoIP()
-- ********************************************************
-- *                     DESCRIPTION
-- * Affiche les informations de la connection:
-- * comme l'IP, le Gateway, le subnetMask, les DNS
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local printInfoIP = function()
	local i
	local IPInfo = {}
	for i=1, 6 do
		IPInfo[i] = Wifi.getLocalConf(i)
	end
	screen.print(SCREEN_UP,1,120,"IP: "..IPInfo[1])
	screen.print(SCREEN_UP,1,129,"Gateway: "..IPInfo[2])
	screen.print(SCREEN_UP,1,138,"SubnetMask: "..IPInfo[3])
	screen.print(SCREEN_UP,1,147,"DNS1: "..IPInfo[4])
	screen.print(SCREEN_UP,1,156,"DNS2: "..IPInfo[5])
	if(IPInfo[6] ~= nil) then
		screen.print(SCREEN_UP,1,167,"MACADDR: "..IPInfo[6])
	end
end

-- ********************************************************
-- * delGestCon(all)
-- ********************************************************
-- *                     DESCRIPTION
-- * Supprime de la mémoire les variables et fonction
-- * de ce script
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
GestConn.del = function()
	libClavier.del(clavv)
	nbap = nil
	i = nil
	lAP = nil
	li = nil
	conn = nil
	sel = nil
	tps:stop()
	tps = nil
	enr = nil
	Wifi.numAP = nil
	del_GestCon = nil
	collectgarbage("collect")
end

-- ********************************************************
-- * Connection(clef)
-- ********************************************************
-- *                     DESCRIPTION
-- * Associe la DS au réseau choisi
-- ********************************************************
-- *                      ENTREE(S)
-- *clef : la clef WEP
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local Connection = function(clef)	
	Wifi.disconnect()	-- On s'assure que l'on est pas connecter ailleurs
	Wifi.resetIP()		-- On demande de nouvelles adresses
	if(Wifi.connectAP(sel,1,clef)) then	-- On associe la DS à l'AP
	conn = 1 else conn = 2 end
end

-- ********************************************************
-- * entrer_cle()
-- ********************************************************
-- *                     DESCRIPTION
-- * Récupère en affichant un clavier la clef WEP et 
-- * Associe la DS à ce réseau
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local entrer_cle = function()
	local clef = ""
	local buff = ""
	local err = ""
	local ok
	local buffer = "Connexion à "..lAP[sel].ssid
	if(lAP[sel].protection == "WEP") then
		if(listeAPM[lAP[sel].ssid] ~= nil) then libClavier.setText(clavv,listeAPM[lAP[sel].ssid])
		else libClavier.setText(clavv,"") end
		while(buff ~= "Enter" and buff ~= "Esc") do
			screen.print(SCREEN_DOWN,0,10,"Veuillez entrer la clef WEP")
			screen.print(SCREEN_UP,128-(string.len(buffer)*3),20,buffer)
			if(err ~= "") then screen.print(SCREEN_DOWN,0,19,err) end
			libClavier.show(clavv)
			Controls.read()
			if(Stylus.newPress) then
				buff = libClavier.held(clavv, Stylus.X, Stylus.Y)
			end
			if(buff == "Enter") then
				clef = libClavier.getText(clavv)
				if(string.len(clef) > 26) then 
					err = "!! Clé trop grande."
				else
					err = ""
				end
				if(err ~= "") then buff = "" end
			end
			render()
		end
	end
	render()
	if(buff ~= "Esc" and lAP[sel].protection ~= "WPA") then
		Connection(clef)
		if(enr) then
			delConnectionLAPM(lAP[sel].ssid)
			addConnectionLAPM(lAP[sel].ssid,clef)
		end 
	end
end

-- ********************************************************
-- * verif_stylus()
-- ********************************************************
-- *                     DESCRIPTION
-- * Verification des clics du stilet et action en conséquance
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
local verif_stylus = function()
	local x = Stylus.X
	local y = Stylus.Y
	if(Stylus.newPress) then
		-- appuis sur la liste des APs
		if(estDedans(x,y,square(1,1,243,162))) then
			sel = math.floor((y-1)/24)+1
			if(sel > #lAP) then sel = #lAP end
		end
		-- appuis sur annuler
		if(estDedans(x,y,square(19,174,109,190))) then
			quit = true
		end
		-- appuis sur connecter
		if(estDedans(x,y,square(156,174,240,190))) then
			if(listeAPM[lAP[sel].ssid] ~= nil) then Connection(listeAPM[lAP[sel].ssid])
			else entrer_cle() end
		end
		-- appuis sur enregistrer
		if(estDedans(x,y,square(45,164,211,172))) then
			enr = not enr
		end
		-- appuis sur entrer cle
		if(estDedans(x,y,square(137,174,154,190))) then
			entrer_cle()
		end
		-- appuis sur supprimer
		if(estDedans(x,y,square(1,174,17,190))) then
			if(#lAP > 0) then
				if(listeAPM[lAP[sel].ssid]~= nil) then
					delConnectionLAPM(lAP[sel].ssid)
				end
			end
		end
	elseif(Stylus.held) then
		-- appuis dans la barre de defilement
		if(estDedans(x,y,square(245,1,255,162))) then
			
		end
	end
end

-- ********************************************************
-- * 
-- ********************************************************
-- *                     DESCRIPTION
-- * Boucle principale
-- ********************************************************
-- *                      ENTREE(S)
-- *
-- ********************************************************
-- *                      SORTIE(S)
-- *
-- ********************************************************
while(not quit)do
	Controls.read()				-- Lecture de l'état des touches
	if(tps:getTime() > 500) then	-- On met à jour la liste des AP toutes les 500ms 
		lAP = listeWifiAP()
		tps:reset()
		tps:start()
	end
	-- Affichage des données sur l'écran du dessus
	screen.print(SCREEN_UP,50,0,"Gestionnaire de connexions")
	screen.print(SCREEN_UP,170,40,"Version :".._VGESTCONN)
	screen.print(SCREEN_UP,170,55,"PAPY 11/2010")
	screen.drawRect(SCREEN_UP,2,88,254,141,Color.new(29,16,16))
	screen.print(SCREEN_UP,104,90,"Légende:")
	screen.drawFillRect(SCREEN_UP,10,108,19,117,Color.new(7,11,24))
	screen.print(SCREEN_UP,22,110,"Connexion active.")
	screen.drawFillRect(SCREEN_UP,10,118,19,127,Color.new(4,16,4))
	screen.print(SCREEN_UP,22,120,"Connexion active connue.")
	screen.drawFillRect(SCREEN_UP,10,128,19,137,Color.new(31,8,0))
	screen.print(SCREEN_UP,22,130,"Connexion inactive.")
	screen.print(SCREEN_UP,62,182,"Points d'Accès Trouvés :")
	-- Affichage de la liste trouvé sur l'écran du bas
	li = 1
	for i=1, #lAP do
		local coulc, coult
		if(lAP[i].active) then
			if(listeAPM[lAP[i].ssid] == nil) then
				coulc = Color.new(7,11,24)
				coult = Color.new(0,23,31)
			else
				coulc = Color.new(4,16,4)
				coult = Color.new(15,30,0)
			end
		else	
			coulc = Color.new(31,8,0)
			coult = Color.new(31,20,0)	
		end
		screen.drawFillRect(SCREEN_DOWN,1,li,243,li+21,coulc)
		screen.print(SCREEN_DOWN,10,li+2,lAP[i].ssid,coult)
		screen.print(SCREEN_DOWN,20,li+12,"Ch:"..lAP[i].channel,coult)
		if(lAP[i].adhoc) then screen.print(SCREEN_DOWN,96,li+12,"ADHOC",coult) end
		screen.print(SCREEN_DOWN,150,li+12,lAP[i].protection,coult)
		screen.print(SCREEN_DOWN,211,li+12,math.floor((lAP[i].rssi*100)/175).."%",coult)
		li = li+24
	end
	-- Dessin des boutons du menu
	screen.drawRect(SCREEN_DOWN,245,1,255,162,Color.new(29,16,16))
	screen.drawRect(SCREEN_DOWN,45,164,53,172,Color.new(22,22,22))
	-- Remplissage de la case d'enregistrement si demandée
	if(enr) then screen.drawFillRect(SCREEN_DOWN,46,165,52,171,Color.new(15,31,0)) end
	screen.print(SCREEN_DOWN,55,164,"Enregistrer la connection.")
	screen.drawFillRect(SCREEN_DOWN,156,174,240,190,Color.new(5,19,31))
	screen.print(SCREEN_DOWN,158,178,"[A]Connection",Color.new(0,0,0))
	screen.drawFillRect(SCREEN_DOWN,19,174,109,190,Color.new(31,31,12))
	screen.print(SCREEN_DOWN,21,178,"[Start]Annuler",Color.new(0,0,0))
	-- Si l'AP est enregistrer dessin de l'option de suppression et de modification de la clef
	if(#lAP > 0) then
		if(listeAPM[lAP[sel].ssid] ~= nil) then
			screen.drawFillRect(SCREEN_DOWN,1,174,17,190,Color.new(31,8,0))
			screen.print(SCREEN_DOWN,6,178,"X",Color.new(31,20,0))
			screen.drawFillRect(SCREEN_DOWN,137,174,154,190,Color.new(10,20,31))
			screen.print(SCREEN_DOWN,142,178,string.char(14),Color.new(10,27,31))
		end
	end
	screen.print(SCREEN_DOWN,1,((sel-1) * 24)+9,">",Color.new(0,0,0))
	-- Verification des touches appuyée
	if(Keys.newPress.Up) then
		sel = sel -1
		if(sel == 0) then sel = 1 end
	end
	if(Keys.newPress.Down) then
		sel = sel +1
		if(sel > #lAP) then sel = #lAP end
	end
	if(Keys.newPress.A) then
		if(listeAPM[lAP[sel].ssid] ~= nil) then Connection(listeAPM[lAP[sel].ssid])
		else entrer_cle() end
	end
	if(Keys.newPress.Start) then
		quit = true
	end
	-- Verification de l'appuis du stylet
	verif_stylus()
	-- Si la connexion est réussie, on quitte le gestionnaire
	if(conn == 1) then
		quit = true
		
	end
	--printInfoIP()
	render()
end

if(conn == 1) then Wifi.numAP = sel  -- Création de la variable Wifi.numAP et enr. du numéro de l'AP selectionné
else Wifi.numAP = -1 end


