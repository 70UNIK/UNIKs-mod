--X1.25 Mult while held, retriggers once whenever a probability fails before this scores
BLINDSIDE.Blind({
    key = 'unik_blindside_decepticon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 5},
    config = {
        extra = {
            value = 20,
            x_mult = 1.4,
            x_mult_up = 0.4,
            retriggers = 0,
            retriggers_up = 1,
            retain = true
        }},
    hues = {"Purple","Faded"},
    rare = true,
    calculate = function(self, card, context)
        if context.press_play then
            card.ability.suppress_upgrade = nil
            card.ability.extra.retriggers = 0
        end
        if context.after then
            card.ability.suppress_upgrade = true
            card.ability.extra.retriggers = 0
        end
        
        if context.repetition and context.cardarea == G.hand and card.area == G.hand and card.ability.extra.retriggers > 0 and not card.ability.extra.suppress_double_up then
            if context.other_card == card then
                card.ability.extra.suppress_double_up = true
                return {
                    repetitions = card.ability.extra.retriggers,
                    func = function ()
                        
                       card.ability.extra.suppress_double_up = nil
                    end
                }
            end
            
        end
        if context.pseudorandom_result and not context.result and card.area == G.hand and context.main_eval and not context.blueprint then
            if not card.ability.suppress_upgrade then
                card.ability.extra.retriggers = card.ability.extra.retriggers + 1
                return {
                    message = "".. card.ability.extra.retriggers,
                    colour = G.C.PURPLE,
                }
            end
            
        end
        if context.main_scoring and (context.cardarea == G.hand) then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
         if card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
        end
        return {
            vars = {card.ability.extra.x_mult}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
            
        end
    end
})