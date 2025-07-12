--Convert 3 in 4 cards in deck to Namta cards 
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 5, y = 1},
	key = 'unik_sauron',
    config = { extra = { unluck = 1, odds = 4 } },
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_namta
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.unluck, center.ability.extra.odds, 'unik_sauron')
		return {
            vars = {
				new_numerator, new_denominator
			},
		}
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i=1, #G.hand.cards do
                local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                for i,v in pairs(G.playing_cards) do
                    if not SMODS.pseudorandom_probability(card, 'unik_sauron', card.ability.extra.unluck, card.ability.extra.odds, 'unik_sauron') then
                        v:set_ability(G.P_CENTERS['m_unik_namta'])
                    end
                end
                for i=1, #G.hand.cards do
                    local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
                end
                card:juice_up(0.3, 0.5)
            return true end })) 
        return true end })) 
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}