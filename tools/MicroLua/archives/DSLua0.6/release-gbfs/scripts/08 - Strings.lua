----------------------------------------------------------
-- learn more about lua string functions at:
-- http://www.gammon.com.au/scripts/doc.php?general=lua_string
----------------------------------------------------------

-- set up screens for text output
SCREEN_BOTTOM   = 0
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- print various string function output
print( string.byte( "ABC" ) )
print( string.byte( "ABC", 2 ) )

-- test string find routine
print( string.find( "the quick brown fox", "quick" ) )
print( string.find( "the quick brown fox", "(%a+)" ) )
print( string.find( "the quick brown fox", "(%a+)", 10 ) )
print( string.find( "the quick brown fox", "fruit" ) )

-- some string sub functions
print( string.sub( "ABCDEF", 2, 3 ) )
print( string.sub( "ABCDEF", 3 ) )
print( string.sub( "ABCDEF", -1 ) )

-- test equality
if ( string.sub( "BAD", 2, 2 ) == "A" ) then
  print( "Equal" )
else
  print( "Not Equal" )
end

-- wait for a key press before exiting
print( "Press any key to exit" )
DSLua.WaitForAnyKey()

