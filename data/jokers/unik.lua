SMODS.Atlas {
	key = "unik_unik",
	path = "unik_unik.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	key = 'unik_unik',
    atlas = 'unik_unik',
    rarity = "cry_exotic",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {Echips_mod = 0.03, Echips = 1.0} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Echips_mod,center.ability.extra.Echips} }
	end,
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Echips) > to_big(1)) then
			return {
                message = localize({
					type = "variable",
					key = "a_powchips",
                    vars = {
                        number_format(card.ability.extra.Echips),
                    },
				}),
				Echip_mod = card.ability.extra.Echips,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and not context.blueprint then
			card.ability.extra.Echips = card.ability.extra.Echips + card.ability.extra.Echips_mod
			return {
				message = localize({
                    type = "variable",
                    key = "a_powchips",
                    vars = {
                        number_format(to_big(card.ability.extra.Echips)),
                    },
                }),
				colour = G.C.DARK_EDITION,
				card = card
			}
		end
    end,
}