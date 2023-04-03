_VSTANDARD = 0.14

function square(x1, y1, x2, y2)
	local k_re = {"x1", "y1", "x2", "y2"}
	k_re.x1 = x1
	k_re.y1 = y1
	k_re.x2 = x2
	k_re.y2 = y2
	return k_re
end

function estDedans(x,y,carre)
	local res = false
	if x > carre.x1 and x < carre.x2 then
		if y > carre.y1 and y < carre.y2 then
			res = true
		end
	end
	return res
end

function find(dossierDep, nom, graph, appelDir)
	local ancDir = System.currentDirectory()
	local lDir, cDir
	local lFound = {}
	local lBuff = {}
	local i, j, file
	local cpt = 1
	if(graph == nil) then graph = false end
	Controls.read()
	System.changeDirectory(dossierDep)
	cDir = System.currentDirectory()
	if(appelDir ~= nil) then
		if(cDir == appelDir) then
			return {}
		end
	end
	lDir = System.listDirectory(cDir)
--*********
	if(graph) then 
		screen.print(SCREEN_DOWN,1,1,dossierDep)
		for i, file in pairs(lDir) do
			screen.print(SCREEN_DOWN,1,cpt*10,file.name)
			cpt = cpt+1
		end
		render()
	end
--*********
	for i, file in pairs(lDir) do
		if(file.name ~= "." and file.name ~= "..") then
			if(string.lower(file.name) == string.lower(nom)) then
				table.insert(lFound,cDir.."/"..file.name)
			end
			if(file.isDir) then
				lBuff = find(dossierDep.."/"..file.name,nom,graph,cDir)
				for j = 1,#lBuff do
					table.insert(lFound,lBuff[j])
				end
			end
		end
	end
	System.changeDirectory(ancDir)
	return lFound
end

loadLib = function(list)
	local rep = {}
	local i,j
	for i,j in ipairs(list) do
		if(package.loaded[j] == nil) then
			require(j)
			table.insert(rep,j)
		end
	end
	return rep
end

unloadLib = function(list)
	local i,j
	for i=#list,1,-1 do
		j = list[i]
		assert(loadstring(j..".del()"))()
		package.loaded[j] = nil		
	end
end

pause = function()
	Controls.read()
	Debug.ON()
	Debug.clear()
	Debug.setColor(Color.new(31,0,0))
	while(not Keys.newPress.Y) do
		Controls.read()
		screen.print(SCREEN_UP,0,0,"Appuyer sur Y pour continuer")
		render()
	end
	Debug.clear()
end

function delStandard()
	square = nil
	estDedans = nil
	find = nil
	loadLib = nil
	unloadLib = nil
	package.loaded.standard = nil
	delStandard = nil
end
