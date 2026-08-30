SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_noon',
    atlas = 'unik_normal_jokers',
    rarity = 1,
	pos = { x = 3, y = 5 },
    config = { extra = { mult = 16} }, --For comparison, in mainline cryptid, stardust is the common "unconditional Xmult" Joker, hence it's 1.75x
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
				mult = card.ability.extra.mult,
			}
		end
	end
}