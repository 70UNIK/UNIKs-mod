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
-- SMODS.Tag:take_ownership('tag_bld_symmetry',{
--     apply = function(self, tag, context)
--         if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
--                 tag:yep('+', G.C.GREEN, function() 
--                     return true end)
--                 tag.triggered = true
--         end
--         if context.type == 'scoring_card' then
--             local numerator, denominator = SMODS.get_probability_vars(tag, 1, 2, 'symmetry', true)

--             if SMODS.pseudorandom_probability(tag, pseudoseed("symmetry"), numerator, denominator, 'symmetry') and context.card.facing ~= 'back' and context.context.cardarea == G.play then
--             --if pseudorandom('symmetry') < numerator / denominator and context.card.facing ~= 'back' and context.context.cardarea == G.play then
--                 tag:juice_up()
--                 tag_area_status_text(tag, localize('k_again_ex'), G.C.FILTER, false, 0)
--                 BLINDSIDE.rescore_card(context.card, context.context)
--             end
--         end
--     end,
-- },true)
--actually that is a very bad idea!

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

--adds shit to a global counter to easily track it and reset it
BLINDSIDE.Blind:take_ownership("m_bld_bones",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
calculate = function(self, card, context)
        if (context.cardarea == G.play or (card.ability.extra.upgraded and context.cardarea == G.hand)) and context.before and not card.ability.extra.ikeeptrackoftriggers then
            G.GAME.unik_add_bones_probability =  G.GAME.unik_add_bones_probability or 0
             G.GAME.unik_add_bones_probability =  G.GAME.unik_add_bones_probability + card.ability.extra.chance
            --G.GAME.probabilities.normal = G.GAME.probabilities.normal + card.ability.extra.chance
            card.ability.extra.ikeeptrackoftriggers = true
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
        if card.ability.extra.upgraded and (context.hand_discard or context.hand_retain) and context.other_card == card then
            return {
                burn = true
            }
        end
        -- if context.end_of_round and not context.repetition and context.playing_card_end_of_round and card.ability.extra.ikeeptrackoftriggers then
        --     card.ability.extra.ikeeptrackoftriggers = false
        -- end
    end,
},true)

BLINDSIDE.Blind:take_ownership("m_bld_wheel",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and not card.ability.extra.failed then
            if SMODS.pseudorandom_probability(card, pseudoseed("flip"), card.ability.extra.chance, card.ability.extra.trigger, 'flip') and not card.ability.extra.failed then
                card:flip()
                card:flip()
            else
                card.ability.extra.failed = true
                if card.facing ~= 'back' then 
                card:flip()
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            if not card.ability.extra.failed then
                return {
                    chips = card.ability.extra.chips
                }
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.GREEN
                }
            end
        end
        if context.after then
            card.ability.extra.failed = nil
        end
    end,
},true)

--and apply it via this function
local probab_mod = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll, no_mod)
    local numerator, denominator = probab_mod(trigger_obj, base_numerator, base_denominator, identifier, from_roll, no_mod)
    G.GAME.unik_add_bones_probability = G.GAME.unik_add_bones_probability or 0
    numerator = numerator + G.GAME.unik_add_bones_probability
    return numerator, denominator
end

BLINDSIDE.Blind:take_ownership("m_bld_tablet",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
},true)

