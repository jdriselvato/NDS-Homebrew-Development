--[[

DEFAULT MYBOOT
==============
        
        
Based on Christophe "Grahack" Gragnic's idea in October 2009
Written by Reylak
http://microlua.xooit.fr
http://sourceforge.net/p/microlua/

    
--------------------------------------------------------------

   Here is the default example of "myboot.lua".
   Please note that it is *NOT* loaded by
   "boot.lua". If you want to, rename it as
   "myboot.lua".

]]


--[[ If you are running MicroLua on a 3DS, you are victim of a libnds's bug that prevent
    time of being updated. If this is the case, activate "myboot.lua" as explained above
    so the following lines are used; they replace Lua's built-in functions by corrected
    versions. More information can be found on https://sourceforge.net/p/microlua/wiki/3DSTimeWorkaround/
    You will probably have to comment the other ones for they are not useful and may
    lead to unexpected behaviours. ]]
os.time = os.time3DS
os.date = os.date3DS

--[[ You may wish to change the directory open by default, that is to say the "scripts" directory.
    The same manipulation can be used to change other constants.
    The complete list of these constants can be found here:
    https://sourceforge.net/p/microlua/wiki/APIDocumentation/ ]]
ULUA_SCRIPTS = "/lua/myOwnScriptsDir/"

-- You may wish to specify a fake version (you evil).
ULUA_VERSION = "1.3.37"

-- You may wish to change the directory used to store the libs loaded with "require" (or at least, define it...).
package.path = "lua/libs/?.lua"

-- You may wish to write some log on MicroLua's opening.
local file = io.open("/lua/microlua.log", "a")
file:write("Hello world.")
file:close()


-- And finally, if you wish to come back to the "normal" bootstrap (which is the best thing to do).
return "continue"
