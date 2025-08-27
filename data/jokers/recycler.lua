--Gains x0.02 mult per discarded card (in line with Krusty the clown)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_recycler',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 4, y = 0 },
    cost = 7,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 0.02} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod} }
	end,
    calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
        if (context.discard and not context.blueprint) then
			SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "x_mult_mod",
				scaling_message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { card.ability.extra.x_mult },
				}),
				message_colour = G.C.MULT,
				delay = 0.2,
			})
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