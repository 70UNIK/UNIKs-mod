local summit_digital_hallucinations_compat = {
	colour = G.C.UNIK_SUMMIT,
	loc_key = "unik_plus_summit",
	create = function()
		local ccard = create_card("unik_summit", G.consumeables, nil, nil, nil, nil, nil, "diha")
		ccard:set_edition({ negative = true }, true)
		ccard:add_to_deck()
		G.consumeables:emplace(ccard)
	end,
}

SMODS.Booster{
    key = "unik_summit_1",
	kind = "unik_summit",
    atlas = "unik_cube_boosters",
	pos = { x = 2, y = 2 },
    cost = 4,
    weight = 1, 
    config = { extra = 2, choose = 1 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = summit_digital_hallucinations_compat,
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
      ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_SUMMIT)
      ease_background_colour { new_colour = G.C.UNIK_SUMMIT, special_colour = G.C.BLACK, contrast = 2 }
	end,
	create_card = function(self, card, i)
        return create_card("unik_summit", G.pack_cards, nil, nil, true, nil, nil, "unik_summit_pack")
	end,
	group_key = "k_unik_summit_pack",
}
SMODS.Booster{
    key = "unik_summit_4",
	kind = "unik_summit",
    atlas = "unik_cube_boosters",
	pos = { x = 1, y = 3 },
    cost = 4,
    weight = 1,
    config = { extra = 2, choose = 1 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = summit_digital_hallucinations_compat,
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
      ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_SUMMIT)
      ease_background_colour { new_colour = G.C.UNIK_SUMMIT, special_colour = G.C.BLACK, contrast = 2 }
	end,
	create_card = function(self, card, i)
        return create_card("unik_summit", G.pack_cards, nil, nil, true, nil, nil, "unik_summit_pack")
	end,
	group_key = "k_unik_summit_pack",
}
SMODS.Booster{
    key = "unik_summit_2",
	kind = "unik_summit",
    atlas = "unik_cube_boosters",
	pos = { x = 1, y = 2 },
    cost = 6,
    weight = 1, 
    config = { extra = 4, choose = 1 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = summit_digital_hallucinations_compat,
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
      ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_SUMMIT)
      ease_background_colour { new_colour = G.C.UNIK_SUMMIT, special_colour = G.C.BLACK, contrast = 2 }
	end,
	create_card = function(self, card, i)
        return create_card("unik_summit", G.pack_cards, nil, nil, true, nil, nil, "unik_summit_pack")
	end,
	group_key = "k_unik_summit_pack",
}
SMODS.Booster{
    key = "unik_summit_3",
	kind = "unik_summit",
    atlas = "unik_cube_boosters",
	pos = { x = 0, y = 2 },
    cost = 8,
    weight = 0.15, 
    config = { extra = 4, choose = 2 },
    --try to enter with Caine at your own risk!
    cry_digital_hallucinations = summit_digital_hallucinations_compat,
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
      ease_colour(G.C.DYN_UI.MAIN, G.C.UNIK_SUMMIT)
      ease_background_colour { new_colour = G.C.UNIK_SUMMIT, special_colour = G.C.BLACK, contrast = 2 }
	end,
	create_card = function(self, card, i)
        return create_card("unik_summit", G.pack_cards, nil, nil, true, nil, nil, "unik_summit_pack")
	end,
	group_key = "k_unik_summit_pack",
}