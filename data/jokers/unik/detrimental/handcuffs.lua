SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_handcuffs',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
	pos = { x = 4, y = 0 },
    no_dbl = true,
    cost = 1,
    config = { extra = { selfDestruct = false,hand_size = -1,max = 8, min = 6} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    immutable = true,
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
        card.ability.extra.max = G.hand.config.card_limit
        card.ability.extra.min = G.hand.config.card_limit - 2
        
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		-- Adds - instead of +, so they get subtracted when this card is removed.
		G.hand:change_size(-card.ability.extra.hand_size)
	end,
    calculate = function(self, card, context)
        if card.ability.extra.selfDestruct == false and context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Manacle")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_manacle",HEX("575757"))
            card.ability.extra.selfDestruct = true
        end
    end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_handcuffs"] = {
		text = {
            { text = "(" },
            {
                ref_table = "card.ability.extra",
                ref_value = "min",
            },
            { text = " <= " },
            {
                ref_table = "card.joker_display_values",
                ref_value = "hand_size",
            },
            { text = " <= " },
            {
                ref_table = "card.ability.extra",
                ref_value = "max",
            },
            { text = ")" },
        },
        text_config = { colour = G.C.FILTER },
        calc_function = function(card)
            card.joker_display_values.hand_size = G.hand and G.hand.config.card_limit or "NIL"
        end
	}
end
