-- this script tests the text printing routines
-- set up screens for text output
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1
BGTopText = Screen.LoadTextBG()
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_TOP, BGTopText )
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- init vars
nOldX, nOldY    = 0, 0
nNewX, nNewY    = 0, 0
nRealX, nRealY  = 0, 0
noPressCounter = 0

-- clear screen and draw a border
BGBotText:Clear()
BGBotText:SetColor( 6 )
BGBotText:FillRectWithChar( 0, 0, 31, 23, "X" )
BGBotText:FillRectWithChar( 1, 1, 30, 22, " " )
BGBotText:SetColor( 5 )
BGBotText:PrintXY( 10, 0, " Input Test " )

-- now check buttons
while true do
  -- play with stylus
  bStylusNewPress = Stylus.NewPress()
  bStylusDown = Stylus.Down()
  bStylusReleased = Stylus.Released()
  nRealX  = Stylus.X()
  nRealY  = Stylus.Y()
  nNewX   = math.floor( nRealX / 8 )
  nNewY   = math.floor( nRealY / 8 )

  -- move dot using stylus position
  if bStylusNewPress  then
    -- erase old spot and draw at new spot
    BGTopText:PrintXY( nOldX, nOldY, " " )
    BGTopText:PrintXY( nNewX, nNewY, "1" )
    nOldX, nOldY  = nNewX, nNewY
  end
  if bStylusDown  then
    -- erase old spot and draw at new spot
    BGTopText:PrintXY( nOldX, nOldY, " " )
    BGTopText:PrintXY( nNewX, nNewY, "2" )
    nOldX, nOldY  = nNewX, nNewY
  end
  if bStylusReleased  then
    -- erase old spot and draw at new spot
    BGTopText:PrintXY( nOldX, nOldY, " " )
    BGTopText:PrintXY( nNewX, nNewY, "3" )
    nOldX, nOldY  = nNewX, nNewY
  end

  -- only erase part of the screen
  BGBotText:FillRectWithChar( 2, 2, 30, 14, " " )

  -- display all pad status
  BGBotText:SetColor( 2 )
  BGBotText:PrintXY( 2,  2, "A                 = " .. tostring( Pads.A() ) )
  BGBotText:PrintXY( 2,  3, "B                 = " .. tostring( Pads.B() ) )
  BGBotText:PrintXY( 2,  4, "X                 = " .. tostring( Pads.X() ) )
  BGBotText:PrintXY( 2,  5, "Y                 = " .. tostring( Pads.Y() ) )
  BGBotText:PrintXY( 2,  6, "R                 = " .. tostring( Pads.R() ) )
  BGBotText:PrintXY( 2,  7, "L                 = " .. tostring( Pads.L() ) )
  BGBotText:PrintXY( 2,  8, "Up                = " .. tostring( Pads.Up() ) )
  BGBotText:PrintXY( 2,  9, "Down              = " .. tostring( Pads.Down() ) )
  BGBotText:PrintXY( 2, 10, "Left              = " .. tostring( Pads.Left() ) )
  BGBotText:PrintXY( 2, 11, "Right             = " .. tostring( Pads.Right() ) )
  BGBotText:PrintXY( 2, 12, "Select            = " .. tostring( Pads.Select() ) )
  BGBotText:PrintXY( 2, 13, "Stylus New Press  = " .. tostring( bStylusNewPress ) )
  BGBotText:PrintXY( 2, 14, "Stylus Down       = " .. tostring( bStylusDown ) )
  BGBotText:PrintXY( 2, 15, "Stylus Released   = " .. tostring( bStylusReleased ) )
  BGBotText:PrintXY( 2, 16, "StylusXY = " .. nRealX .. "," .. nRealY )

  BGBotText:SetColor( 0 )
  BGBotText:PrintXY( 2, 17, "Press Start to exit..." )

  -- user can press START to exit program
  if Pads.Start() then
    break
  end

  Screen.WaitForVBL()
end

