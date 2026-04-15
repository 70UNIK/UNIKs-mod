--suggested by https://github.com/70UNIK/UNIKs-mod/issues/9
--displays a little indicator of the type of buff provided by summit cards and/or joker such as hiker and maya
UNIK.perma_bonus_coords = {
    on_score = {
        {key = "perma_e_chips", pos = {x = 0, y = 0}},
        {key = "perma_x_chips", pos = {x = 1, y = 0}},
        {key = "perma_bonus", pos = {x = 2, y = 0}},
        {key = "perma_e_mult", pos = {x = 0, y = 1}},
        {key = "perma_x_mult", pos = {x = 5, y = 0}},
        {key = "perma_mult", pos = {x = 4, y = 0}},
        {key = "perma_p_dollars", pos = {x = 3, y = 0}},
        {key = "perma_repetitions", pos = {x = 1, y = 2}},
        {key = "perma_rescores", pos = {x = 3,y = 2}},
    },
    on_held = {
        {key = "perma_h_x_chips", pos = {x = 1, y = 1}},
        {key = "perma_h_chips", pos = {x = 2, y = 1}},
        {key = "perma_h_x_mult", pos = {x = 5, y = 1}},
        {key = "perma_h_mult", pos = {x = 4, y = 1}},
        {key = "perma_h_dollars", pos = {x = 3, y = 1}},
    },
}

--Full credit to Paperback and Meta for the paperback implementation;

local ALL_OFFSET_X = -6
local ALL_OFFSET_Y = -40
-- local SCORE_OFFSET_X = -6
-- local DEFAULT_OFFSET_X = -35
-- local DEFAULT_OFFSET_Y = -40
-- local BLINDSIDE_RADI = -40
-- local BLINDSIDE_HELD_RADI = -35
-- local HELD_OFFSET_X = -1
local HEIGHT = (SMODS.Mods["paperback"] or {}).can_load and 7 or 5 
local GAP = 1

SMODS.Atlas {
	key = "unik_indicators",
	px = 71,
	py = 95,
	path = "unik_indicators.png",

	inject = function(self)
		SMODS.Atlas.inject(self)

		for _, side in pairs(UNIK.perma_bonus_coords) do
		for _, v in ipairs(side) do
			v.sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, self, v.pos)
		end
		end
	end
}

local function should_draw_indicator(card, key)
	return card and card.ability
		and type(card.ability[key]) == "number"
		and card.ability[key] > 0
		and card.area and card.area.config.type ~= 'deck'
end

local function draw_single_indicator(card, sprite, x_offset, y_offset,rotation)
	x_offset = (card.T.w / 71) * (x_offset or 0) * card.T.scale
	y_offset = (card.T.h / 95) * (y_offset or 0) * card.T.scale

	sprite.role.draw_major = card
	sprite:draw_shader(
		(card.greyed and 'played') or 'dissolve',
		nil, nil, nil,
		card.children.center,
		nil, rotation,
		x_offset, y_offset
	)
end

local function degree_to_Radian(angle)
	return angle*math.pi/180
end
local function draw_indicators(indicators, card, x_offset, y_offset,radi)
	local y = y_offset or 0
	local x = x_offset or 0

	--rotation stuff for blindside
	local rotation = 0

	--ifblindside enabled, rotate around blinds instead
	if UNIK.hasBlindside() then
		rotation = degree_to_Radian(90)
		y = y - y_offset
		-- x = 4
		-- y = radi
		-- original_x = 4
		-- original_y = radi
		-- pivot_x = 4
		-- pivot_y = 0
	end
	
	if UNIK.hasBlindside() then
		
		rotation = rotation - degree_to_Radian(45)
		-- rotation_mod = 0 - degree_to_Radian(45)
		-- local struct = rotate(original_x,original_y,pivot_x,pivot_y,rotation_mod)
		-- x = struct.x
		-- y = struct.y
	end
	for _, v in ipairs(indicators) do
		if should_draw_indicator(card, v.key) then
		draw_single_indicator(
			card,
			v.sprite,
			x,
			y,rotation
		)
			if UNIK.hasBlindside() then
				rotation = rotation - degree_to_Radian(10)
				-- rotation_mod = rotation_mod - degree_to_Radian(10)
				-- local struct = rotate(original_x,original_y,pivot_x,pivot_y,rotation_mod)
				-- x = struct.x
				-- y = struct.y
			else
				y = y + HEIGHT + GAP
			end
		
		end
	end
end

SMODS.DrawStep {
	key = "bonus_indicators_front",
	order = 43,
	func = function(card)
		if card and card.ability then
			draw_indicators(UNIK.perma_bonus_coords.on_held, card, ALL_OFFSET_X,ALL_OFFSET_Y)
		end
	end,
	conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
	key = "bonus_indicators_back",
	order = -40,
	func = function(card)
		if card and card.ability then
			draw_indicators(UNIK.perma_bonus_coords.on_score, card, ALL_OFFSET_X,ALL_OFFSET_Y)
		end
	end,
	conditions = { vortex = false, facing = 'front' },
}

--old ye ye ass code

-- SMODS.DrawStep {
--     key = 'bonus_indicator',
--     order = 29,
--     func = function(self)
--         if self.area ~= G.deck then
--             for i,v in pairs(UNIK.perma_bonus_coords) do
--                 if self.ability and self.ability[i] and self.ability[i] ~= 0 then
--                     if not self.children[i .. "_render"] then
--                         self.children[i .. "_render"] = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['unik_stickers'], v)
--                         self.children[i .. "_render"].states.visible = false
--                     end
--                     self.children[i .. "_render"]:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0)
--                     self.children[i .. "_render"].role.draw_major = self
--                 end
--             end
--         end
        
--     end,
--     conditions = { vortex = false, facing = 'front' },
-- }



