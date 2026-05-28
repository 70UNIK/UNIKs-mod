--while held, all probabilities will fail
--gains X0.075 Mult whenever a probability fails
BLINDSIDE.Blind({
    key = 'unik_blindside_fail',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 5},
    config = {
        extra = {
            value = 20,
            x_mult = 1,
            x_mult_mod = 0.35,
            x_mult_up = 0.35,
        }},
    hues = {"Purple","Yellow", },
    rare = true,
    calculate = function(self, card, context)
        if context.after then
            card.ability.suppress_upgrade = nil
        end
        
        if context.fix_probability and card.area == G.hand then
            return {
                numerator = 0,
            }
        end
        if context.pseudorandom_result and not context.result and card.area == G.hand and ((not context.cardarea and not context.main_eval) or context.main_eval) then
            if not card.ability.suppress_upgrade then
                card.ability.suppress_upgrade = true
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_mod",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT,
                    force_full_val = true,
                    delay = 0.8,
                })
                return {
                    
                }
            end
            
        end
        if context.main_scoring and (context.cardarea == G.play) then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_fail_upgraded' or 'm_unik_blindside_fail',
            vars = {card.ability.extra.x_mult_mod,card.ability.extra.x_mult}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult_mod = card.ability.extra.x_mult_mod + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})