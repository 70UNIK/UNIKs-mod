SMODS.Booster{
    key = "unik_character",
	kind = "character",
    atlas = "unik_cube_boosters",
	pos = { x = 0, y = 3 },
    cost = 10,
    weight = 0.05, --very rare
    config = { extra = 4, choose = 1 },
    create_card = function(self, card)
		--0.5% chance to appear
        if pseudorandom("character_soul_" .. G.GAME.round_resets.ante) > 0.995 then
            return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_soul", nil)
        end
		--has a 0.1% chance to appear when in these packs when almanac is installed
		if UNIK.has_almanac() then
			if pseudorandom("almanac_funny" .. G.GAME.round_resets.ante) > 0.999 then
				return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_jen_yawetag", nil)
			end
		end
		return create_card("character", G.pack_cards, nil, nil, true, true, nil, "character")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_UNIK)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.UNIK_CHELSEA, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	group_key = "k_unik_character_pack",
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_UNIK)
		ease_background_colour({ new_colour = G.C.UNIK_UNIK, special_colour = G.C.UNIK_CHELSEA, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
}