BLINDSIDE.Blind:take_ownership("m_bld_king",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.jokerxmult = card.ability.extra.jokerxmult - 0.75
            card.ability.extra.upgraded = true
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
        if context.discard and context.main_eval and context.other_card == card then
            BLINDSIDE.chipsmodify(0, 0, card.ability.extra.jokerxmult)
            return {
                message = "X" .. card.ability.extra.jokerxmult .. " JMult",
                colour = G.C.BLACK
            }
        end
    end,
    upgrade = function(card)
            if not card.ability.extra.upgraded then
                card.ability.extra.jokerxmult = card.ability.extra.jokerxmult - 0.75
                card.ability.extra.upgraded = true
            end
        end
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
        --merge trims and editions together. Upgrade if either one is upgraded
        local upgraded = G.hand.highlighted[1].ability.extra.upgraded or G.hand.highlighted[2].ability.extra.upgraded or false
        local trim = (not G.hand.highlighted[2].seal and G.hand.highlighted[1].seal) or (not G.hand.highlighted[1].seal and G.hand.highlighted[2].seal) or false
        local edition = (not G.hand.highlighted[2].edition and G.hand.highlighted[1].edition  and G.hand.highlighted[1].edition.key) or 
        (not G.hand.highlighted[1].edition and G.hand.highlighted[2].edition and G.hand.highlighted[2].edition.key) or false
        if rand > 0.5 then
            card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(G.P_CENTERS[enhancement])
            if G.hand.highlighted[1].ability.extra.upgraded or upgraded then
                upgrade_blinds({card}, nil, true)
            end
            if trim then
                card:set_seal(trim, nil, true)
            end
            if edition then
                card:set_edition(edition,true)
            end
        else
            card = copy_card(G.hand.highlighted[2], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(enhancement)
            if G.hand.highlighted[2].ability.extra.upgraded or upgraded then
                upgrade_blinds({card}, nil, true)
            end
            if trim then
                card:set_seal(trim, nil, true)
            end
            if edition then
                card:set_edition(edition,true)
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
    order = 5,
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

BLINDSIDE.Joker:take_ownership("bl_bld_triboulet",{
    order = 20,
    joker_set = function ()
        for i, v in pairs(G.GAME.tags) do
            if v:apply_to_run({type = 'real_round_before_start', card = card}) then break end
        end
        if not G.GAME.blind.disabled then
            for i = 1, 8, 1 do
                local enhancement = 'm_bld_king'
                local card = SMODS.create_card { set = "Base", enhancement = enhancement, area = G.discard }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                card.playing_card = G.playing_card
                table.insert(G.playing_cards, card)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                            card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.deck:emplace(card)
                            card.ability.tribuolet_generated = true
                        return true
                    end
                }))
            end
            for i = 1, 8, 1 do
                local enhancement = 'm_bld_queen'
                local card = SMODS.create_card { set = "Base", enhancement = enhancement, area = G.discard }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                card.playing_card = G.playing_card
                table.insert(G.playing_cards, card)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                            card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.deck:emplace(card)
                            card.ability.tribuolet_generated = true
                        return true
                    end
                }))
            end
        end
    end,
    disable = function(self)
        for key, value in pairs(G.playing_cards) do
            if value.ability.tribuolet_generated then
                value:gore6_break()
            end
        end
    end,
    joker_defeat = function ()
        for key, value in pairs(G.playing_cards) do
            if value.ability.tribuolet_generated then
                value:gore6_break()
            end
        end
    end,
},true)

-- Chicot
BLINDSIDE.Joker:take_ownership("bl_bld_chicot",{
    order = 20,
    calculate = function(self, blind, context)
        if context.after and not blind.disabled then
            local transformed = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.ability.chicot_original then
                    scored_card.ability.chicot_original = copy3(scored_card.ability)
                    scored_card.ability.originaltype = scored_card.config.center.key
                    transformed = true
                    local new_type = 'm_bld_big'
                    if scored_card:is_color("Red") or scored_card:is_color("Yellow") then
                        new_type = 'm_bld_big'
                    elseif scored_card:is_color("Blue") or scored_card:is_color("Purple") then
                        new_type = 'm_bld_small'
                    else
                        if pseudorandom('flip') < 1/2 then
                            new_type = 'm_bld_big'
                        else
                            new_type = 'm_bld_small'
                        end
                    end
                    scored_card:set_ability(new_type, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            play_sound('tarot2', percent, 0.6)
                            return true
                        end
                    }))
                end
            end
            if transformed then    
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
            G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
        end
    end,
    disable = function()
        for key, value in pairs(G.playing_cards) do
            if value.original then
                value:set_ability(value.originaltype)
                value.ability = copy3(value.original)
                value.original = nil
            end
        end
    end,
    joker_defeat = function()
        for key, value in pairs(G.playing_cards) do
            if value.ability.chicot_original then
                value:set_ability(value.ability.originaltype)
                value.ability = copy3(value.ability.chicot_original)
                value.ability.chicot_original = nil
            end
        end
    end
},true)


local groupHook = has_group_of
function has_group_of(num, hands)
    if not hands then return false end

    return groupHook(num,hands)
end

