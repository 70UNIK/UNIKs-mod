--played noughts have a 1 in 2 chance to not be rescored
SMODS.Joker {
    key = 'unik_aquamarine',
    atlas = "unik_uncommon",
	pos = { x = 8, y = 3 },
    rarity = 2,
    cost = 7,
	config = {
		extra = {
			base_odds = 1,
            odds = 2,
            rescores = 1,
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.base_odds, center.ability.extra.odds, 'unik_aquamarine_resc')
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
		return {
			vars = {
				localize("unik_Noughts","suits_plural"),new_numerator, new_denominator,center.ability.extra.rescores,
                colours = {
                    G.C.SUITS["unik_Noughts"],
                },
			},
		}
	end,
	calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if v:is_suit('unik_Noughts') then
                    if not SMODS.pseudorandom_probability(card, 'unik_aquamarine_resc', card.ability.extra.base_odds, card.ability.extra.odds, 'unik_aquamarine_resc') then
                        validCards[#validCards+1] = v
                    end
                    
                end
            end
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    rescore = 1,
                    card = card,
                    message = '+1',
                }
            end
        end
	end,
	--do not spawn if no interest
	in_pool = function(self)
		return UNIK.suit_in_deck('unik_Noughts') 
	end,
}