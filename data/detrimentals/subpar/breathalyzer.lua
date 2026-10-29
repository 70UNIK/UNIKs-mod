UNIK.detriment{
    key = "unik_breathalyzer",
    atlas = "unik_detriments",
	pos = { x = 0, y = 1 },
    config = { extra = { discards = -1, rounds = 4, curr_round = 0,used = false} },
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    attributes = { 'detrimental','discard','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.discards,card.ability.extra.rounds,card.ability.extra.curr_round} }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end,
    in_pool = function(self, args)
        return true
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.unik_detriment_area and not context.repetition and not context.blueprint then
            if not card.ability.extra.used then
                card.ability.extra.curr_round = card.ability.extra.curr_round + 1
                if card.ability.extra.curr_round > card.ability.extra.rounds then
                    selfDestruction(card,"k_unik_weapon_destroyed",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.curr_round .. "/" .. card.ability.extra.rounds,
                        colour = G.C.BLACK,
                    }
                end
            else
                card.ability.extra.used = nil
            end
            
        end

		if context.discard and (#context.full_hand == 0 or context.other_card == context.full_hand[#context.full_hand]) and not context.blueprint then
            card.ability.extra.curr_round = 0
            card.ability.extra.used = true
            return{
                message = localize('k_reset'),
                colour = G.C.BLACK,
            }
        end
    end,
}