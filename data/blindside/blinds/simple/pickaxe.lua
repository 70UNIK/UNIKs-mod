--creates a mining tag, burns --> creates 2 mining tags, burns
BLINDSIDE.Blind({
    key = 'unik_blindside_pickaxe',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 8},
    config = {
        extra = {
            value = 24,
            tags = 2,
        }},
    hues = {"Faded"},
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            add_tag(Tag('tag_bld_mining'))
            if card.ability.extra.upgraded then
                for i = 1, card.ability.extra.tags - 1 do
                    add_tag(Tag('tag_bld_mining'))
                end
            end
            return {
                card =  context.blueprint_card or card,
                message = localize('k_tagged_ex')
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_bld_mining']
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_pickaxe_upgraded' or 'm_unik_blindside_pickaxe',vars = {card.ability.extra.tags}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})