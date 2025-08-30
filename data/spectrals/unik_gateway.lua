--Gateway but only spawns UNIK, cause he's the only "cube" joker thats an exotic (cause hes the creator)
--Only spawns with a 0.3% chance in "Square" pack (like with SOUL)
--Copied from cryptid, since apart from the "spawns exclusively UNIK and only spawns in cube pack", it's the same as gateway.
SMODS.Atlas({
	key = "unik_gateway", --this is easier to spell then consumables
	path = "unik_gateway.png",
	px = 71,
	py = 95,
})
SMODS.Consumable{
    set = "Spectral",
	key = "unik_gateway",
	pos = { x = 2, y = 2 },
	cost = 4,
	 atlas = 'placeholders',
	order = 90,
	no_doe = true,
	hidden = true,
	config = {extra = {jokers = 3}},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.jokers or 3} }
    end,
	can_use = function(self, card)
		local eternals = 0
		if G.jokers.cards then
			for i,v in pairs(G.jokers.cards) do
				if SMODS.is_eternal(v,self) then
					eternals = eternals + 1
				end
			end
		end

		if eternals < G.jokers.config.card_limit then
			return true
		end
	end,
	-- pixel_size = { w = 71, h = 71 }, --hopefully THAT works
	-- loc_vars = function(self, info_queue, card)
	-- 	info_queue[#info_queue + 1] = G.P_CENTERS.j_unik_unik
	-- end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "unik_ancient", nil, nil, nil, "unik_gateway")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		if (#SMODS.find_card("j_jen_saint") + #SMODS.find_card("j_jen_saint_attuned")) <= 0 then
			local deletable_jokers = {}
			for i = 1, #G.jokers.cards do
				if #deletable_jokers < card.ability.extra.jokers then
					if not SMODS.is_eternal(G.jokers.cards[i],self) then
						deletable_jokers[#deletable_jokers + 1] = G.jokers.cards[i]
					end
				end
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
					for k, v in pairs(deletable_jokers) do
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
}

-- --copied from cryptid's gateway, hoperfully it plays nice
-- SMODS.DrawStep({
-- 	key = "floating_sprite2",
-- 	order = 59,
-- 	func = function(self)
-- 		if self.ability.name == "c_unik_gateway" and (self.config.center.discovered or self.bypass_discovery_center) then
-- 			local scale_mod2 = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
-- 			local rotate_mod2 = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
-- 			self.children.floating_sprite2:draw_shader(
-- 				"dissolve",
-- 				0,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod2,
-- 				rotate_mod2,
-- 				nil,
-- 				0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
-- 				nil,
-- 				0.6
-- 			)
-- 			self.children.floating_sprite2:draw_shader(
-- 				"dissolve",
-- 				nil,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod2,
-- 				rotate_mod2
-- 			)

-- 			local scale_mod = 0.05
-- 				+ 0.05 * math.sin(1.8 * G.TIMERS.REAL)
-- 				+ 0.07
-- 					* math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
-- 					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
-- 			local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
-- 				+ 0.07
-- 					* math.sin(G.TIMERS.REAL * math.pi * 5)
-- 					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

-- 			self.children.floating_sprite.role.draw_major = self
-- 			self.children.floating_sprite:draw_shader(
-- 				"dissolve",
-- 				0,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod,
-- 				rotate_mod,
-- 				nil,
-- 				0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
-- 				nil,
-- 				0.6
-- 			)
-- 			self.children.floating_sprite:draw_shader(
-- 				"dissolve",
-- 				nil,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod,
-- 				rotate_mod
-- 			)
-- 		end
-- 		if
-- 			self.config.center.soul_pos
-- 			and self.config.center.soul_pos.extra
-- 			and (self.config.center.discovered or self.bypass_discovery_center)
-- 		then
-- 			local scale_mod = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
-- 			local rotate_mod = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
-- 			self.children.floating_sprite2:draw_shader(
-- 				"dissolve",
-- 				0,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod,
-- 				rotate_mod,
-- 				nil,
-- 				0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
-- 				nil,
-- 				0.6
-- 			)
-- 			self.children.floating_sprite2:draw_shader(
-- 				"dissolve",
-- 				nil,
-- 				nil,
-- 				nil,
-- 				self.children.center,
-- 				scale_mod,
-- 				rotate_mod
-- 			)
-- 		end
-- 	end,
-- 	conditions = { vortex = false, facing = "front" },
-- })
-- SMODS.draw_ignore_keys.floating_sprite2 = true

-- -- Midground sprites - used for Exotic Jokers and Gateway. Copied from gateway as well
-- local set_spritesref2 = Card.set_sprites
-- function Card:set_sprites(_center, _front)
-- 	set_spritesref2(self, _center, _front)
-- 	if _center and _center.name == "c_unik_gateway" then
-- 		self.children.floating_sprite = Sprite(
-- 			self.T.x,
-- 			self.T.y,
-- 			self.T.w,
-- 			self.T.h,
-- 			G.ASSET_ATLAS[_center.atlas or _center.set],
-- 			{ x = 2, y = 0 }
-- 		)
-- 		self.children.floating_sprite.role.draw_major = self
-- 		self.children.floating_sprite.states.hover.can = false
-- 		self.children.floating_sprite.states.click.can = false
-- 		self.children.floating_sprite2 = Sprite(
-- 			self.T.x,
-- 			self.T.y,
-- 			self.T.w,
-- 			self.T.h,
-- 			G.ASSET_ATLAS[_center.atlas or _center.set],
-- 			{ x = 1, y = 0 }
-- 		)
-- 		self.children.floating_sprite2.role.draw_major = self
-- 		self.children.floating_sprite2.states.hover.can = false
-- 		self.children.floating_sprite2.states.click.can = false
-- 	end
-- end