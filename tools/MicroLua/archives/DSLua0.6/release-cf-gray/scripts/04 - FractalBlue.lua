-- set up the screen
SCREEN_BOTTOM   = 0
SCREEN_TOP      = 1
BGTopBit8 = Screen.Load8BitBG()
BGBotText = Screen.LoadTextBG()
Screen.Initialize( SCREEN_TOP, BGTopBit8 )
Screen.Initialize( SCREEN_BOTTOM, BGBotText )

-- change this to select the view area
depth = 256
x0 = -0.65
y0 = -0.7
x1 = -0.5
y1 = -0.6

-- some nice palette
for i=0,(depth-2) do
	b = math.floor(i / depth * 128)
	if b > 31 then
		b = 31
	end
	g = math.floor((i - depth / 3) / depth * 128)
	if g > 31 then
		g = 31
	end
	if g < 0 then
		g = 0
	end
	r = math.floor((i - depth / 3 * 2) / depth * 128)
	if r > 31 then
		r = 31
	end
	if r < 0 then
		r = 0
	end
  BGTopBit8:SetPaletteColor( i, r, g, b )
end
BGTopBit8:SetPaletteColor( depth-1, 0, 0, 0 )

-- show instructions
BGBotText:PrintXY( 0, 0, "Please wait..." )

-- draw mandelbrot fractal
w = 255
h = 191
dx = x1 - x0
dy = y1 - y0
for y=0,h-1 do
	for x=0,w-1 do
		r = 0; n = 0; b = x / w * dx + x0; e = y / h * dy + y0; i = 0
		while i < depth-1 and r * r < 4 do
			d = r
      r = r * r - n * n + b
      n = 2 * d * n + e
      i = i + 1
		end
    BGTopBit8:Plot( x, y, i )
	end
end

while true do
  BGBotText:PrintXY( 0, 0, "Press any button to exit" )
  if Pads.AnyKey() then
    break
  end
  Screen.WaitForVBL()
end

