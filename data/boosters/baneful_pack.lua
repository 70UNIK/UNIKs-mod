--yeah im ripping off the decision

SMODS.Booster{
    key = "unik_baneful_significant_1",
	kind = "Detriment",
    atlas = "unik_consumables",
	pos = { x = 10, y = 6 },
    cost = 0,
    weight = 0, 

	get_weight = function(self)
        return 0
	end,
    in_pool = function(self, args)
        return false
    end,
    config = { extra = 4, choose = 1,forced_choose = 1 },
	draw_hand = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	-- ease_background_colour = function(self)
    --   ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_DETRIMENT)
    --   ease_background_colour { new_colour = G.C.UNIK_DETRIMENT, special_colour = G.C.BLACK, contrast = 2 }
	-- end,
	create_card = function(self, card, i)
        return UNIK.create_detriment_booster(G.pack_cards,{severity = 2,no_dissolve = true })
	end,
    no_music = true, --prevent override of music, such as in boss blinds. WIll have to program it in without the decision (bos)
	no_doe = true,
	group_key = "k_unik_baneful_pack",
    unik_disablable = true,
    unik_unskippable = function(self) --Unskippable when no jokers exist
		if G.GAME.unik_booster_forced_choose and G.GAME.unik_booster_forced_choose <= 0 then
			return false
		end
		local validJokers = 0
		--print("skipcheck")
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
    skip_req_message = function(self)
		
		return {
			{
				localize("k_unik_must_select"),{ref_table = G.GAME, ref_value = 'unik_booster_forced_choose'},localize("k_unik_skip_req2"),
			},
		}
	end,
    skip_effect = function(self)
		local validJokers = {}
        for i,v in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(v,self) then
                validJokers[#validJokers+1] = v
            end
        end
		if #validJokers > 0 and not G.GAME.disable_banish_FX and G.GAME.unik_booster_forced_choose > 0 then
			 local select = pseudorandom_element(validJokers, pseudoseed("unik_egg_banish"))
			 if G.GAME.blind then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
			end
			select:start_dissolve()
		end
	end,
}


SMODS.Booster{
    key = "unik_baneful_severe_1",
	kind = "Detriment",
    atlas = "unik_consumables",
	pos = { x = 11, y = 6 },
    cost = 0,
    weight = 0, 

	get_weight = function(self)
        return 0
	end,
    in_pool = function(self, args)
        return false
    end,
    config = { extra = 5, choose = 2,forced_choose = 2},
	draw_hand = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	-- ease_background_colour = function(self)
    --   ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_DETRIMENT)
    --   ease_background_colour { new_colour = G.C.UNIK_DETRIMENT, special_colour = G.C.BLACK, contrast = 2 }
	-- end,
	create_card = function(self, card, i)
        return UNIK.create_detriment_booster(G.pack_cards,{severity = 3,no_dissolve = true })
	end,
    no_music = true, --prevent override of music, such as in boss blinds. WIll have to program it in without the decision (bos)
	no_doe = true,
	group_key = "k_unik_baneful_pack",
    unik_disablable = true,
    unik_unskippable = function(self) --Unskippable when no jokers exist
		if G.GAME.unik_booster_forced_choose and G.GAME.unik_booster_forced_choose <= 0 then
			return false
		end
		return true
	end,
    skip_req_message = function(self)
		
		return {
			{
				localize("k_unik_must_select"),{ref_table = G.GAME, ref_value = 'unik_booster_forced_choose'},localize("k_unik_skip_req"),
			},
		}
	end,
}

SMODS.Booster{
    key = "unik_baneful_subpar_1",
	kind = "Detriment",
    atlas = "unik_consumables",
	pos = { x = 11, y = 5 },
    cost = 0,
    weight = 0, 

	get_weight = function(self)
        return 0
	end,
    in_pool = function(self, args)
        return false
    end,
    config = { extra = 5, choose = 2,forced_choose = 2},
	draw_hand = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	-- ease_background_colour = function(self)
    --   ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_DETRIMENT)
    --   ease_background_colour { new_colour = G.C.UNIK_DETRIMENT, special_colour = G.C.BLACK, contrast = 2 }
	-- end,
	create_card = function(self, card, i)
        return UNIK.create_detriment_booster(G.pack_cards,{severity = 1,no_dissolve = true })
	end,
    no_music = true, --prevent override of music, such as in boss blinds. WIll have to program it in without the decision (bos)
	no_doe = true,
	group_key = "k_unik_baneful_pack",
    unik_disablable = true,
    unik_unskippable = function(self) --Unskippable when no jokers exist
		if G.GAME.unik_booster_forced_choose and G.GAME.unik_booster_forced_choose <= 0 then
			return false
		end
		local validJokers = 0
		--print("skipcheck")
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
    skip_req_message = function(self)
		
		return {
			{
				localize("k_unik_must_select"),{ref_table = G.GAME, ref_value = 'unik_booster_forced_choose'},localize("k_unik_skip_req"),
			},
		}
	end,
	skip_effect = function(self)
		if G.GAME.disable_banish_FX and G.GAME.unik_booster_forced_choose > 0 then
			for i = 1, #G.jokers.cards do
				if not SMODS.is_eternal(G.jokers.cards[i],self) then
					local select = G.jokers.cards[i]
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
			end
		end
		
	end,
}