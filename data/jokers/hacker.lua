--Hacker
--3 in 4 chance to not create a code card when a 2, 3, 4 or 5 is triggered.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_hacker',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 6,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {prob = 7, odds = 10} },
	loc_vars = function(self, info_queue, center)
		return { vars = {
			 center and cry_prob(center.ability.cry_prob * center.ability.extra.prob or center.ability.extra.prob, center.ability.extra.odds, center.ability.cry_rigged) or center.ability.extra.prob,
			 center.ability.extra.odds,
		} }
	end,
    calculate = function(self, card, context)


		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			
			if context.forcetrigger then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
							trigger = 'before',
							delay = 0.0,
							func = (function()
									local card = create_card('Code',G.consumeables, nil, nil, nil, nil, nil, 'unik_hackersss')
									card:add_to_deck()
									G.consumeables:emplace(card)
									G.GAME.consumeable_buffer = 0
								return true
							end)}))
				return {
					message = localize('k_plus_code'),
					colour = G.C.SECONDARY_SET.Code,
					card = card
				}
			end
			if context.individual and context.cardarea == G.play then
				if 
				context.other_card:get_id() == 2 or 
				context.other_card:get_id() == 3 or 
				context.other_card:get_id() == 4 or 
				context.other_card:get_id() == 5 
				then
					if not (pseudorandom(pseudoseed("unik_hacker")) < cry_prob(card.ability.cry_prob*card.ability.extra.prob or card.ability.extra.prob, card.ability.extra.odds, card.ability.cry_rigged) / card.ability.extra.odds) then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
						G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = (function()
								local card = create_card('Code',G.consumeables, nil, nil, nil, nil, nil, 'unik_hackersss')
								card:add_to_deck()
								G.consumeables:emplace(card)
								G.GAME.consumeable_buffer = 0
							return true
						end)}))
						return {
                            message = localize('k_plus_code'),
                            colour = G.C.SECONDARY_SET.Code,
                            card = card
                        }
					end
				end
			end
		end

    end,
}