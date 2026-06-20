BLINDSIDE.Blind({
    key = 'unik_blindside_salmon_steps',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 1},
    config = {
        extra = {
            value = 1,
            jxchips = 0.75,
        }},
    hues = {"Red"},
    legendary = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and not G.GAME.unik_old_operator then
            G.GAME.unik_old_operator = true
            BLINDSIDE.joker_operator(G.GAME.blindside_current_operator-1)
            return {
                message = localize('k_unik_lowered'),
                colour = G.C.DARK_EDITION,
                focus = card,
            }
               
            end
        if context.cardarea == G.play and context.main_scoring then
            UNIK.blindside_chips_modifyV2({x_chips = card.ability.extra.jxchips}) 
                return {
                    message = "X" .. card.ability.extra.jxchips .. localize('k_unik_jchips'),
                    colour = G.C.BLACK,
                    focus = card,
                }
            else
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {card.ability.extra.jxchips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})