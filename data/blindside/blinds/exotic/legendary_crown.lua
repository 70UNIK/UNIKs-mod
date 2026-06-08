--gains ^0.1 Chips if hand exceeds best hand this run
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_golden_crown',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            value = 1,
            e_chips = 1,
            e_chips_mod = 0.05,
            e_chips_mod_up = 0.05,
        }},
    hues = {"Yellow","Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not context.blueprint then
            if to_big(G.GAME.round_scores['hand'].amt) > to_big(0) and to_big(SMODS.calculate_round_score()) >= to_big(G.GAME.round_scores['hand'].amt) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "e_chips",
                    scalar_value = "e_chips_mod",
                    operation = '+',
                    message_colour = G.C.DARK_EDITION,
                    force_full_val = true,
                })
                return {
                    
                }
            end
           
        end
        if context.cardarea == G.play and context.main_scoring and card.ability.extra.e_chips ~= 1 then
            return {
                e_chips = card.ability.extra.e_chips
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        local BlindSize = 0
        if G.GAME.round_scores and G.GAME.round_scores['hand'] and G.GAME.round_scores['hand'].amt then
            BlindSize = G.GAME.round_scores['hand'].amt
        end
        return {
            vars = {
                card.ability.extra.e_chips,card.ability.extra.e_chips_mod,BlindSize
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_chips_mod = card.ability.extra.e_chips_mod + card.ability.extra.e_chips_mod_up
            card.ability.extra.upgraded = true
        end
    end
})