--reroll tag: do not accumulate free rerolls, aka count the free rerolls based on total reroll tags
SMODS.Tag:take_ownership("tag_bld_reroll",{
    apply = function(self, tag, context)
        -- if context.type == 'shop_start'  then
        --     calculate_blindreroll_cost(true)
        -- end
        if context.type == 'after_reroll'  and not G.GAME.rerolled then
            --SMODS.change_free_rerolls(-1)
            print("-1 Free rerolls")
            G.GAME.unik_blindside_reroll_tags_consumed = G.GAME.unik_blindside_reroll_tags_consumed or 0
            G.GAME.unik_blindside_reroll_tags_consumed = G.GAME.unik_blindside_reroll_tags_consumed + 1
            G.GAME.rerolled = true
            tag:yep('+', G.C.GREEN, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'self_tag_added' then
            SMODS.change_free_rerolls(1)
            print("+1 Free rerolls")
        end
    end,
},true)

local vessel2 = add_tag
function add_tag(_tag)
	local ret = vessel2(_tag)
    if not _tag.ability or (_tag.ability and not _tag.ability.unik_has_been_added) then
        _tag:apply_to_run({type = 'self_tag_added', tag = _tag})
        --hopefully this only applies ONCE!
        _tag.ability.unik_has_been_added = true
    end
    
    return ret
end
--

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

local big_overrider = get_new_big
function get_new_big(current)
    if G.GAME.modifiers.unik_bld_boss_everywhere_big_small and G.GAME.unik_banana_generated and pseudorandom(pseudoseed('unik_big_override')) > 0.7 then
        return get_new_boss()
    end
    local ret =  big_overrider(current)
    
    if ret == 'bl_bld_gros_michel' or ret == 'bl_bld_cavendish' then
        G.GAME.unik_banana_generated = true
    end
    
    return ret
end
--scaling blinds will use scale_card instead so its easier to block from being copied
--The Snow (/)
--The Line (/)
--The Trench (/)
--Monolith (/)
BLINDSIDE.Blind:take_ownership("m_bld_monolith",{
    calculate = function(self, card, context)
         if context.before then
                local _best_hand, _hand, _tally = nil, nil, -1
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _best_hand = k
                        _tally = G.GAME.hands[v].played
                    end
                end
                if _hand then
                    if _hand == context.scoring_name then
                         SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "xmult_lose",
                            operation = '-',
                                no_message = true,

                        })
                        card.ability.extra.xmult = math.max(card.ability.extra.xmult,0)
                        --card.ability.extra.xmult = math.max(0, card.ability.extra.xmult - card.ability.extra.xmult_lose)
                        return {
                            message = localize("k_downgrade_ex")
                        }
                    else
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "xmult_gain",
                            operation = '+',
                                no_message = true,

                        })
                       --card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                        return {
                            message = localize("k_upgrade_ex")
                        }
                    end
                end
            end
            
            if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
    end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_trench",{
    calculate = function(self, card, context)
         if context.cardarea == G.play and context.main_scoring then
            --card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
            return {
                xchips = card.ability.extra.xchips,
                func = function ()
                         SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xchips",
                            scalar_value = "xchips_gain",
                            operation = '+',
                                no_message = true,

                        })
                    end
            }
        end
    end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_line",{
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

            if G.GAME.current_round.discards_left > 0 then
                 SMODS.scale_card(card, {
                            ref_table =card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "custom_scaler",
                            scalar_table = {
                                custom_scaler = G.GAME.current_round.discards_left * card.ability.extra.xmult_gain,
                            },
                            message_key = "a_xmult",
                            message_colour = G.C.MULT,
                        })
                        --ease_discard(-G.GAME.current_round.discards_left)
                return {
                    message = localize('k_upgrade_ex'),
                    func = function ()
                        ease_discard(-G.GAME.current_round.discards_left)
                       
                    end
                }
            end
        end

        if context.main_scoring and context.cardarea == G.play and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_snow",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.cardarea == G.hand and context.main_scoring then
            --card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain_chips
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "gain_chips",
                operation = '+',
                message_colour = G.C.CHIPS,
                -- force_full_val = true,
                -- operation = function(ref_table, ref_value, initial, scaling)
                --     ref_table[ref_value] = initial + scaling * cards
                -- end,
            })
            -- SMODS.scale_card(card, {
            --     ref_table = card.ability.extra,
            --     ref_value = "x_mult",
            --     scalar_value = "x_mult_bonus",
            --     operation = '+',
            --     message_colour = G.C.PURPLE
            -- })
            return {
                -- message = localize('k_upgrade_ex')
            }
        end

        if context.after and context.scoring_hand then
            local i_scored = false
            for key, value in pairs(context.scoring_hand) do
                if value == card then
                    i_scored = true
                    break
                end
            end

            if i_scored then
                card.ability.extra.chips = 0
                return {
                    message = localize('k_reset')
                }
            end
        end   
    end,
},true)

