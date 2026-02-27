--fix your fucking staff

BLINDSIDE.Blind:take_ownership("m_bld_staff",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
    if context.modify_hand and context.scoring_hand then
        local i_scored = false
        for key, value in pairs(context.scoring_hand) do
            if value == card then
                i_scored = true
            end
        end

        if not i_scored then
            return
        end

        local enhancement = pseudorandom_element(SMODS.ObjectTypes.bld_obj_enhancements.enhancements, 'booster')
        local _cards = {}
        for k, v in ipairs(context.scoring_hand) do
            if not v.seal and v ~= card then
                _cards[#_cards+1] = v
            end
        end
        if #_cards > 0 then
            local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('staff'))
            G.E_MANAGER:add_event(Event({func = function()
                selected_card:juice_up(0.3, 0.5)
                return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() selected_card:flip();play_sound('tarot1');selected_card:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() selected_card:set_seal(enhancement, nil, true);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() selected_card:flip();play_sound('tarot2', 1, 0.6);selected_card:juice_up(0.3, 0.3);return true end }))
            local success = false
            while not success do
                local seed = math.random(1000000,9999999)
                local seed2 = math.random(1000000,9999999)
                card.ability.extra.stored_seed = 'bld_staff_seed' .. seed .. seed2
                selected_card.ability.bld_assigned_staff = card.ability.extra.stored_seed
                local fail = false
                 for i,v in pairs(context.scoring_hand) do
                    if v ~= card and v ~= selected_card and v.ability.bld_assigned_staff and v.ability.bld_assigned_staff == card.ability.extra.stored_seed then
                        print("Dupe seed exists, attemtping rebuild")
                        fail = true
                        card.ability.extra.stored_seed = nil
                        selected_card.ability.bld_assigned_staff = nil
                        break      
                    end
                end
                if not fail then
                    success = true
                    break
                end
            end
            
        end
    end

    if card.ability.extra.stored_seed and context.burn_card and not card.ability.extra.upgraded then
        if context.burn_card ~= card and context.burn_card.ability.bld_assigned_staff and context.burn_card.ability.bld_assigned_staff == card.ability.extra.stored_seed then
  
            card.ability.extra.storsed_seed = nil
            context.burn_card.ability.bld_assigned_staff = nil
            return {
                message = localize('k_staff'),
                card = context.burn_card,
                remove = true
            }
        end
    end

    if context.after then
        for i,v in pairs(context.scoring_hand) do
            v.ability.bld_assigned_staff = nil
        end
        card.ability.extra.stored_seed = nil
    end
end,
},true)