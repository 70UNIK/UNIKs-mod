SMODS.Joker {
    key = 'unik_welfare_payment',
    atlas = 'placeholders',
	pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
	config = {
		extra = {
			dollars = 1,
            dollar_mod = 2.5,
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.dollars),number_format(center.ability.extra.dollar_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
            local amount = math.floor(math.max(G.GAME.interest_cap - G.GAME.dollars,0) / card.ability.extra.dollar_mod)
            return {
                
				dollars = amount,
				card = card
			}
        end
	end,
	calc_dollar_bonus = function(self, card)
		local amount = math.floor(math.max(G.GAME.interest_cap - G.GAME.dollars,0) / card.ability.extra.dollar_mod)
        if to_big(amount) > to_big(0) then
			return amount
		end
	end,
}