--selected cards gain or lose eternal
SMODS.Consumable {
    key = 'unik_forever',
    set = 'Spectral',
	atlas = "placeholders",
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_eternal_playing_card" }
        
    end,
    can_use = function(self, card)

		return #G.hand.highlighted > 0
	end,
    use = function(self, card, area, copier)
         G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local cards2 = G.hand.highlighted
            for i=1, #cards2 do
                local percent = 1.15 - (i-0.999)/(#cards2-0.998)*0.3
                
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards2[i]:flip();play_sound('card1', percent);cards2[i]:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                
                for i=1, #cards2 do
                    
                    local percent = 0.85 + (i-0.999)/(#cards2-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards2[i]:flip();play_sound('tarot2', percent, 0.6);cards2[i]:juice_up(0.3, 0.3);
                    if cards2[i].ability.eternal then
                        cards2[i].ability.eternal = nil
                    else
                        cards2[i].ability.eternal = true
                    end
                    
                    if G.GAME.blind then G.GAME.blind:debuff_card(cards2[i]) end
                    
                    return true end }))
                end
                card:juice_up(0.3, 0.5)
            return true end })) 
        return true end })) 
    end,
}