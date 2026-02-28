BLINDSIDE.Blind({
    key = 'unik_blindside_chromatic',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 0},
    config = {
        extra = {
            value = 10,
            mult = 12,
            multup = 12,
            jokermult = 2,
            jokermultdown = 1,
        }},
    hues = {"Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            if G.GAME.current_round.hands_left%2 == 0 then
                BLINDSIDE.chipsmodify(card.ability.extra.jokermult, 0, 0)
                return {
                    message = "+" .. card.ability.extra.jokermult .. localize('k_unik_jmult'),
                    colour = G.C.BLACK
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
            
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        
        local active = (G.GAME.current_round.hands_left%2 ~= 0 and G.play and G.play.cards and #G.play.cards > 0) or G.GAME.current_round.hands_left%2 == 0
        return {
            vars = {
                card.ability.extra.mult, active and localize('k_active_ex') or localize('k_inactive_ex'),card.ability.extra.jokermult , colours = {active and G.C.FILTER or G.C.RED}
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multup
            card.ability.extra.jokermult = card.ability.extra.jokermult - card.ability.extra.jokermultdown
            card.ability.extra.upgraded = true
        end
    end
})