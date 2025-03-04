SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_cube_joker',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },

    cost = 6,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.25} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod, center.ability.extra.max_size} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
                message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end
        if context.before and context.cardarea == G.jokers and #context.full_hand == 4 and not context.blueprint then
			card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_mod
			return {
				message = localize({
                    type = "variable",
                    key = "a_xchips",
                    vars = {
                        number_format(to_big(card.ability.extra.x_chips)),
                    },
                }),
				colour = G.C.CHIPS,
				card = card
			}
		end
    end,
}