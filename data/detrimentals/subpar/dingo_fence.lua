UNIK.detriment{
    key = "unik_dingo_fence",
    atlas = "unik_detriments",
	pos = { x = 3, y = 4 },
    config = { extra = { blind_size = 1.5,no_hands_rounds = 4,rounds = 0,applied = false,fire = false} },
    severity = 1,
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
                        colour = G.C.UNIK_MILD,
                        card=card,
                    })
                    return true
                end,
            }))

            card.ability.extra.applied = true
        end
	end,
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.blind_size, center.ability.extra.no_hands_rounds,center.ability.extra.rounds} }
	end,
    blueprint_compat = true,
    immutable = true,
    dongtong_compat = false,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
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
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("cry_good_luck_ex"),
                            colour = G.C.BLACK,
                            card=card,
                        })
                        return true
                    end,
                }))
                card.ability.extra.applied = true
            end
        end
        --end applied
        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            if not card.ability.extra.fire then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
                if card.ability.extra.rounds >= card.ability.extra.no_hands_rounds then
                    selfDestruction(card,"k_unik_wall_jumped",G.C.BLACK)
                else
                    return {
                        message = card.ability.extra.rounds .. "/" .. card.ability.extra.no_hands_rounds,
                        colour = G.C.BLACK,
                    }
                end
            end
            card.ability.extra.fire = false
            
        end
        if context.final_scoring_step and SMODS.calculate_round_score() > G.GAME.blind.chips and not context.blueprint  then
            card.ability.extra.fire = true
            card.ability.extra.rounds = 0
			return {
                message = localize('k_reset'),
                colour = G.C.BLACK,
			}
		end
    end
}