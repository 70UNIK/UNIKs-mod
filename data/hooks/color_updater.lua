--Only runs if jen is not installed just for the rgb effect
local function hsv2(h, s, v)
    if s <= 0 then return v,v,v end
    h = h*6
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return r+m, g+m, b+m
end
local game_updateref2 = Game.update
function Game:update(dt)
    game_updateref2(self, dt)
    if G.ARGS.LOC_COLOURS then

		local r, g, b = hsv2(self.C.jen_RGB_HUE / 360, .5, 1)

		self.C.jen_RGB[1] = r
		self.C.jen_RGB[3] = g
		self.C.jen_RGB[2] = b

		self.C.jen_RGB_HUE = (self.C.jen_RGB_HUE + 0.5) % 360
		G.ARGS.LOC_COLOURS.jen_RGB = self.C.jen_RGB
		
	end
end