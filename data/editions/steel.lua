--2x mult when held or joker is untriggered (3x)
SMODS.Shader({
    key = "steel",
    path = "steel.fs",
})
SMODS.Sound({
	key = "steel",
	path = "steel.ogg",
})
SMODS.Edition({
	key = "steel",
	order = 66666,
	weight = 4, 
	shader = "steel", 
	extra_cost = 4, 
    apply_to_float = true,
	sound = {
		sound = "unik_steel",
		per = 0.8,
		vol = 0.5,
	},
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    config = {
		x_mult = 2,joker_x_mult = 0.5,trigger = nil,metal_scoring = nil
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue, card)
		local key = 'e_unik_steel'
		if card.ability and card.ability.consumeable and card.area ~= G.hand then
			key = 'e_unik_steel_consumeable'
			return { key = key, vars = {self.config.x_mult}, }
		elseif card.area and (card.area.config.type == 'joker' or card.area == G.jokers) then
			key = 'e_unik_steel_joker'
			return { key = key, vars = {self.config.x_mult,self.config.joker_x_mult
			}, }
		end
        return { key = key, vars = {self.config.x_mult}, }
	end,
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    in_shop = true,
    badge_colour = G.C.DARK_EDITION,
    calculate = function(self, card, context)
		if context.before then
			card.config.metal_scoring = true
		end
		if context.edition and context.cardarea == G.jokers and card.config.trigger then
			return {
				x_mult = self.config.x_mult,
			} 
		end
		if context.post_trigger and context.other_card == card and not card.ability.steel_penalty_trigger and card.config.metal_scoring then
			card.ability.steel_penalty_trigger = true
			return {
				x_mult = self.config.joker_x_mult,
			} 
		end
		--held in hand or on consumeables
		if (context.main_scoring and context.cardarea == G.hand)then
			return {
				x_mult = self.config.x_mult,
			} 
		end
		if (context.main_scoring and context.cardarea == G.consumeables)then
			return {
				x_mult = self.config.x_mult,
			} 
		end

		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.ability.steel_penalty_trigger = nil
			card.config.trigger = nil
			card.config.metal_scoring = nil
		end
	end,
})