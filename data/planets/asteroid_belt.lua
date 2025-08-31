SMODS.Consumable{
    set = "Planet",
   	key = "unik_asteroid_belt",
    atlas = "unik_poker_hand_shit",
	pos = { x = 0, y = 0 },
	config = { hand_type = "unik_bulwark", softlock = true },
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_disc"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("unik_bulwark"),
				G.GAME.hands["unik_bulwark"].level,
				G.GAME.hands["unik_bulwark"].l_mult,
				G.GAME.hands["unik_bulwark"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["unik_bulwark"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["unik_bulwark"].level))]
					),
				},
			},
		}
	end,
}