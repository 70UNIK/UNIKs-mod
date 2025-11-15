--Remove all stickers, debuffs and detrimental editions from up to 1 selected joker
UNIK.detrimental_removable_stickers = {
    "perishable",
    "rental",
    "unik_disposable",
    "unik_triggering",
    "unik_impounded",
    "bunc_hindered",
    "bunc_scattering",
    "bunc_reactive",
    "pinned",
    "banana",
    "cry_flickering",
    "cry_possessed",
    "temporary",
}
SMODS.Consumable {
    key = 'unik_purify',
    set = 'Spectral',
    atlas = 'placeholders',
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {jokers_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.jokers_highlighted } }
    end,
    can_use = function(self, card)
        if G.jokers and G.hand and ((#G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.jokers_highlighted and #G.hand.highlighted == 0)
        ) then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
         G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local cards1 = G.jokers.highlighted
            for i=1, #cards1 do
                local percent = 1.15 - (i-0.999)/(#cards1-0.998)*0.3
                
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards1[i]:flip();play_sound('card1', percent);cards1[i]:juice_up(0.3, 0.3);return true end }))
            end
        
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                
                for i=1, #cards1 do
                    
                    local percent = 0.85 + (i-0.999)/(#cards1-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards1[i]:flip();play_sound('tarot2', percent, 0.6);cards1[i]:juice_up(0.3, 0.3);
                    for z = 1, #UNIK.detrimental_removable_stickers do
                        cards1[i].ability[z] = nil;
                    end
                    if isDetrimentalEdition(cards1[i]) then
                        cards1[i]:set_edition(nil, true)
                    end
                    
                    return true end }))
                    
                end
                card:juice_up(0.3, 0.5)
            return true end })) 
        return true end })) 
    end,
}
