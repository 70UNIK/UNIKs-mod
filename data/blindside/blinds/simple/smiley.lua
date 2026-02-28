BLINDSIDE.Blind({
    key = 'unik_blindside_smiley',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 1},
    config = {
        extra = {
            value = 34,
            x_mult = 2,
            x_mult_up = 1,
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
                -card.ability.extra_slots_used,
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