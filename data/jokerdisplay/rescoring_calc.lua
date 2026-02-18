--ah yes, CALCULATING RESCORES......... fuck@!

local retriggers = JokerDisplay.calculate_card_triggers
JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)
    local ret = retriggers(card, scoring_hand, held_in_hand)
    local scores = 1
    if G.jokers then
        for _, area in ipairs(JokerDisplay.get_display_areas()) do
            for _, joker in pairs(area.cards) do
                local joker_display_definition = JokerDisplay.Definitions[joker.config.center.key]
                local rescore_function = not joker.debuff and joker.joker_display_values and
                    ((joker_display_definition and joker_display_definition.rescore_function) or
                        (joker.joker_display_values.blueprint_ability_key and
                            not joker.joker_display_values.blueprint_debuff and not joker.joker_display_values.blueprint_stop_func and
                            JokerDisplay.Definitions[joker.joker_display_values.blueprint_ability_key] and
                            JokerDisplay.Definitions[joker.joker_display_values.blueprint_ability_key].retrigger_function))

                if rescore_function then
                    -- The rounding is for Cryptid compat
                    scores = scores + 
                        math.floor(rescore_function(card, scoring_hand, held_in_hand or false,
                            joker.joker_display_values and not joker.joker_display_values.blueprint_stop_func and
                            joker.joker_display_values.blueprint_ability_joker or joker) or 0)
                    
                end
            end
        end
    end
    --seal and enhancement calc
    if scoring_hand and not held_in_hand then
        for j = 1, #scoring_hand do
            if scoring_hand[j] == card then
                if card.seal and card.seal == 'unik_copper' then
                    if j > 1 and scoring_hand[j-1].seal and scoring_hand[j-1].seal == 'unik_copper' and not scoring_hand[j-1].debuff then
                        scores = scores + 1
                    elseif j < #scoring_hand and scoring_hand[j+1].seal and scoring_hand[j+1].seal == 'unik_copper' and not scoring_hand[j+1].debuff then
                        scores = scores + 1
                    end
                end
                if SMODS.has_enhancement(card,'m_bunc_copper') then
                    if j > 1 and SMODS.has_enhancement(scoring_hand[j-1],'m_bunc_copper') and not scoring_hand[j-1].debuff then
                        scores = scores + 1
                    elseif j < #scoring_hand and SMODS.has_enhancement(scoring_hand[j+1],'m_bunc_copper') and not scoring_hand[j+1].debuff then
                        scores = scores + 1
                    end
                end
                
                break
            end
        end
    end
    if held_in_hand then
        for j = 1, #G.hand.cards do
            if G.hand.cards[j] == card then
                if card.seal and card.seal == 'unik_copper' then
                    if j > 1 and G.hand.cards[j-1].seal and G.hand.cards[j-1].seal == 'unik_copper' and not G.hand.cards[j-1].debuff then
                        scores = scores + 1
                    elseif j < #G.hand.cards and G.hand.cards[j+1].seal and G.hand.cards[j+1].seal == 'unik_copper' and not G.hand.cards[j+1].debuff then
                        scores = scores + 1
                    end
                end
                break
            end
        end
    end
    
    scores = scores
    return ret * scores
end
