SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_summits',
    cost = 3,
	pos = {x = 1, y = 3},
	key = 'unik_mitchell',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { chips = 22 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.chips,card.ability.extra.max_highlighted},
		}
	end,
    
	use = function(self, card, area, copier)
        UNIK.add_bonus('chips',card.ability.extra.chips)
        for i = 1, #G.hand.highlighted do
            local highlighted = G.hand.highlighted[i]
                highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] or 0
                highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] + card.ability.extra.chips
                
            G.E_MANAGER:add_event(Event({
                trigger = 'after', 
                delay = 0.1, 
                func = function()
                card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                    message = localize({
                        type = "variable",
                        key = "a_chips",
                        vars = { number_format(highlighted.ability["perma_h_chips"]) },
                    }),
                    colour = G.C.CHIPS,
                    card=highlighted,
                })
                return true 
                end 
            }))
        end
        card:juice_up(0.3, 0.5)  
    end
}