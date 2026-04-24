--duplicates the leftmost held consumable
BLINDSIDE.Blind({
    key = 'unik_blindside_zu',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 5},
    config = {
        extra = {
            value = 17,
            chance = 2,
            trigger = 4,
            triggerup = 1,
        }},
    hues = {"Purple","Green", },
    rare = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_hand and context.cardarea == G.play then
            
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if card.facing ~= 'back' then
                if not SMODS.pseudorandom_probability(card, pseudoseed("zuflip"), card.ability.extra.chance, card.ability.extra.trigger, 'zuflip') then
                                           card:flip()
                    card:flip()
                    if card.ability.extra.upgraded then
 
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
                    
                else
                    if card.facing ~= 'back' then 
                        card:flip()
                    end
                    card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                    return {
                    }
                end
            end
           
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card and card.facing ~= 'back' then
                return { remove = true }
            end
        
        if context.cardarea == G.play and context.main_scoring and #G.consumeables.cards > 0 and card.facing ~= 'back' then
            local triggered = false
            G.E_MANAGER:add_event(Event({
                func = function() 
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        local strip_edition = G.consumeables.cards[1].edition and G.consumeables.cards[1].edition.negative
                            local card = copy_card(G.consumeables.cards[1], nil, nil, nil, strip_edition)
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
        info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'zuflip')

        local main_end
        if card.ability.extra.upgraded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_decaying_consumable" }
        end

        if G.consumeables then
            for _, v in ipairs(G.consumeables.cards) do
                if v.edition and v.edition.negative then
                    main_end = {}
                    localize {
                        type = 'other',
                        key = 'remove_negative',
                        nodes = main_end
                    }
                    break
                end
            end
        end

        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_zu_upgraded' or 'm_unik_blindside_zu',
            vars = {chance, trigger },
            main_end = main_end and main_end[1]
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            card.ability.extra.trigger = card.ability.extra.trigger + card.ability.extra.triggerup
        end
    end
})
--eval G.hand.cards[1]:set_ability('m_unik_blindside_zu')