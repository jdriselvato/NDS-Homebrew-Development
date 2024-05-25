-- set up screens for text output
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- print some instructions
BGBotText:PrintXY( 0, 0, "Sound Check" )
BGBotText:PrintXY( 0, 2, "Press A for Blaster" )
BGBotText:PrintXY( 0, 3, "Press B for Ion" )
BGBotText:PrintXY( 0, 4, "Press X for Saber" )
BGBotText:PrintXY( 0, 5, "Press Y to start/stop music" )
BGBotText:PrintXY( 0, 7, "Press START to exit" )

-- load all sound effects into memory
SndBlaster  = Sound.LoadRaw( "blaster.raw" )
SndSaber    = Sound.LoadRaw( "saberoff.raw" )
SndIon      = Sound.LoadRaw( "ion.raw" )

-- load the mod music file and start playing
ModDK2      = Music.LoadMod( "dk2.mod" )
bModPlaying = true
ModDK2:Play()

-- enter play loop
while true do
  if Pads.A() then
    SndBlaster:Play()
    while Pads.A() do
    end
  end
  if Pads.B() then
    SndIon:Play()
    while Pads.B() do
    end
  end
  if Pads.X() then
    SndSaber:Play()
    while Pads.X() do
    end
  end
  if Pads.Y() then
    bModPlaying = ( not bModPlaying )
    if bModPlaying then
      ModDK2:Play()
    else
      ModDK2:Stop()
    end
    while Pads.Y() do
    end
  end
  if Pads.Start() then
    break
  end
  Screen.WaitForVBL()
end

-- always a good idea to free objects as soon as you can, so your game can use them for something else
ModDK2:Free()
ModDK2      = nil
SndIon:Free()
SndIon      = nil
SndSaber:Free()
SndSaber    = nil
SndBlaster:Free()
SndBlaster  = nil

