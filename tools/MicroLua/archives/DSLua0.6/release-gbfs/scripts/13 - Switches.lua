-- set up screens for text output
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- print some instructions
BGBotText:PrintXY( 0, 0, "Lights, LEDs, Lids, and Screens" )
BGBotText:PrintXY( 0, 2, "Press A to Toggle Bottom Light" )
BGBotText:PrintXY( 0, 3, "Press B to Toggle Top Light" )
BGBotText:PrintXY( 0, 4, "Press X to Toggle LED Blinking" )
BGBotText:PrintXY( 0, 5, "Press Y to Toggle LED Speed" )
BGBotText:PrintXY( 0, 6, "Press L to Toggle Screens" )
BGBotText:PrintXY( 0, 7, "Close DS to Toggle Lid Indicator" )
BGBotText:PrintXY( 0, 8, "Press START to exit" )

screenLight0Status = 1
screenLight1Status = 1
ledBlinking = 0
ledSpeed = 0

-- enter play loop
while true do
  if Pads.A() then
    if screenLight0Status == 1 then
	  screenLight0Status = 0
    else
      screenLight0Status = 1
    end
    DSLua.SetScreenLight(0, screenLight0Status)
    while Pads.A() do
    end
  end
  if Pads.B() then
    if screenLight1Status == 1 then
	  screenLight1Status = 0
    else
      screenLight1Status = 1
    end
    DSLua.SetScreenLight(1, screenLight1Status)
    while Pads.B() do
    end
  end
  if Pads.X() then
    if ledBlinking == 1 then
	  ledBlinking = 0
    else
      ledBlinking = 1
    end
    DSLua.SetLedBlink(ledBlinking, ledSpeed)
    while Pads.X() do
    end
  end
  if Pads.Y() then
    if ledSpeed == 1 then
	  ledSpeed = 0
    else
      ledSpeed = 1
    end
    DSLua.SetLedBlink(ledBlinking, ledSpeed)
    while Pads.Y() do
    end
  end
  if Pads.L() then
    DSLua.SwitchScreens()
    while Pads.L() do
    end
  end
  if DSLua.LidClosed() then
    DSLua.SetScreenLight(0, 0)
    DSLua.SetScreenLight(1, 0)
    DSLua.SetLedBlink(1, 1)
    while DSLua.LidClosed() do
	
    end
    DSLua.SetLedBlink(ledBlinking, ledSpeed)
    DSLua.SetScreenLight(0, screenLight0Status)
    DSLua.SetScreenLight(1, screenLight1Status)
  end
  if Pads.Start() then
    break
  end
  Screen.WaitForVBL()
end

