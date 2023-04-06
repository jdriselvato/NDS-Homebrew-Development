DBus = {}
_VDBUS = 0.12

DBus.listMess = {}
-- DBus.listMess.name = Nom de la variable
-- DBus.listMess.value = Valeur de la variable
-- DBus.listMess.born = Date de création du message
-- DBus.listMess.life = Durée de vie de la variable en seconde ou une des trois variables ci-dessous
--                      (?)max 10min(?)
DBus.MAX = 600   -- Temps maximum autorisé
DBus.ALWAYS = -1 -- Vie jusqu'à l'extinction de la console
DBus.FIRSTR = -2 -- Vie jusqu'à la première lecture

DBus.newMess = function(name, value, life)
	assert(name ~= nil, "name ne peut pas etre nil")
	assert(value ~= nil, "value ne peut pas etre nil")
	assert(life ~= nil, "life ne peut pas etre nil")
	local buff = {}
	--local date = DateTime.getCurrentTime()
	buff.name = name
	buff.value = value
	buff.born = os.time()
	--buff.born = {}
	--buff.born.minute = date.minute
	--buff.born.second = date.second
	if(life > DBus.MAX) then life = DBus.MAX end
	buff.life = life
	table.insert(DBus.listMess,buff)
end

DBus.readMess = function(name)
	assert(name ~= nil, "name ne peut pas etre nil")
	local i, t1, t2, num
	--local date = DateTime.getCurrentTime()
	i = 1
	while(i <= #DBus.listMess) do
		if(DBus.listMess[i].life > -1) then
			--t1 = ((DBus.listMess[i].born.minute * 60)+ DBus.listMess[i].born.second )
			--	+ DBus.listMess[i].life
			--t2 = (date.minute * 60)+ date.second
			t1 = DBus.listMess[i].born + DBus.listMess[i].life
			t2 = os.time()
		else
			t2 = 1
			t1 = 2
		end
		if(t2 > t1) then DBus.delMess(DBus.listMess[i].name) 
		else i = i+1 end
	end
	num = 0
	i = 1
	while(i <= #DBus.listMess and num == 0) do
		if(DBus.listMess[i].name == name) then num = i
		else i = i+1 end
	end
	if(num > 0) then
		local buff
		buff = DBus.listMess[num].value
		if(DBus.listMess[num].life == DBus.FIRSTR) then DBus.delMess(DBus.listMess[num].name) end
		num = buff
	end
	return num
end

DBus.delMess = function(name)
	assert(name ~= nil, "name ne peut pas etre nil")
	local num = 0
	local i = 1
	while(i <= #DBus.listMess and num == 0) do
		if(DBus.listMess[i].name == name) then num = i
		else i = i+1 end
	end
	if(num > 0) then table.remove(DBus.listMess,num) end
end

DBus.del = function()
	local i,j
	j = #DBus.listMess
	for i=1, j do
		table.remove(DBus.listMess,1)
	end
	DBus = nil
	_VDBUS = nil
end

