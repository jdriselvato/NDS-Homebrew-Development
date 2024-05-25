-- initialize global vars
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1

-- init top screen for text outputs
BGTopText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_TOP, BGTopText )

-- print some instructions
BGTopText:PrintXY( 0, 0, "Press A to change corner tiles" )
BGTopText:PrintXY( 0, 1, "Use d-pad to scroll map" )
BGTopText:PrintXY( 0, 3, "Press START to exit" )

-- create a tiled background on bottom screen
BGBottomMap = Screen.LoadTileBG()

-- load map palette
BGBottomMap:LoadPalette( "map_examplescrn.bmp.pal" )

-- load 256-color tile data
BGBottomMap:LoadTiles( "map_examplescrn.raw", 256 )

-- load map data. Map is 320x240. Each tile is 8 pixel wide by 8 pixel tall
BGBottomMap:LoadMap( "map_examplescrn.map", ( 320 / 8 ), ( 240 / 8 ) )

-- init bottom screen with tiled map background
Screen.Initialize( SCREEN_BOTTOM, BGBottomMap )

-- main loop to update graphics and process inputs
nX    = 0
nY    = 0
nTile = 0
while true do
  -- scroll map in direction user specified, limit range to map size
  if Pads.Left() then
    nX = math.max( nX-1, 0 )
  end
  if Pads.Right() then
    nX = math.min( nX+1, 320-256)
  end
  if Pads.Up() then
    nY = math.max( nY-1, 0 )
  end
  if Pads.Down() then
    nY = math.min( nY+1, 240-192 )
  end

  -- demonstrate the tile changing function
  if Pads.A() then
    nTile = math.mod( ( nTile + 1 ), 10 )
    BGBottomMap:SetMapTile(  0,  0, nTile )
    BGBottomMap:SetMapTile( 39,  0, nTile )
    BGBottomMap:SetMapTile(  0, 29, nTile )
    BGBottomMap:SetMapTile( 39, 29, nTile )
  end

  -- user wants to exit
  if Pads.Start() then
    break
  end

  -- scroll the on screen map to a new position
  BGBottomMap:ScrollXY( nX, nY )
  Screen.WaitForVBL()
end

