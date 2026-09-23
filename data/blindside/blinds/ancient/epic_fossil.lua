BLINDSIDE.Blind({
    key = 'unik_blindside_epic_fossil',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 10},
    config = {
        extra = {
            value = 1,
            hand_bonus_mult = 2,
            hand_bonus_mult_up = 0.5,
        }},
    hues = {"Green","Red"},
    calculate = function(self, card, context) 
        if (context.hand_discard or context.hand_retain) and context.other_card == card and card.ability.extra.upgraded then
                return { burn = true }
            end
        if context.before and context.main_eval and context.scoring_name and card.area == G.hand then
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {instant = true, message = localize('k_upgrade_ex') --[[index]], colour = HEX('0A7C4C')})
                    return true
                end,
            }))
            
            G.GAME.hands[context.scoring_name].chips = G.GAME.hands[context.scoring_name].chips*card.ability.extra.hand_bonus_mult
            if not context.instant then
                delay(1)
            end
                    if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
                        
                        update_hand_text({delay = 0.25}, {
                            chips = "X" .. card.ability.extra.hand_bonus_mult, 
                            level = G.GAME.hands[context.scoring_name].level,
                            handname = localize(context.scoring_name, 'poker_hands'),
                        StatusText = true})
                        G.E_MANAGER:add_event(Event({
                            trigger = "immediate",
                            func = function()
                                local carder = context.blueprint_card or card
                                carder:juice_up(1,1)
                                play_sound("xchips",0.95,1)
                                return true
                            end,
                        }))
                    end
                    if not context.instant then
                        delay(0.5)
                    end
                
                    G.GAME.hands[context.scoring_name].mult = G.GAME.hands[context.scoring_name].mult*card.ability.extra.hand_bonus_mult
                    if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
                        update_hand_text({delay = 0.25}, {
                            mult = "X" .. card.ability.extra.hand_bonus_mult, 
                            level = G.GAME.hands[context.scoring_name].level,
                            handname = localize(context.scoring_name, 'poker_hands'),
                            StatusText = true})
                        G.E_MANAGER:add_event(Event({
                            trigger = "immediate",
                            func = function()
                                local carder = context.blueprint_card or card
                                carder:juice_up(1,1)
                                play_sound("multhit2",0.95,1)
                                return true
                            end,
                        }))
                    end
                    if not context.instant then
                        delay(0.5)
                        update_hand_text(
                            {sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                            {mult = G.GAME.hands[context.scoring_name].mult, chips = G.GAME.hands[context.scoring_name].chips, handname = localize(context.scoring_name, 'poker_hands'), level = G.GAME.hands[context.scoring_name].level}
                        )
                        delay(1)
                    end

            return {
                
            }
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.hand_bonus_mult
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.hand_bonus_mult = card.ability.extra.hand_bonus_mult + card.ability.extra.hand_bonus_mult_up
            card.ability.extra.upgraded = true
        end
    end
})