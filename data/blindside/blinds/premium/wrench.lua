-- 1 in 2 chance to NOT upgrade a random played blind, if succeeds, burns itself and upgraded blind.
    BLINDSIDE.Blind({
        key = 'unik_blindside_wrench',
        atlas = 'unik_blindside_blinds',
        pos = {x = 6, y = 3},
        config = {
            extra = {
                chance = 2,
                trigger = 3,
                trigger_up = 1,
                value = 19,
            }
        },
        hues = {"Faded"},
        always_scores = true,
        rare = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                card.ability.extra.stored_seed = nil
                if not SMODS.pseudorandom_probability(card, pseudoseed("wrench_flip"), card.ability.extra.chance, card.ability.extra.trigger, 'wrench_flip') and card.facing ~= "back" then
                    card:flip()
                    card:flip()

                local i_scored = false
                for key, value in pairs(context.scoring_hand) do
                    if value == card then
                        i_scored = true
                    end
                end

                if not i_scored then
                    return
                end

                local _cards = {}
                for k, v in ipairs(context.scoring_hand) do
                    if (not v.ability.extra or (v.ability.extra and not v.ability.extra.upgraded)) and v ~= card then
                        _cards[#_cards+1] = v
                    end
                end
                if #_cards > 0 then
                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('wrench'))
                    upgrade_blinds({selected_card})
                    local success = false
                    while not success do
                        local seed = math.random(1000000,9999999)
                        local seed2 = math.random(1000000,9999999)
                        card.ability.extra.stored_seed = 'unik_wrench_seed' .. seed .. seed2
                        selected_card.ability.unik_assigned_wrench = card.ability.extra.stored_seed
                        local fail = false
                        for i,v in pairs(context.scoring_hand) do
                            if v ~= card and v ~= selected_card and v.ability.unik_assigned_wrench and v.ability.unik_assigned_wrench == card.ability.extra.stored_seed then
                                print("Dupe seed exists, attemtping rebuild")
                                fail = true
                                card.ability.extra.stored_seed = nil
                                selected_card.ability.unik_assigned_wrench = nil
                                break      
                            end
                        end
                        if not fail then
                            success = true
                            break
                        end
                    end
                    
                end

                else
                    if card.facing ~= 'back' then 
                        card:flip()
                        card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                        return {
                            
                        }
                    end
                end
            end
            if card.facing ~= "back" and card.ability.extra.stored_seed and context.burn_card and not card.ability.extra.upgraded then
                if context.burn_card ~= card and context.burn_card.ability.unik_assigned_wrench and context.burn_card.ability.unik_assigned_wrench == card.ability.extra.stored_seed then
        
                    card.ability.extra.storsed_seed = nil
                    context.burn_card.ability.unik_assigned_wrench = nil
                    return {
                        message = localize('k_upgrade_ex'),
                        card = context.burn_card,
                        remove = true
                    }
                end
            end

            if context.after then
                for i,v in pairs(context.scoring_hand) do
                    v.ability.unik_assigned_wrench = nil
                end
                card.ability.extra.stored_seed = nil
            end
        end,
        loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end
        
            local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'wrench_flip')
            return {
                key = card.ability.extra.upgraded and 'm_unik_blindside_wrench_upgraded' or 'm_unik_blindside_wrench',
                vars = {
                    chance,
                    trigger,
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.trigger = card.ability.extra.trigger + card.ability.extra.trigger_up
            
            card.ability.extra.upgraded = true
            end
        end
})