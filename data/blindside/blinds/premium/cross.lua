--create a peak tag before scoring, burns --> create a peak tag before scoring
BLINDSIDE.Blind({
    key = 'unik_blindside_cross',
    atlas = 'unik_blindside_blinds',
    pos = {x =2, y = 3},
    config = {
        extra = {
            value = 100,
        }},
    hues = {"Red"},
    rare = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            add_tag(Tag('tag_unik_blindside_peak'))
            return {
                focus = card,
                message = localize('k_tagged_ex'),
                card = card,
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card and not card.ability.extra.upgraded then
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS['tag_unik_blindside_peak']
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_cross_upgraded' or 'm_unik_blindside_cross',

        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})