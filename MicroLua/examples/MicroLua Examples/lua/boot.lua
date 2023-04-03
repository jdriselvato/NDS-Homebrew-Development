--[[

        ==>[ MICROLUA BOOTSTRAP ]<==
        
        
   # Based on Christophe "Grahack" Gragnic's #
   #                idea in October 2009                #

    
같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

 The purpose of this file is to be an independant
 launcher of MicroLua. Thus it is meant to not be
 changed.

 You can override this file by writing a new one
 with the name "myboot.lua", in the same "/lua"
 directory.
 Then, if you want "boot.lua" to be executed just
 after this one, make it return the String "continue".

]]--


local function loadMyboot()
    local msg = dofile("/lua/myboot.lua")
    return msg
end
mybootLoaded, msg = pcall(loadMyboot)

if not mybootLoaded and not msg:match("cannot open /lua/myboot.lua") then
    -- An error occured while running the special bootstrap.
    local file = io.open("/lua/microlua.log", "a")
    file:write("<myboot>" .. tostring(msg) .. "</myboot>\n")
    file:close()
elseif mybootLoaded then
    -- The special bootstrap has been found, and no error occured while running it.
    -- We can exit here if it is not asked to continue.
    if msg ~= "continue" then os.exit() end
end

msg = nil
mybootLoaded = nil

-- And finally, let's launch MicroLua :)
dofile(ULUA_LIBS .. "/libs.lua")
