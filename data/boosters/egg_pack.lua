local egg_digital_hallucinations_compat = {
	colour = G.C.RED,
	loc_key = "k_plus_joker",
	create = function()
		local carder = create_card("Joker", G.jokers, nil, nil, true,true, "j_egg")
        carder.ability.eternal = true
        carder.ability.rental = true
		carder:set_edition({ negative = true }, true)
		carder:add_to_deck()
		G.consumeables:emplace(carder)
	end,
}

SMODS.Booster{
    key = "unik_egg_pack",
	kind = "Joker",
    atlas = "unik_cube_boosters",
	pos = { x = 2, y = 1 },
    cost = 0,
    weight = 0, 
    config = { extra = 4, choose = 1 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = egg_digital_hallucinations_compat,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_egg
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("f0e2bc"))
        ease_background_colour{new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3}
	end,
    update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, HEX("f0e2bc"))
        ease_background_colour{new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3}
		SMODS.Booster.update_pack(self, dt)
	end,
	no_music = true, --prevent override of music, such as in boss blinds. WIll have to program it in without the decision (almanac)
	no_doe = true,
	unskippable = function(self) --Unskippable when all jokers are eternal and slots not full.
		local validJokers = 0
        for i,v in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(v,self) then
                validJokers = validJokers + 1
            end
        end
        if validJokers > 0 then
            return false
        end
        if #G.jokers.cards >= G.jokers.config.card_limit then
            return false
        end
		return true
	end,
	create_card = function(self, card, i)
        local carder = create_card("Joker", G.jokers, nil, nil, true,true, "j_egg")
        carder.ability.eternal = true
        carder.ability.rental = true
        return carder
	end,
	skip_req_message = function(self)
		G.GAME.lartceps_pack_pity = G.GAME.lartceps_pack_pity or 1
		
		return {
			{
				localize("k_unik_must_select"),{ref_table = G.GAME, ref_value = 'lartceps_pack_pity'},localize("k_unik_skip_req2"),
			},
		}
	end,
	skip_effect = function(self)
		G.GAME.lartceps_pack_pity = G.GAME.lartceps_pack_pity or 1
		local validJokers = {}
        for i,v in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(v,self) then
                validJokers[#validJokers+1] = v
            end
        end
		if #validJokers > 0 and not G.GAME.disable_banish_FX and G.GAME.lartceps_pack_pity > 0 then
			 local select = pseudorandom_element(validJokers, pseudoseed("unik_egg_banish"))
			 if G.GAME.blind then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
			end
			if not G.GAME.banned_keys then
				G.GAME.banned_keys = {}
			end -- i have no idea if this is always initialised already tbh
			if not G.GAME.cry_banished_keys then
				G.GAME.cry_banished_keys = {}
			end -- 
			if not G.GAME.cry_banned_pcards then
				G.GAME.cry_banished_keys = {}
			end
			G.GAME.cry_banished_keys[select.config.center.key] = true
			select:start_dissolve()
		end
	end,
	in_pool = function(self, args)
        return false
    end,
	unik_disablable = true,
	group_key = "k_unik_egg_pack",
}