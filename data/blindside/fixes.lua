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


--taking ownership of symmetry tag to enable detection by the fail
SMODS.Tag:take_ownership('tag_bld_symmetry',{
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.GREEN, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'scoring_card' then
            local numerator, denominator = SMODS.get_probability_vars(tag, 1, 2, 'symmetry', true)

            if SMODS.pseudorandom_probability(tag, pseudoseed("symmetry"), numerator, denominator, 'symmetry') and context.card.facing ~= 'back' and context.context.cardarea == G.play then
            --if pseudorandom('symmetry') < numerator / denominator and context.card.facing ~= 'back' and context.context.cardarea == G.play then
                tag:juice_up()
                tag_area_status_text(tag, localize('k_again_ex'), G.C.FILTER, false, 0)
                BLINDSIDE.rescore_card(context.card, context.context)
            end
        end
    end,
},true)

BLINDSIDE.Blind:take_ownership("m_bld_death",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
        calculate = function(self, card, context)
            if context.before and tableContains(card, context.scoring_hand) then
                local tobedestroyed = nil
                if card.ability.extra.upgraded then
                    local myindex = 0

                    for key, value in ipairs(G.play.cards) do
                        if value == card then
                            myindex = key
                        end
                    end

                    if myindex - 1 > 0 then
                        card.ability.extra.victim = G.play.cards[myindex - 1]
                    end
                else
                    local choices = {}

                    for key, value in pairs(G.play.cards) do
                        if value ~= card then
                            table.insert(choices, value)
                        end
                    end

                    if #choices > 0 then
                        tobedestroyed = choose_stuff(choices, 1, pseudoseed('bld_death'))[1]
                    end
                end
                if tobedestroyed then
                    SMODS.calculate_context({remove_playing_cards = true, removed = {tobedestroyed}, scoring_hand = context.scoring_hand})
                    tobedestroyed.destroyed = true
                    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                        tobedestroyed:start_dissolve()
                        card_eval_status_text(
                            tobedestroyed,
                            'extra',
                            nil, nil, nil,
                            {message = "Destroyed!", colour = G.C.ORANGE, instant = true}
                        )
                        delay(0.6)
                        return true
                    end}))
                end
            end
        end,
},true)

BLINDSIDE.Blind:take_ownership("m_bld_tablet",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
},true)

