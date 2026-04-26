--+10 Mult, always on the rightmost positon
BLINDSIDE.Blind({
    key = 'unik_blindside_pinned',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 8},
    config = {
        extra = {
            left_pinned = true,
            value = 34,
            x_mult = 1.65,
            x_mult_up = 0.65,
        }
    },
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end,
})