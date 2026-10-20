UNIK.detriment{
    key = "unik_handcuffs",
    atlas = "unik_detriments",
	pos = { x = 4, y = 1 },
    config = { extra = { selfDestruct = false,hand_size = -1,max = 8, min = 6} },
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = false,
    attributes = { 'detrimental','hand_size','detriment', 'immediate'},
     loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        return { vars = { center.ability.extra.selfDestruct, center.ability.extra.hand_size, center.ability.extra.max, center.ability.extra.min } }
	end,
    add_to_deck = function(self, card, from_debuff)
		-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
		-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
		G.hand:change_size(card.ability.extra.hand_size)
        card.ability.extra.max = G.hand.config.card_limit
        card.ability.extra.min = G.hand.config.card_limit - 2
        
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		-- Adds - instead of +, so they get subtracted when this card is removed.
		G.hand:change_size(-card.ability.extra.hand_size)
	end,
    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Manacle")) and not (G.GAME.blind.disabled) and not context.blueprint then
            selfDestruction(card,"k_unik_blind_start_manacle",HEX("575757"))
        end
        if context.unik_hand_size_change and G.hand and context.cardarea == G.hand and not context.blueprint then
            if G.hand.config.card_limit < v.ability.extra.min then
                selfDestruction(v,"k_unik_manacle_small",HEX("575757"))
            elseif G.hand.config.card_limit > v.ability.extra.max then
                selfDestruction(v,"k_unik_manacle_big",HEX("575757"))
            end
        end
    end
}