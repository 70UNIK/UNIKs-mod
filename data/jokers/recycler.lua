--Gains x0.02 mult per discarded card (in line with Krusty the clown)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_recycler',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 4, y = 0 },
    cost = 7,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 0.02} },
	gameset_config = {
		modest = { extra = {x_mult = 1.0, x_mult_mod = 0.01} },
	},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod} }
	end,
    calculate = function(self, card, context)
		if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) or context.forcetrigger then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
        if (context.discard and not context.blueprint) or context.forcetrigger then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            return {
				delay = 0.2,
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
            }
		end
    end,
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_recycler"] = {
		text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
	}
end