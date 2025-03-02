SMODS.Joker {
	key = 'unik_handcuffs',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
    config = { extra = { selfDestruct = false,hand_size = -1,max = 8, min = 6} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        return { vars = { center.ability.extra.selfDestruct, center.ability.extra.hand_size, center.ability.extra.max, center.ability.extra.min } }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_manacle'), G.C.UNIK_THE_MANACLE, G.C.WHITE, 1.0 )
    end,
	add_to_deck = function(self, card, from_debuff)
		-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
		-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
		G.hand:change_size(card.ability.extra.hand_size)
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		-- Adds - instead of +, so they get subtracted when this card is removed.
		G.hand:change_size(-card.ability.extra.hand_size)
	end,
    update = function(self, card, dt)
        if G.hand then
            if G.hand.config.card_limit < card.ability.extra.min and card.ability.extra.selfDestruct == false then
                selfDestruction(card,"k_unik_manacle_small")
                card.ability.extra.selfDestruct = true
            elseif G.hand.config.card_limit > card.ability.extra.max and card.ability.extra.selfDestruct == false then
                selfDestruction(card,"k_unik_manacle_big")
                card.ability.extra.selfDestruct = true
            end
        end
    end,
    calculate = function(self, card, context)
        --old manacle counts
        if card.ability.extra.selfDestruct == false and context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Manacle" or G.GAME.blind.config.blind.key == "oldmanacle")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_manacle")
            card.ability.extra.selfDestruct = true
        end
    end
}


function selfDestruction(card,message)
    -- This part plays the animation.
    G.GAME.unik_plant_active = nil
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    card = nil
                    return true;
                end
            }))
            return true
        end
    }))
    return {
        message = localize(message),
        colour = HEX("575757"),
    }
end