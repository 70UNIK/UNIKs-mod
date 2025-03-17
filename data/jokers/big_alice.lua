--X1.25 mult for playing 5 cards (not all will have to score), +X1 mult for any additional cards above 5
SMODS.Joker {
	key = 'unik_big_alice',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 7,
    config = { extra = { x_mult = 1.35, x_mult_mod = 0.75,hand_size = 5} },
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	display_size = { w = 1.35 * 71, h = 1.35 * 95 },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.hand_size} }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand >= card.ability.extra.hand_size then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult + card.ability.extra.x_mult_mod * (#context.full_hand - card.ability.extra.hand_size)}},
                    Xmult_mod = card.ability.extra.x_mult,
                }
			end
		end
	end
}