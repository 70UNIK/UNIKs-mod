SMODS.Joker {
    key = 'unik_compounding_interest',
    atlas = 'unik_rare',
	pos = { x = 4, y = 1 },
    rarity = 3,
    cost = 8,
	config = {
		extra = {
			x_dollars = 0.2,
		},
        immutable = {
            cap = 1000,
        }
	},
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.x_dollars),number_format(center.ability.immutable.cap),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
            return {
                
				dollars = math.min(G.GAME.dollars*card.ability.extra.x_dollars,card.ability.immutable.cap),
				card = card
			}
        end
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = math.floor(math.min(G.GAME.dollars*card.ability.extra.x_dollars,card.ability.immutable.cap))
        if to_big(bonus) > to_big(0) then
			return bonus
		end
	end,
}