SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_border_wall',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
    no_dbl = true,
	pos = { x = 1, y = 0 },
    cost = 1,
    config = { extra = { selfDestruct = false,blind_size = 2,exceeds = 3,applied = false} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        return { vars = { center.ability.extra.selfDestruct, center.ability.extra.blind_size, center.ability.extra.exceeds} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_wall'), G.C.UNIK_THE_WALL, G.C.WHITE, 1.0 )
    end,
    gameset_config = {
		modest = {extra = {selfDestruct = false,blind_size = 1.4,exceeds = 2,applied = false} },
	},
	add_to_deck = function(self, card, from_debuff)
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
                        --Unique to gungeon III, never self destruct if absolute.
                        if card.ability.extra.selfDestruct == false and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Wall")) and not (G.GAME.blind.disabled) and not card.ability.cry_absolute then
                            selfDestruction(card,"k_unik_blind_start_wall",HEX("8a59a5"))
                            card.ability.extra.selfDestruct = true
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
            if (G.GAME.chips > G.GAME.blind.chips * card.ability.extra.exceeds and not card.ability.cry_absolute) then
                selfDestruction(card,"k_unik_wall_jumped",HEX("8a59a5"))
                card.ability.extra.selfDestruct = true
            end
        end
    end
}


-- function SselfDestruction(card,message)
--     -- This part plays the animation.
--     G.E_MANAGER:add_event(Event({
--         func = function()
--             play_sound('tarot1')
--             card.T.r = -0.2
--             card:juice_up(0.3, 0.4)
--             card.states.drag.is = true
--             card.children.center.pinch.x = true
--             G.E_MANAGER:add_event(Event({
--                 trigger = 'after',
--                 delay = 0.3,
--                 blockable = false,
--                 func = function()
--                     G.jokers:remove_card(card)
--                     card:remove()
--                     card = nil
--                     return true;
--                 end
--             }))
--             return true
--         end
--     }))
--     return {
--         message = localize(message),
--         colour = HEX("8a59a5"),
--         card=card,
--     }
-- end