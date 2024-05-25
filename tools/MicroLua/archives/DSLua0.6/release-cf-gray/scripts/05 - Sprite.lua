-- initialize global vars
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1
PALETTE_SHIP    = 0
PALETTE_EXPL    = 1

-- init top screen for text outputs
BGTopText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_TOP, BGTopText )

-- show brief instruction
BGTopText:PrintXY( 0, 0, "Press any button to exit" )

-- load sprite palette 0 to palette in file 'vaisseau.bmp.pal', and palette 1 to palette in 'explosion.bmp.pal'
Sprite.LoadPalette( SCREEN_BOTTOM, PALETTE_SHIP, "vaisseau.bmp.pal" )
Sprite.LoadPalette( SCREEN_BOTTOM, PALETTE_EXPL, "explosion.bmp.pal" )

-- create a FrameStrip that can handle sprite 32x32 in 256 color mode to hold ship sprite frames
ShipFrames  = FrameStrip.Create( SCREEN_BOTTOM, 32, 32, "256" )

-- create a FrameStrip that can handle sprite 64x64 in 256 color mode to hold explosion sprite frames
ExplFrames  = FrameStrip.Create( SCREEN_BOTTOM, 64, 64, "256" )

-- load binary data into frame strip object
ShipFrames:LoadBin( "vaisseau.raw", 1 )
ExplFrames:LoadBin( "explosion.raw", 7 )

-- init variable to move sprite around
nX      = 29
nY      = 13
nVX     = 1
nVY     = 1
nFrame  = 0
nDelay  = 0

-- create a sprite using frame loaded
Expl  = Sprite.Create( ExplFrames, 0, PALETTE_EXPL, 255-nX, nY )
Ship  = Sprite.Create( ShipFrames, 0, PALETTE_SHIP, nX, nY )

-- some test objects to show all explosion animation frames
--Test1 = Sprite.Create( ExplFrames, 0, PALETTE_EXPL,   0,   0 )
--Test2 = Sprite.Create( ExplFrames, 1, PALETTE_EXPL,  64,   0 )
--Test3 = Sprite.Create( ExplFrames, 2, PALETTE_EXPL, 128,   0 )
--Test4 = Sprite.Create( ExplFrames, 3, PALETTE_EXPL, 192,   0 )
--Test5 = Sprite.Create( ExplFrames, 4, PALETTE_EXPL,   0,  64 )
--Test6 = Sprite.Create( ExplFrames, 5, PALETTE_EXPL,  64,  64 )
--Test7 = Sprite.Create( ExplFrames, 6, PALETTE_EXPL, 128,  64 )

function moveFromTo(ship, srcX, srcY, destX, destY, speed)
	moveX = (srcX - destX)/(srcY - destY)
	moveY = (srcY - destY)/(srcX - destX)
	srcX - destX / 256 * speed
	srcY - destY / 192 * speed
	ship:MoveTo()
end

-- main loop to update graphics and process inputs
while true do
  Ship:MoveTo( nX, nY )
  Expl:MoveTo( 255-nX, nY )
  Expl:SetFrame( ExplFrames, nFrame )

  -- bounce the ship off walls on the left and right
  nX  = nX + nVX
  if ( nX < 0 ) then
    nX  = -nX
    nVX = -nVX
  elseif ( nX > 255 ) then
    nX  = 255 - ( nX - 255 )
    nVX = -nVX
  end

  -- bounce the ship off walls on the top and bottom
  nY  = nY + nVY
  if ( nY < 0 ) then
    nY  = -nY
    nVY = -nVY
  elseif ( nY > 171 ) then
    nY  = 171 - ( nY - 171 )
    nVY = -nVY
  end

  -- cycle through the different explosion frames
  nDelay  = nDelay + 1
  if ( nDelay >= 8 ) then
    nDelay  = 0
    nFrame  = nFrame + 1
    if ( nFrame >= 7 ) then
      nFrame  = 0
    end
  end


  -- exit when user press a key
  if Pads.AnyKey() then
    break
  end

  -- wait for VBlank so we don't cause graphics tearing
  Screen.WaitForVBL()
end

-- always clean up after yourself to free up resources
-- set the sprites free
Ship:Free()
Expl:Free()
--Test7:Free()
--Test6:Free()
--Test5:Free()
--Test4:Free()
--Test3:Free()
--Test2:Free()
--Test1:Free()

-- free the frame strips
ShipFrames:FreeAll()
ShipFrames  = nil
ExplFrames:FreeAll()
ExplFrames  = nil


