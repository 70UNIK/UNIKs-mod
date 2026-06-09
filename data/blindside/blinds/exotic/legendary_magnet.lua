--^1.1 mult when held, +1 hand size when held; upgraded version retains and incraese to ^1.14
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_maroon_magnet',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 2},
    config = {
        extra = {
            value = 1,
            e_mult = 1.1,
            e_mult_up = 0.1,
        }},
    hues = {"Red","Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.hand and context.main_scoring then
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
        if tableContains(card, G.hand.cards) and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not card.ability.extra.created_tag then
            card.ability.extra.created_tag = true
            add_tag(Tag('tag_bld_toss'))
            
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        end
        info_queue[#info_queue + 1] = G.P_TAGS['tag_bld_toss']
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_maroon_magnet_upgraded' or 'm_unik_blindside_legendary_maroon_magnet',
            vars = {
                card.ability.extra.e_mult
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_up
            card.ability.extra.retain = true
            card.ability.extra.upgraded = true
        end
    end
})