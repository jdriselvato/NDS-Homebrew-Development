----------------------------------------------------------
-- learn more about lua's io functions at:
-- http://www.lua.org/pil/21.html
----------------------------------------------------------

----------------------------------------------------------
-- function to open a file in text mode and reads it
-- line by line
----------------------------------------------------------
function textView( szFileName )
  local i = 0
  local line
  for line in io.lines ( szFileName ) do
    i = i + 1
    print( i .. "[" .. line .. "]" )
  end
end

----------------------------------------------------------
-- function to open a file in binary mode and display it
-- in hex
----------------------------------------------------------
function hexView( szFileName )
  local f = assert( io.open( szFileName, "rb" ) )
  local block = 10
  while true do
    local strResult = ""
    local bytes = f:read(block)
    if not bytes then break end
    for b in string.gfind(bytes, ".") do
      strResult = strResult .. ( string.format("%02X", string.byte( b ) ) )
    end
    strResult = strResult .. ( string.rep( "  ", block - string.len( bytes ) ) ) .. " "
    strResult = strResult .. string.gsub( bytes, "%c", "." )
    print( strResult )
  end
  f:close()
end


----------------------------------------------------------
-- main routine
----------------------------------------------------------
-- set up screens for text output
SCREEN_BOTTOM   = 0
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

textView( "02 - TextPadsStylus.lua" )
print( "Press any key to continue" )
DSLua.WaitForAnyKey()

hexView( "explosion.bmp" )
print( "Press any key to exit" )
DSLua.WaitForAnyKey()

