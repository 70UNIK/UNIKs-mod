--while held, X1 chips when held + X0.2 chips whenever a blind is scored, resets after hand, retained
 BLINDSIDE.Blind({
    key = 'unik_blindside_kitsune',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 2},
    config = {
    extra = {
        value = 20,
        x_chips = 1,
        x_chips_up = 0.15,
        x_chips_up_up = 0.15,
        retain = true,
    }},
    hues = {"Blue"},
    calculate = function(self, card, context) 
        if context.press_play then
            card.ability.extra.x_chips = 1
        end
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card.facing ~= "back" and  card.area == G.hand and not context.blueprint then
            return {
                func = function ()
                         SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "x_chips",
                            scalar_value = "x_chips_up",
                            operation = '+',
                         message_key = "a_xchips",
                            message_colour = G.C.CHIPS,
                        force_full_val = true,

                        })
                    end
            }
        end
        if context.cardarea == G.hand and context.main_scoring then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
        if context.after then
            card.ability.extra.x_chips = 1
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
        return {
            vars = {
                card.ability.extra.x_chips,card.ability.extra.x_chips_up
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.x_chips_up = card.ability.extra.x_chips_up + card.ability.extra.x_chips_up_up
        end
    end
})
