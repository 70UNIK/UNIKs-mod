SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_noon',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 3, y = 0 },
    config = { extra = { x_mult = 1.75} },
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult} }
	end,
	gameset_config = {
		modest = {extra = {x_mult = 1.6} },
	},
    calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played ~= 0 and G.GAME.current_round.hands_left > 0 then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
	end
}