function UNIK.get_enhancements_with_exact_colors(colors,ancient,cursed)
    local enhancements = {}
    local final = {}
    for key, value in pairs(G.P_CENTER_POOLS.bld_obj_blindcard_generate) do
        -- basically checks table equality
        local good = true
        if not ancient and (value.unik_ancient or value.legendary or value.unik_exotic) then
            good = false
        end
        if not cursed and value.cursed then
            good = false
        end
        for key, color in pairs(colors) do
            if not tableContains(color, value.config.extra.hues) then
                good = false
                break
            end
        end
        if good then
            for key, color in pairs(value.config.extra.hues) do
                if not tableContains(color, colors) then
                    good = false
                    break
                end
            end
            if good and G.P_CENTERS[value.key] then
                enhancements[value.key] = true
            end
        end
    end
    --convert to list
    for i,v in pairs(enhancements) do
        final[#final+1] = i
    end
    table.sort(final)
    return final

end

SMODS.Consumable:take_ownership("c_bld_assimilate",{
    use = function(self, card, area)
        local hues = {}
        for key, value in pairs(G.hand.highlighted[1].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end
        for key, value in pairs(G.hand.highlighted[2].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end

        local enhancements = UNIK.get_enhancements_with_exact_colors(hues)
        if #enhancements == 0 then
            error("UH OH, NO VALID HUE COMBO DETECTED! ")
        end
        local enhancement = pseudorandom_element(enhancements, pseudoseed("unik_assimilate"))
        local rand = pseudorandom(pseudoseed('assimilate'))

        local card
        if rand > 0.5 then
            card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(G.P_CENTERS[enhancement])
            if G.hand.highlighted[1].ability.extra.upgraded then
                upgrade_blinds({card}, nil, true)
            end
        else
            card = copy_card(G.hand.highlighted[2], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(enhancement)
            if G.hand.highlighted[2].ability.extra.upgraded then
                upgrade_blinds({card}, nil, true)
            end
        end
        
        G.hand:emplace(card)
        table.insert(G.playing_cards, card)
        destroy_blinds_and_calc(G.hand.highlighted, card)
        card:start_materialize()

        delay(0.5)
    end,
},true)

--assimilate: now takes into account multiple hues

BLINDSIDE.Joker:take_ownership("bl_bld_throwback",{
    joker_set = function(self)
        for i, v in pairs(G.GAME.tags) do
            if v:apply_to_run({type = 'real_round_before_start', card = card}) then break end
        end
        if not G.GAME.blind.disabled then
            if G.GAME.round_resets.blind_states.Small ~= 'Skipped' and G.GAME.round_resets.blind_states.Big ~= 'Skipped' then
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_big_joker_2" or "bld_playing_with_fire_each_big_joker_1"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 * (G.GAME.used_vouchers.v_bld_swearjar and 2 or 1)
                BLINDSIDE.chipsmodify(0, 0, 4, 0, true)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    BLINDSIDE.chipsupdate()
                return true end }))
            end
        end
    end,
},true)

local groupHook = has_group_of
function has_group_of(num, hands)
    if not hands then return false end

    return groupHook(num,hands)
end

--reroll tag: do not accumulate free rerolls, aka count the free rerolls based on total reroll tags
SMODS.Tag:take_ownership("tag_bld_reroll",{
    apply = function(self, tag, context)
        if context.type == 'shop_start'  then
            calculate_blindreroll_cost(true)
        end
        if context.type == 'after_reroll'  and not G.GAME.rerolled then
            --SMODS.change_free_rerolls(-1)
            G.GAME.unik_blindside_reroll_tags_consumed = G.GAME.unik_blindside_reroll_tags_consumed or 0
            G.GAME.unik_blindside_reroll_tags_consumed = G.GAME.unik_blindside_reroll_tags_consumed + 1
            G.GAME.rerolled = true
            tag:yep('+', G.C.GREEN, function() 
                return true end)
            tag.triggered = true
        end
    end,
},true)
--Finish: if on a trinket, retrigger it (when possible)

SMODS.Edition:take_ownership("e_bld_finish",{
    calculate = function(self, card, context)
        if context.repetition and card.facing ~= 'back' and context.other_card and context.other_card == card and context.other_card.ability.extra.rescore ~= 1 then
            return {
                repetitions = card.edition.extra.retriggers
            }
        end
        --trinket specific
        if (context.retrigger_joker_check) and context.other_card and context.other_card == card and card.area == G.jokers then
			if card.edition and card.edition.key == 'e_bld_finish' then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
    end
},true)

--king and queen: destroyed at end of round + can be upgraded (somehow)
BLINDSIDE.Blind:take_ownership("m_bld_king",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
            if context.cardarea == G.hand and context.main_scoring then
                BLINDSIDE.chipsmodify(0, 0, card.ability.extra.jokerxmult)
                return {
                    message = "X" .. card.ability.extra.jokerxmult .. " JMult",
                    colour = G.C.BLACK
                }
            end
                        if context.end_of_round then
                card:start_dissolve()
            end   
        end,
        upgrade = function(card)
            if not card.ability.extra.upgraded then
                card.ability.extra.upgraded = true
                card.ability.extra.jokerxmult = card.ability.extra.jokerxmult - 0.75
            end
        end
},true)
BLINDSIDE.Blind:take_ownership("m_bld_queen",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
calculate = function(self, card, context)
            if context.discard and context.other_card == card then
                BLINDSIDE.chipsmodify(0, 0, card.ability.extra.jokerxmult)
                return {
                    message = "X" .. card.ability.extra.jokerxmult .. " JMult",
                    colour = G.C.BLACK
                }
            end
                        if context.end_of_round then
                card:start_dissolve()
            end   
        end,
        upgrade = function(card)
            if not card.ability.extra.upgraded then
                card.ability.extra.upgraded = true
                card.ability.extra.jokerxmult = card.ability.extra.jokerxmult - 0.75
            end
        end
},true)