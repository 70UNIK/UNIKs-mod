SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_noon',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 3, y = 0 },
    config = { extra = { x_mult = 1.75} }, --For comparison, in mainline cryptid, stardust is the common "unconditional Xmult" Joker, hence it's 1.75x
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult} }
	end,
    calculate = function(self, card, context)
		if (context.joker_main and G.GAME.current_round.hands_played ~= 0 and G.GAME.current_round.hands_left > 0) or context.forcetrigger then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
	end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_noon"] = {
		text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
        calc_function = function(card)
            card.joker_display_values.x_mult = G.GAME and G.GAME.current_round.hands_played ~= 0 and G.GAME.current_round.hands_left > 0 and card.ability.extra.x_mult or 1
        end
	}
end