UNIK.detriment{
    key = "unik_hook_n_discard",
    atlas = "unik_detriments",
	pos = { x = 2, y = 0 },
    config = { extra = { min_discards = 8, discarded_cards = 2, current_discards = 0} },
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','face-down','detriment'},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.min_discards, center.ability.extra.discarded_cards, center.ability.extra.current_discards} }
	end,
    calculate = function(self, card, context)
--check discards
        if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
            if #context.full_hand == 2 then
                card.ability.extra.current_discards = card.ability.extra.current_discards + 1
                if to_big(card.ability.extra.current_discards) >= to_big(card.ability.extra.min_discards) then
                    selfDestruction(card,"k_unik_weapon_destroyed",G.C.UNIK_THE_HOOK)
                    --return true
                else
                    return {
                        message = localize({type='variable',key='a_unik_discards_1',vars={card.ability.extra.current_discards}}),
                        colour = G.C.UNIK_THE_HOOK,
                        card = card,
                    }
                end

            elseif to_big(card.ability.extra.current_discards) > to_big(0) then
                card.ability.extra.current_discards = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.UNIK_THE_HOOK,
                }
            end
        end
        --press_play
        if context.press_play then
            --taken from the hook
            G.E_MANAGER:add_event(Event({ 
                trigger = 'after',
                delay = 0.5,
                func = function()
                local any_selected = nil
                local _cards = {}
                for k, v in ipairs(G.hand.cards) do
                    if not v.highlighted and not v.highlighted_by_hook then
                        _cards[#_cards+1] = v
                    end
                end
                for i = 1, 2 do
                    if G.hand.cards and G.hand.cards[i] then 
                        local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('hook'))
                        if selected_card then
                             G.hand:brute_force_highlight(selected_card, true)
                            table.remove(_cards, card_key)
                            any_selected = true
                            selected_card.highlighted_by_hook = true
                             G.E_MANAGER:add_event(Event({ 
                            func = function()
                                selected_card.highlighted_by_hook = nil
                            return true end })) 
                            
                            play_sound('card1', 1)
                        end
                       
                    end
                end
                if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                if any_selected then
                    card:juice_up(0.8, 0.8)
                end
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_unik_hooked"),
                    colour = G.C.UNIK_THE_HOOK,
                    card=card,
                })
                
                
            return true end })) 
            delay(0.5)
        end
        --self destruct during the hook
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Hook")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_hook",G.C.UNIK_THE_HOOK)
        end
    end,
}