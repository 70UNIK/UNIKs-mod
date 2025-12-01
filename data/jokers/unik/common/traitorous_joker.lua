SMODS.Joker {
    key = 'unik_treacherous_joker',
    atlas = 'unik_common',
	pos = { x = 0, y = 2 },
    rarity = 1,
    cost = 4,
	config = {
		extra = {
			mult = 5,
            suit = 'unik_Noughts',
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.mult),localize(
					center.ability.extra.suit,
					"suits_singular"
				),
                colours = {
                    G.C.SUITS[center.ability.extra.suit],
                },
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit)) then
            return {
                
				mult = card.ability.extra.mult
			}
        end
	end,
	--do not spawn if no interest
	in_pool = function(self)
		return UNIK.suit_in_deck('unik_Noughts') 
	end,
}