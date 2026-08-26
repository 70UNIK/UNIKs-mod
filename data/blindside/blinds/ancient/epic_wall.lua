--^1 Mult, gains ^0.025 Mult after it is played
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_wall',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 6},
    config = {
        extra = {
            value = 1,
            e_mult = 0.95,
            e_mult_up = 0.05,
            e_mult_up2 = 0.02,
            x_mult = 0.5,
            x_mult_up = 0.5,
            x_mult_up2 = 0.5,
        }
    },
    hues = {"Purple", "Green"},
    hidden = true,
    unik_ancient = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "e_mult",
                scalar_value = "e_mult_up",
                operation = '+',
                message_key = "a_powmult",
                    message_colour = G.C.DARK_EDITION,
                    force_full_val = true,
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "x_mult",
                scalar_value = "x_mult_up",
                operation = '+',
                message_key = "a_xmult",
                    message_colour = G.C.RED,
                    force_full_val = true,
            })
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult,
            }
        end
        if context.scoring_hand and SMODS.in_scoring(card,context.scoring_hand) and context.final_scoring_step then
            
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.e_mult,card.ability.extra.e_mult_up,card.ability.extra.x_mult,card.ability.extra.x_mult_up
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
        card.ability.extra.e_mult_up = card.ability.extra.e_mult_up + card.ability.extra.e_mult_up2
        card.ability.extra.x_mult_up = card.ability.extra.x_mult_up + card.ability.extra.x_mult_up2
        card.ability.extra.upgraded = true
        end
    end
})