SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_summits',
    cost = 3,
	pos = {x = 3, y = 0},
	key = 'unik_whitney',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { money = 2 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.money,card.ability.extra.max_highlighted},
		}
	end,
    
	use = function(self, card, area, copier)
        UNIK.add_bonus('dollars',card.ability.extra.money)
        for i = 1, #G.hand.highlighted do
            local highlighted = G.hand.highlighted[i]
                highlighted.ability["perma_h_dollars"] = highlighted.ability["perma_h_dollars"] or 0
                highlighted.ability["perma_h_dollars"] = highlighted.ability["perma_h_dollars"] + card.ability.extra.money
                
            G.E_MANAGER:add_event(Event({
                trigger = 'after', 
                delay = 0.1, 
                func = function()
                card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                    message = '$' .. highlighted.ability["perma_h_dollars"],
                    colour = G.C.GOLD,
                    card=highlighted,
                })
                return true 
                end 
            }))
        end
        card:juice_up(0.3, 0.5)  
    end
}