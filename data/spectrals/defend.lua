--add shielded to 2 selected cards or 1 selected joker.
SMODS.Consumable {
    key = 'unik_defend',
    set = 'Spectral',
    atlas = 'placeholders',
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {jokers_highlighted = 1, cards_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_shielded" }
        return { vars = { card.ability.jokers_highlighted,card.ability.cards_highlighted } }
    end,
    can_use = function(self, card)
        if G.jokers and G.hand and ((#G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.jokers_highlighted and #G.hand.highlighted == 0)
        or (#G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.cards_highlighted and #G.jokers.highlighted == 0)
        ) then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
         G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local cards1 = G.jokers.highlighted
            local cards2 = G.hand.highlighted
            for i=1, #cards1 do
                local percent = 1.15 - (i-0.999)/(#cards1-0.998)*0.3
                
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards1[i]:flip();play_sound('card1', percent);cards1[i]:juice_up(0.3, 0.3);return true end }))
            end
            for i=1, #cards2 do
                local percent = 1.15 - (i-0.999)/(#cards2-0.998)*0.3
                
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards2[i]:flip();play_sound('card1', percent);cards2[i]:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                
                for i=1, #cards1 do
                    cards1[i].ability.unik_shielded = true
                    local percent = 0.85 + (i-0.999)/(#cards1-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards1[i]:flip();play_sound('tarot2', percent, 0.6);cards1[i]:juice_up(0.3, 0.3);return true end }))
                end
                for i=1, #cards2 do
                    cards2[i].ability.unik_shielded = true
                    local percent = 0.85 + (i-0.999)/(#cards2-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards2[i]:flip();play_sound('tarot2', percent, 0.6);cards2[i]:juice_up(0.3, 0.3);return true end }))
                end
                card:juice_up(0.3, 0.5)
            return true end })) 
        return true end })) 
    end,
}