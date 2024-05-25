SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1

-- initialize all background system
BGTopText = Screen.LoadTextBG()
BGTop8Bit = Screen.Load8BitBG()
BGBotText = Screen.LoadTextBG()
BGBot8Bit = Screen.Load8BitBG()

-- put the text in front of the 8 bit background
Screen.Initialize( SCREEN_TOP, BGTopText, BGTop8Bit )
-- put the text behind the 8 bit background
Screen.Initialize( SCREEN_BOTTOM, BGBot8Bit, BGBotText )

-- set up palette for both screen
BGTop8Bit:SetPaletteColor( 0,  0,  0,  0 )
BGTop8Bit:SetPaletteColor( 1, 16,  0,  0 )
BGTop8Bit:SetPaletteColor( 2,  0, 16,  0 )
BGTop8Bit:SetPaletteColor( 3, 16, 16,  0 )
BGBot8Bit:SetPaletteColor( 0,  0,  0,  0 )
BGBot8Bit:SetPaletteColor( 1, 16,  0,  0 )
BGBot8Bit:SetPaletteColor( 2,  0, 16,  0 )
BGBot8Bit:SetPaletteColor( 3, 16, 16,  0 )

-- display
nCount  = 0
nColor  = 0
while true do
  nCount  = nCount + 1

  -- print some text on top
  BGTopText:SetColor( 5 );
  BGTopText:PrintXY( 0, 0, "BGTopText-" .. tostring( BGTopText ) )
  BGTopText:PrintXY( 0, 1, "BGTop8Bit-" .. tostring( BGTop8Bit ) )
  BGTopText:PrintXY( 0, 3, tostring( nCount ) )
  BGTopText:PrintXY( 4, 10, "Text background in front" )
  BGTopText:PrintXY( 7, 12, "Press START to exit" )

  -- print some text on Bot
  BGBotText:SetColor( 5 );
  BGBotText:PrintXY( 0, 0, "BGBotText-" .. tostring( BGBotText ) )
  BGBotText:PrintXY( 0, 1, "BGBot8Bit-" .. tostring( BGBot8Bit ) )
  BGBotText:PrintXY( 0, 3, tostring( nCount ) )
  BGBotText:PrintXY( 5, 10, "Text background behind" )
  BGBotText:PrintXY( 7, 12, "Press START to exit" )

  for i=0,63 do
    nColor  = math.mod( i, 4 )
    x0      = ( 63 - i ) * 4
    y1      = i * 3
    nColor  = nColor + 1
    BGTop8Bit:Line( x0, 0, 0, y1, nColor )
    BGTop8Bit:Line( 255-x0, 191, 255, 191-y1, nColor )

    BGBot8Bit:Line( x0, 0, 0, y1, nColor )
    BGBot8Bit:Line( 255-x0, 191, 255, 191-y1, nColor )
  end

  -- user can press START to exit program
  if Pads.Start() then
    break
  end

  -- wait for VBL and repeat loop
  Screen.WaitForVBL()
end

