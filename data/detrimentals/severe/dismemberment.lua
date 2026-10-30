UNIK.detriment{
    key = "unik_dismemberment",
    atlas = "unik_detriments",
	pos = { x = 5, y = 2 },
    config = { extra = { added = false,selection_limit = -1, hand = -1,hand_size = -1,cards_added = 0,cards_to_add = 12} },
    severity = 3,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = false,
    attributes = { 'detrimental','hands','detriment','selection_limit'},
     loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.hand,center.ability.extra.selection_limit, center.ability.extra.hand_size, center.ability.extra.cards_to_add, center.ability.extra.cards_added } }
	end,
    add_to_deck = function(self, card, from_debuff)
		-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
		-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
		G.hand:change_size(card.ability.extra.hand_size)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
        ease_hands_played(card.ability.extra.hand)
        SMODS.change_play_limit(card.ability.extra.selection_limit)
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		-- Adds - instead of +, so they get subtracted when this card is removed.
        G.hand:change_size(-card.ability.extra.hand_size)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hand
            ease_hands_played(-card.ability.extra.hand)
            SMODS.change_play_limit(-card.ability.extra.selection_limit)
		
	end,
    calculate = function(self, card, context)
        if context.playing_card_added and context.cards and not context.blueprint then
            card.ability.extra.cards_added = card.ability.extra.cards_added + #context.cards
            if card.ability.extra.cards_added >= card.ability.extra.cards_to_add then
                selfDestruction(card,'k_unik_arm_healed',G.C.BLACK)
            else
                return{
                    message = card.ability.extra.cards_added .. "/" .. card.ability.extra.cards_to_add,
                    colour = G.C.BLACK,
                }
            end
        end
    end
}