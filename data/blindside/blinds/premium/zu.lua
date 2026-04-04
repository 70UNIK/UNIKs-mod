--duplicates the leftmost held consumable
BLINDSIDE.Blind({
    key = 'unik_blindside_zu',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 5},
    config = {
        extra = {
            value = 17,
        }},
    hues = {"Purple","Green", },
    rare = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_hand and context.cardarea == G.play and card.ability.extra.upgraded then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists and G.consumeables.cards[1] then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = copy_card(G.consumeables.cards[1], nil)
                        card:set_edition({negative = true}, true)
                        card.ability.unik_decaying = true
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                    return {
                        message = localize('k_duplicated_ex'),
                        colour = G.C.DARK_EDITION,
                    }
            end
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
                return { remove = true }
            end
        
        if context.cardarea == G.play and context.main_scoring and #G.consumeables.cards > 0 then
            local triggered = false
            G.E_MANAGER:add_event(Event({
                func = function() 
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            local card = copy_card(G.consumeables.cards[1], nil)
                            card:add_to_deck()
                            G.consumeables:emplace(card) 
                            card:start_materialize()
                        G.GAME.consumeable_buffer = 0
                        triggered = true
                    end
                    return true
                end}))
                if triggered then
                    return {
                        message = localize('k_duplicated_ex'),
                        colour = G.C.DARK_EDITION,
                    }
                end
            
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_zu_upgraded' or 'm_unik_blindside_zu',
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})