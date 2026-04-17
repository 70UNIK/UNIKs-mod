--create a shield tag --> burns, create 2 shield tags --> burns
BLINDSIDE.Blind({
    key = 'unik_blindside_shield',
    atlas = 'unik_blindside_blinds',
    pos = {x = 6, y = 7},
    config = {
        extra = {
            value = 100,
            dchips = 70,
        }},
    hues = {"Green"},
    rare = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            add_tag(Tag('tag_unik_blindside_shield'))
            return {
                focus = card,
                message = localize('k_tagged_ex'),
                card = card,
            }
        end
        if context.cardarea == G.play and context.main_scoring and card.ability.extra.upgraded then
            return {
                chips = card.ability.extra.dchips
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS['tag_unik_blindside_shield']
info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_shield_upgraded' or 'm_unik_blindside_shield',
            vars = {card.ability.extra.dchips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})