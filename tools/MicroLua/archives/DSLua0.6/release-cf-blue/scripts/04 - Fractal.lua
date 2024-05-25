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

nR  = 0
nG  = 0
nB  = 0
nDiff = 4
for nLoop=0,(depth-1) do
  BGTopBit8:SetPaletteColor( nLoop, nR, nG, nB )
  nR  = nR+nDiff
  if nR>31 then
    nR  = 0
    nG  = nG+nDiff
  end
  if nG>31 then
    nG  = 0
    nB  = nB+nDiff
  end
  if nB>31 then
    nB=0
  end
end;

-- show instructions
BGBotText:PrintXY( 0, 0, "Please wait..." )

function multByAdding(a,b)
	c = 0
	for d=0,b do
		c = c + a
	end
	return c
end

-- draw mandelbrot fractal
w = 256
h = 192
dx = x1 - x0
dy = y1 - y0
for y=0,h-1 do
	for x=0,w-1 do
		r = 0; n = 0; b = multByAdding(x / w, dx) + x0; e = multByAdding(y / h, dy) + y0; i = 0
		while i < depth-1 and multByAdding(r, r) < 4 do
			d = r
      r = multByAdding(multByAdding(r, r) - n, n) + b
      n = multByAdding(multByAdding(2, d), n) + e
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

