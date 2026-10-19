UNIK.detriment{
    key = "unik_border_wall",
    atlas = "unik_detriments",
	pos = { x = 0, y = 0 },
    config = { extra = { blind_size = 2,exceeds = 2,applied = false} },
    severity = 2,
    attributes = { 'detrimental','xblindsize','immediate','detriment' },
    add_to_deck = function(self, card, from_debuff)
        print("2")
		-- If it appears during a blind (purple pentagram, trick o treat), then it should adjust it on spawn
        if G.GAME.blind.in_blind and card.ability.extra.applied == false then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate(true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("timpani")
                            delay(0.4)
                            return true
                        end,
                    }))
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize("cry_good_luck_ex"),
                        colour = HEX("8a59a5"),
                        card=card,
                    })
                    return true
                end,
            }))

            card.ability.extra.applied = true
        end
	end,
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.blind_size, center.ability.extra.exceeds} }
	end,
    dongtong_compat = false,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
        print("1")
		-- On destruction, if in blind, change size.
        if G.GAME.blind.in_blind and card.ability.extra.applied == true then
            G.GAME.blind.chips = G.GAME.blind.chips / card.ability.extra.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate(true)
        end
	end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if card.ability.extra.applied == false then
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound("timpani")
                                delay(0.4)
                                return true
                            end,
                        }))
                        if (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Wall")) and not (G.GAME.blind.disabled) then
                            selfDestruction(card,"k_unik_blind_start_wall",HEX("8a59a5"))
                        else
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("cry_good_luck_ex"),
                                colour = HEX("8a59a5"),
                                card=card,
                            })
                        end
                        return true
                    end,
                }))
                card.ability.extra.applied = true
            end
        end
        --end applied
        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            card.ability.extra.applied = false
            if (G.GAME.chips > G.GAME.blind.chips * card.ability.extra.exceeds) then
                selfDestruction(card,"k_unik_wall_jumped",HEX("8a59a5"))
            end
        end
    end
}