--curb excessive acorn scaling
BLINDSIDE.Blind:take_ownership("m_bld_amber_acorn",{
    config = {
        extra = {
            value = 1,
            xchips = 1,
            xchips_increase = 0.2,
            xchipsup = 0.2,
            hues = {"Yellow"},
        }
    },
    hues = {"Yellow"},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and not context.blueprint and not context.blueprint_card then
            local scoring = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    scoring = true
                    break
                end
            end
            if scoring then
                local step = 0
                for i, held_card in pairs(G.hand.cards) do
                    local stored_step = step
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            
                            held_card:juice_up()
                            held_card:flip()
                            if not held_card.ability.extra then
                                held_card.ability.extra = {temp_flipped = true}
                            else
                                if held_card.ability.extra.temp_flipped then
                                    held_card.ability.extra.temp_flipped = false
                                else
                                    held_card.ability.extra.temp_flipped = true
                                end
                            end
                            play_sound('chips1', 0.8 + (stored_step * 0.02))
                            card:juice_up()
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                            return true
                        end
                    }))
                    step = step + 5
                end
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_value = "custom_scaler",
                    scalar_table = {
                        custom_scaler = card.ability.extra.xchips_increase * #G.hand.cards,
                    },
                    -- scalar_value = "xchips_gain",
                    message_key = "a_xchips",
                            message_colour = G.C.CHIPS,
                        force_full_val = true,

                })
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                xchips = card.ability.extra.xchips,
            }
        end
    end,
},true)

--All in (raise/spectrum) calculation fix: make it compatible with stuff like pairs and 3 of a kinds for situations like:
--goob
--devils deal.

SMODS.PokerHandPart:take_ownership("bld_allin",{
    func = function(hand)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
            local colorsuits = {}
            local threshold = #hand
            local colors = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
            for _, v in ipairs(colors) do
                colorsuits[v] = true
            end

            local checker = false
            if next(find_joker('j_bld_checker', true)) then
                checker = true
            end

            -- < 5 hand cant be a spectrum
            if (#hand < 5 and not checker) or #hand < 3 then return {} end

            local nonwilds = {}
            for i = 1, #hand do
                local cardcolors = {}
                for _, v in ipairs(colors) do
                    -- determine table of suits for each card (for future faster calculations)
                    if hand[i]:is_color(v, nil, true) then
                        table.insert(cardcolors, v)
                    end
                end
                -- if somehow no suits: spectrum is impossible
                if #cardcolors == 0 then
                    return {}
                -- if only 1 suit: can be handled immediately
                elseif #cardcolors == 1 then
                    -- if suit is already present, lower the threshold. Ideally, duplicate colors when a spectrum can otherwise be made should not disrupt it, otherwise remove suit from "not yet used suits"
                    if colorsuits[cardcolors[1]] == false then 
                        threshold = threshold - 1
                    end
                    --If the threshold is lower than 5 (min for spectrum), it cannot be one (checkers requires no pairs)
                    if (threshold < 5) then
                        return {} 
                    end
                    colorsuits[cardcolors[1]] = false
                -- add all cards with 2-4 suits to a table to be looked at
                elseif #cardcolors < 8 then
                    table.insert(nonwilds, cardcolors)
                end
            end

            -- recursive function for iterating over combinations
            local isSpectrum 
            isSpectrum = function(i, remaining)
                -- traversed all the cards, found spectrum
                if i == #nonwilds + 1 then
                    return true
                end

                -- copy remaining suits
                local newremaining = {}
                for k, v in pairs(remaining) do
                    newremaining[k] = v
                end

                -- for every suit of the current card: 
                for _, suit in ipairs(nonwilds[i]) do
                    -- do nothing if suit has already been used
                    if remaining[suit] == true then
                        -- use up suit on this card and check next card
                        newremaining[suit] = false
                        if isSpectrum(i + 1, newremaining) then
                            return true
                        end
                        -- reset suit before continuing
                        newremaining[suit] = true
                    end
                end
                return false
            end

            -- begin iteration from first (not already considered) card
            if isSpectrum(1, colorsuits) then
                return {hand}
            else
                return {}
            end
        else
            return {}
        end
    end
 })

 SMODS.Joker:take_ownership("j_bld_matryoshka",{
    calculate = function(self, card, context)
            if context.setting_blind and card.ability.extra.last_tag then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                delay(0.4)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                return {

                }
            end
            if context.tag_triggered and not (context.tag_triggered.config and context.tag_triggered.config.extra and (context.tag_triggered.config.extra.hex or context.tag_triggered.config.extra.cannot_copy)) then
                print(inspect(context.tag_triggered))
                card.ability.extra.last_tag = context.tag_triggered.key
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = card.ability.extra.last_tag and {key = card.ability.extra.last_tag, set = 'Tag'} or nil
            info_queue[#info_queue+1] = {key = 'tag_unik_blindside_cursed', set = 'Tag'}
            return {
                vars = {
                    card.ability.extra.last_tag and localize({key = card.ability.extra.last_tag, type = 'name_text', set = 'Tag'}) or localize("matryoshka_none")
                }
            }
        end
 },true)

--all trinkets will be made retriggerable and copyable when possible 


--exquisite blinds:
--epic rarity equivalent
--stronger than premiums, weaker than legendaries
--examples include Pit Blinds and Hyperblinds