SMODS.Consumable{
    set = 'Spectral', 
	atlas = 'unik_summits',
    cost = 4,
	pos = {x = 2, y = 0},
	key = 'unik_ebott',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { e_mult = 0.04 ,max_highlighted = 1} },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.e_mult,card.ability.extra.max_highlighted},
		}
	end,
    hidden = true,
    soul_set = 'unik_summit',
	use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            local highlighted = G.hand.highlighted[i]
            highlighted.ability["perma_e_mult"] = highlighted.ability["perma_e_mult"] or 0
            highlighted.ability["perma_e_mult"] = highlighted.ability["perma_e_mult"] + card.ability.extra.e_mult
            G.E_MANAGER:add_event(Event({
                trigger = 'after', 
                delay = 0.1, 
                func = function()
                
                card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                    message = localize({
                        type = "variable",
                        key = "a_powmult",
                        vars = { number_format(1+highlighted.ability["perma_e_mult"]) },
                    }),
                    colour = G.C.DARK_EDITION,
                    card=highlighted,
                })
                return true 
                end 
            }))
        end
        card:juice_up(0.3, 0.5)  
    end
}