--^1.05 Chips, --> ^1.08 Chips
--+2 Card selection limit when played or held
--+2 hand size when held
--retained
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_sapphire_stamp',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 4},
    config = {
        card_limit = 2,
        extra = {
            value = 1,
            selection_limit = 2,
            hand_size = 2,
            xlogchips_base = 10,
            xlogchips_basedown = 3,
            xchips = 2,
            xchips_up = 1,
            retain = true,
            bld_return_to_hand_after_play = true,
        }},
    hues = {"Blue","Yellow"},
    calculate = function(self, card, context) 
        if (context.cardarea == G.play or (context.cardarea == G.hand and card.ability.extra.upgraded)) and context.main_scoring then
            return {
                x_chips = card.ability.extra.xchips,
                xlog_chips = card.ability.extra.xlogchips_base,
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_sapphire_stamp_upgraded' or 'm_unik_blindside_legendary_sapphire_stamp',
            vars = {
                card.ability.extra.xchips,card.ability.extra.xlogchips_base,card.ability.extra.selection_limit,card.ability.extra.hand_size,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.xlogchips_base = card.ability.extra.xlogchips_base - card.ability.extra.xlogchips_basedown
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_up
            card.ability.extra.upgraded = true
        end
    end
})