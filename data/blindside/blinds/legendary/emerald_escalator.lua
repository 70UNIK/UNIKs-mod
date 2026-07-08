BLINDSIDE.Blind({
    key = 'unik_blindside_emerald_escalator',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 0},
    config = {
        extra = {
            value = 1,
            x_score = 2,
            x_score_base = 2,
            x_score_mod = 0.25,
            x_score_mod_up = 0.25,
            x_score_base_up = 1,
            retain = true,
        }},
    hues = {"Green"},
    legendary = true,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.x_score = card.ability.extra.x_score_base
        end
        if context.cardarea == G.play and context.main_scoring then
            
            return {
                x_score = card.ability.extra.x_score,
                 func = function ()
                    if not context.blueprint then
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "x_score",
                            scalar_value = "x_score_mod",
                            operation = '+',
                                message_colour = G.C.PURPLE,
                                no_message = true
                                    
                        })
                    end
                      
                end
            }
        end
        if context.after then
            card.ability.extra.x_score = card.ability.extra.x_score_base
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
            vars = {card.ability.extra.x_score_base,card.ability.extra.x_score_mod}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_score_base = card.ability.extra.x_score_base + card.ability.extra.x_score_base_up
            card.ability.extra.x_score_mod = card.ability.extra.x_score_mod + card.ability.extra.x_score_mod_up
            card.ability.extra.upgraded = true
        end
    end
})