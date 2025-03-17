--10 mult for playing 5 cards (not all will have to score), +4 mult for any additional cards above 5
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_big_joker',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 2, y = 0 },
    config = { extra = { mult = 10, mult_mod = 5,hand_size = 5} },
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	display_size = { w = 1.35 * 71, h = 1.35 * 95 },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult,center.ability.extra.mult_mod,center.ability.extra.hand_size} }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand >= card.ability.extra.hand_size then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult + card.ability.extra.mult_mod * (#context.full_hand - card.ability.extra.hand_size)}},
                    mult_mod = card.ability.extra.mult
                }
			end
		end
	end
}