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
            x_mult_mod = 0.1,
            x_mult_up = 0.05,
            retain = true,
        }},
    hues = {"Purple","Yellow", },
    rare = true,
    calculate = function(self, card, context)
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
                card.ability.suppress_upgrade = nil
                return {
                    
                }
            end
            
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
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