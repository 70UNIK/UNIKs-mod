--Gains x0.02 mult per discarded card (in line with Krusty the clown)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_recycler',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 7,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 0.02} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
        if context.discard and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            return {
				extra = { focus = card, message = localize("k_upgrade_ex") },
				card = card,
				colour = G.C.MULT,
            }
		end
    end,
}