--X1.5 Mult, can upgrade ininitely
BLINDSIDE.Blind({
    key = 'unik_blindside_scrum',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 8},
    config = {
        extra = {
            value = 20,
            x_mult = 1.5,
            x_mult_up = 0.75,
        }},
    hues = {"Purple" },
    rare = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times or 0
        card.ability.extra.upgraded = false
        info_queue[#info_queue+1] = {key = 'unik_multi_upgrade', set = 'Other',vars={card.ability.extra.upgraded_times or 0}}
        return {
            vars = {card.ability.extra.x_mult}
        }
    end,
    upgrade = function(card)
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
        card.ability.extra.upgraded = false
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times or 0
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times + 1
    end
})