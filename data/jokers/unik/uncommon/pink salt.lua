--crosses have a 2 in 3 chance to not create a summit card when scored
SMODS.Joker {
    key = 'unik_pink_salt',
    atlas = "unik_uncommon",
	pos = { x = 9, y = 3 },
    rarity = 2,
    cost = 7,
	config = {
		extra = {
			base_odds = 2,
            odds = 3,
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = true,
    demicolon_compat = true,
	loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.base_odds, center.ability.extra.odds, 'unik_pink_salt_summit')
		return {
			vars = {
				localize("unik_Crosses","suits_plural"),new_numerator, new_denominator,
                colours = {
                    G.C.SUITS["unik_Crosses"],
                },
			},
		}
	end,
	calculate = function(self, card, context)
        if context.forcetrigger or 
        (context.individual and context.cardarea == G.play and context.other_card:is_suit('unik_Crosses') 
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
        and not SMODS.pseudorandom_probability(card, 'unik_pink_salt_summit', card.ability.extra.base_odds, card.ability.extra.odds, 'unik_pink_salt_summit')
        ) then
            local card_type = 'unik_summit'
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'pink_salt_summit')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true
                end)}))
            return {
                message = localize('unik_plus_summit'),
                colour = G.C.UNIK_SUMMIT,
                card = card
            }
        end
	end,
	--do not spawn if no interest
	in_pool = function(self)
		return UNIK.suit_in_deck('unik_Crosses') 
	end,
}