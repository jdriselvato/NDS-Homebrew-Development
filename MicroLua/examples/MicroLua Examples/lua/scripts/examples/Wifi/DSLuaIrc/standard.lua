_VSTANDARD = 0.1

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

