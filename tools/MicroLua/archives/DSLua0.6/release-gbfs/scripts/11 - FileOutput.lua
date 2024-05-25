----------------------------------------------------------
-- learn more about lua's io functions at:
-- http://www.lua.org/pil/21.html
----------------------------------------------------------

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

-- lets try to open a file and write to it
fileName = "/cf/test.dat"
fout  = io.open( fileName, "wt" )
if not fout then
  print( "Failed to open: " .. fileName )
else
  print( "File opened successfully..." )
  -- now try to write something to it
  fout:write( string.format( "%f %f %f", 6.0, -3.23, 15e12 ) )
  fout:write( "Time: " .. ( 2000 + DSLua.Year() ) .. "/" .. DSLua.Month() .. "/" .. DSLua.Day() .. " " .. DSLua.Hour() .. ":" .. DSLua.Min() .. ":" .. DSLua.Sec() )
  fout:write( "Pi=", 3.1415, " ten=", 10, "." )
  fout:write( 1, 2, 3, " finished" )

  if not ( fout:close() ) then
    print( "Failed to close file" )
  else
    -- file closed properly, now view it
    print( "Write complete\n" )
    fout  = nil
    hexView( fileName )
  end
end

-- wait for a key press
print( "Press any button to cont..." )
DSLua.WaitForAnyKey()
print()

-- try to read in the numbers we wrote earlier
fin = io.open( fileName, "rb" )
if not fin then
  print( "Failed to open: " .. fileName )
else
  print( "File ready to read..." )
  local n1, n2, n3 = fin:read( "*number", "*number", "*number" )
  print( "read in [" .. n1 .."][" .. n2 .."][" .. n3 .. "]" )
  fin:close()
end

-- wait for some key presses before exiting
print( "Press START to exit..." )
repeat
  Screen.WaitForVBL()
until Pads.Start()


