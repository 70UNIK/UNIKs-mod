--JUMBO = 9
--MEGA = 16 (yes its pricey)
local cube_digital_hallucinations = {
	colour = G.C.CRY_ASCENDANT,
	loc_key = "k_plus_joker",
	create = function()
		local ccard = create_card("unik_cube", G.jokers, nil, nil, true, true, nil, "unik_cube_2")
		ccard:set_edition({ negative = true }, true)
		ccard:add_to_deck()
		G.jokers:emplace(ccard)
	end,
}
SMODS.Atlas({
	key = "unik_cube_boosters",
	path = "unik_cube_boosters.png",
	px = 71,
	py = 95,
})
SMODS.Booster{
    key = "unik_cube_1",
	kind = "unik_cube",
    atlas = "unik_cube_boosters",
	pos = { x = 0, y = 0 },
    cost = 9,
    weight = 0.9 / 3, --0.18 base ÷ 3 since there are 3 identical packs
    config = { extra = 4, choose = 1 },
    cry_digital_hallucinations = cube_digital_hallucinations,
    create_card = function(self, card)
		-- if
		-- 	Cryptid.enabled("j_cry_waluigi")
		-- 	and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		-- then

		-- end
		return create_card("unik_cube", G.pack_cards, nil, nil, true, true, nil, "unik_cube")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	group_key = "k_unik_cube_pack",
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
}
SMODS.Booster{
    key = "unik_cube_2",
	kind = "unik_cube",
    atlas = "unik_cube_boosters",
	pos = { x = 1, y = 0 },
    cost = 9,
    weight = 0.9 / 3, --0.18 base ÷ 3 since there are 3 identical packs
    config = { extra = 4, choose = 1 },
    cry_digital_hallucinations = cube_digital_hallucinations,
    create_card = function(self, card)
		-- if
		-- 	Cryptid.enabled("j_cry_waluigi")
		-- 	and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		-- then

		-- end
		return create_card("unik_cube", G.pack_cards, nil, nil, true, true, nil, "unik_cube")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	group_key = "k_unik_cube_pack",
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
}
SMODS.Booster{
    key = "unik_cube_3",
	kind = "unik_cube",
    atlas = "unik_cube_boosters",
	pos = { x = 2, y = 0 },
    cost = 16,
    weight = 0.9 / 3, --0.18 base ÷ 3 since there are 3 identical packs
    config = { extra = 4, choose = 2 },
    cry_digital_hallucinations = cube_digital_hallucinations,
    create_card = function(self, card)
		-- if
		-- 	Cryptid.enabled("j_cry_waluigi")
		-- 	and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		-- then

		-- end
		return create_card("unik_cube", G.pack_cards, nil, nil, true, true, nil, "unik_cube")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	group_key = "k_unik_cube_pack",
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CHIPS)
		ease_background_colour({ new_colour = G.C.CHIPS, special_colour = G.C.DARK_EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
}