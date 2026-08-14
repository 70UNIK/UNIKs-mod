--exclusive to whitenight, X1.5 mult to joker when scored, stubborn.
    BLINDSIDE.Blind({
        key = 'unik_blindside_apostle',
        atlas = 'unik_blindside_blinds',
        pos = {x = 5, y = 8},
        config = {
            extra = {
                value = 30,
                jokerxmult = 1.5,
                jokerxmultdown = 0.75,
            }},
        hues = {"Faded"},
        curse = true,
        hidden = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                UNIK.blindside_chips_modifyV2({x_mult = card.ability.extra.jokerxmult}) 
                return {
                    message = "X" .. card.ability.extra.jokerxmult .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = card,
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
            return {
                vars = {
                    card.ability.extra.jokerxmult,
                }
            }
        end,
        upgrade = function(card)
            if not card.ability.extra.upgraded then
                card.ability.extra.jokerxmult = card.ability.extra.jokerxmult - card.ability.extra.jokerxmultdown
                card.ability.extra.upgraded = true
            end
        end
    })