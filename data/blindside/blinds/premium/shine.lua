--2 in 5 chance to NOT apply a random edition on a random blind, burns editioned blind on successss
-- 1 in 2 chance to NOT upgrade a random played blind, if succeeds, burns itself and upgraded blind.
    BLINDSIDE.Blind({
        key = 'unik_blindside_shine',
        atlas = 'unik_blindside_blinds',
        pos = {x = 6, y = 5},
        config = {
            extra = {
                chance = 2,
                trigger = 5,
                value = 18,
            }
        },
        hues = {"Purple"},
        always_scores = true,
        rare = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                card.ability.extra.stored_seed = nil
                if card.ability.extra.upgraded or not SMODS.pseudorandom_probability(card, pseudoseed("shine_flip"), card.ability.extra.chance, card.ability.extra.trigger, 'shine_flip') and card.facing ~= "back" then
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
                    if not v.edition and v ~= card then
                        _cards[#_cards+1] = v
                    end
                end
                if #_cards > 0 then
                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('shine'))
                    local edition = poll_edition(pseudoseed('shine_unik'), nil, true, true, {'e_bld_enameled', 'e_bld_finish', 'e_bld_mint', 'e_bld_shiny'})
                    selected_card:set_edition(edition, true)
                    local success = false
                    while not success do
                        local seed = math.random(1000000,9999999)
                        local seed2 = math.random(1000000,9999999)
                        card.ability.extra.stored_seed = 'unik_shine_seed' .. seed .. seed2
                        selected_card.ability.unik_assigned_shine = card.ability.extra.stored_seed
                        local fail = falses
                        for i,v in pairs(context.scoring_hand) do
                            if v ~= card and v ~= selected_card and v.ability.unik_assigned_shine and v.ability.unik_assigned_shine == card.ability.extra.stored_seed then
                                print("Dupe seed exists, attemtping rebuild")
                                fail = true
                                card.ability.extra.stored_seed = nil
                                selected_card.ability.unik_assigned_shine = nil
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
            -- if context.cardarea == G.play and context.main_scoring then
            --     if card.facing ~= "back" then
            --         return {
                        
            --         }
            --     else
                    
            --         return {
                        
            --         }
            --     end
            -- end

            if card.facing ~= "back" and card.ability.extra.stored_seed and context.burn_card and not card.ability.extra.upgraded then
                if context.burn_card ~= card and context.burn_card.ability.unik_assigned_shine and context.burn_card.ability.unik_assigned_shine == card.ability.extra.stored_seed then
        
                    card.ability.extra.storsed_seed = nil
                    context.burn_card.ability.unik_assigned_shine = nil
                    return {
                        message = localize('k_upgrade_ex'),
                        card = context.burn_card,
                        remove = true
                    }
                end
            end

            if context.after then
                for i,v in pairs(context.scoring_hand) do
                    v.ability.unik_assigned_shine = nil
                end
                card.ability.extra.stored_seed = nil
            end
        end,
        loc_vars = function(self, info_queue, card)
        
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end
        
            local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'shine_flip')
            return {
                key = card.ability.extra.upgraded and 'm_unik_blindside_shine_upgraded' or 'm_unik_blindside_shine',
                vars = {
                    chance,
                    trigger,
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            
            card.ability.extra.upgraded = true
            end
        end
})