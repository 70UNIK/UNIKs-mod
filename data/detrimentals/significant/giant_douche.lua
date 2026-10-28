UNIK.detriment{
    key = "unik_giant_douche",
    atlas = "unik_detriments",
	pos = { x = 2, y = 6 },
    config = { extra = { x_mult = 0.35} },
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','discard','debuff','xmult','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult,0} }
	end,
    in_pool = function(self, args)
        return true
    end,
    remove_from_deck = function (self, card, from_debuff)
        for i,v in pairs(G.playing_cards) do
                SMODS.debuff_card(v, false, "unik_douche")
            end
    end,
    calculate = function(self, card, context)

		if context.joker_main and G.GAME.current_round.discards_left > 0 then
             return {
                x_mult = card.ability.extra.x_mult,
            }
        end
        if context.discard then
            card.ability.extra.discard_used = true
        end
        if context.end_of_round and not context.repetition and not context.blueprint then
            if card.ability.extra.primed_for_destruction then
                card.ability.extra.primed_for_destruction = nil
                selfDestruction(card,'k_drank_ex',G.C.BLACK)
            end
            
            for i,v in pairs(G.playing_cards) do
                SMODS.debuff_card(v, false, "unik_douche")
            end
        end
        if context.before then
            card.ability.extra.primed_for_destruction = nil
        end
        if context.after then
            
            for i,v in pairs(context.full_hand) do
                if not v.debuff then return end
            end
            if SMODS.calculate_round_score() >= G.GAME.blind.chips then
                card.ability.extra.primed_for_destruction = true
            end
            
        end
        if context.hand_drawn and card.ability.extra.discard_used then
            card.ability.extra.discard_used = nil
            
            for i,v in pairs(context.hand_drawn) do
                v:juice_up()
                card:juice_up()
                SMODS.debuff_card(v, true, "unik_douche")
                
            end
            play_sound("cancel", 0.8 + (0.9 + 0.2 * math.random()) * 0.2, 1)
        end

    end,
}