--earn $0 at end of round, increase by $3 per dollar card held at end of round
SMODS.Joker {
    key = 'unik_joker_dollar',
    atlas = 'placeholders',
	pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			dollars = 0,
			dollar_mod = 2,
		},
	},
	enhancement_gate = "m_unik_dollar",
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_dollar
		return {
			vars = {
				number_format(center.ability.extra.dollars),
				number_format(center.ability.extra.dollar_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.individual and context.cardarea == G.hand then
			if SMODS.has_enhancement(context.other_card, "m_unik_dollar") then
				card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollar_mod
				return {
					message = "+$" .. card.ability.extra.dollar_mod,
					card = card,
					colour = G.C.MONEY,
				}
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.dollars
        if bonus > 0 then
			return bonus
		end
	end,
}