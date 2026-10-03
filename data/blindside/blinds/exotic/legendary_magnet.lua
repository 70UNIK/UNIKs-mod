--^1.1 mult when held, +1 hand size when held; upgraded version retains and incraese to ^1.14
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_maroon_magnet',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 2},
    config = {
        extra = {
            value = 1,
            e_mult = 1.1,
            e_mult_up = 0.05,
            hand_size = 1,
            retain = true
        }},
    hues = {"Red","Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.hand and context.main_scoring then
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
            vars = {
                card.ability.extra.e_mult,card.ability.extra.hand_size,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_up
            card.ability.extra.upgraded = true
        end
    end
})