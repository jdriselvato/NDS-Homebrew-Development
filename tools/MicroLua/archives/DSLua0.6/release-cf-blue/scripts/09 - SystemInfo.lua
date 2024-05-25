-- set up screens for text output
SCREEN_BOTTOM   = 0
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- display all system info
BGBotText:Clear()
BGBotText:PrintXY( 0, 0, "Press START to exit" );
BGBotText:PrintXY( 0, 2, "Version: " .. DSLua.Version() )
BGBotText:PrintXY( 0, 3, DSLua.UserName() )
BGBotText:PrintXY( 0, 4, "BDay: " .. DSLua.BirthMonth() .. "/" .. DSLua.BirthDay() )
BGBotText:PrintXY( 0, 5, "Msg: " .. DSLua.UserMessage() )
if ( DSLua.Language() == 0 ) then
  BGBotText:PrintXY( 0, 6, "Lang: Japanese" )
elseif  ( DSLua.Language() == 1 ) then
  BGBotText:PrintXY( 0, 6, "Lang: English" )
elseif  ( DSLua.Language() == 2 ) then
  BGBotText:PrintXY( 0, 6, "Lang: French" )
else
  BGBotText:PrintXY( 0, 6, "Lang: Unknown(" .. DSLua.Language() .. ")" )
end
BGBotText:PrintXY( 0, 7, "Color: " .. DSLua.Color() )
BGBotText:PrintXY( 0, 8, "Alarm: " .. DSLua.AlarmHour() .. ":" .. DSLua.AlarmMin() )

while true do
  -- display time
  BGBotText:PrintXY( 0, 10, "Time: " .. ( 2000 + DSLua.Year() ) .. "/" .. DSLua.Month() .. "/" .. DSLua.Day() .. " " .. DSLua.Hour() .. ":" .. DSLua.Min() .. ":" .. DSLua.Sec() )
  BGBotText:PrintXY( 0, 11, "VBlankCount: " .. DSLua.VBlankCount() )
  if Pads.Start() then
    break
  end
end

