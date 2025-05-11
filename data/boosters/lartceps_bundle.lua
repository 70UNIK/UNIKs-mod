local lartceps_digital_hallucinations_compat = {
	colour = G.C.UNIK_LARTCEPS1,
	loc_key = "unik_plus_lartceps",
	create = function()
		local ccard = create_card("unik_lartceps", G.consumeables, nil, nil, nil, nil, nil, "diha")
		ccard:set_edition({ negative = true }, true)
		ccard:add_to_deck()
		G.consumeables:emplace(ccard)
	end,
}

SMODS.Booster{
    key = "unik_lartceps_bundle",
	kind = "unik_lartceps",
    atlas = "unik_cube_boosters",
	pos = { x = 1, y = 1 },
    cost = 0,
    weight = 0, 
    config = { extra = 10, choose = 5 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = lartceps_digital_hallucinations_compat,
	draw_hand = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_LARTCEPS1)
        ease_background_colour{new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3}
	end,
    update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_LARTCEPS1)
        ease_background_colour{new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3}
		SMODS.Booster.update_pack(self, dt)
	end,
	no_music = true, --prevent override of music, such as in boss blinds. WIll have to program it in without the decision (almanac)
	no_doe = true,
	unskippable = function(self) --Always unskippable
		return true
	end,
	create_card = function(self, card, i)
        return create_card("unik_lartceps", G.pack_cards, nil, nil, true, nil, nil, "lartceps_bundle_pack")
	end,
	in_pool = function(self, args)
        return false
    end,
	group_key = "k_unik_lartceps_pack",
}