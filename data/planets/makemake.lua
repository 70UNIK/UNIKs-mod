SMODS.Consumable{
    set = "Planet",
   	key = "unik_makemake",
    atlas = "unik_poker_hand_shit",
	pos = { x = 2, y = 1 },
	config = { hand_type = "unik_spectrum_five", softlock = true },
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_dwarf_planet"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("unik_spectrum_five"),
				G.GAME.hands["unik_spectrum_five"].level,
				G.GAME.hands["unik_spectrum_five"].l_mult,
				G.GAME.hands["unik_spectrum_five"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["unik_spectrum_five"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["unik_spectrum_five"].level))]
					),
				},
			},
		}
	end,
}