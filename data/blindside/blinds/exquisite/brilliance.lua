BLINDSIDE.Blind({
    key = 'unik_blindside_brilliance',
    atlas = 'unik_blindside_blinds',
    pos = {x = 9, y = 4},
    config = {
        extra = {
            value = 3,
            money = 13,
            money_up = 12,
            batteries = 2,
            batteries_up = 2,
        }},
    hues = {"Yellow"},
    unik_exquisite = true,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            for i = 1, card.ability.extra.batteries do
                add_tag(Tag('tag_bld_battery'))
            end
            return {
                message = localize('k_tagged_ex'),
            }
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                p_dollars = card.ability.extra.money,
            
            }
            
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            card.ability.extra.succeed = nil
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_bld_battery
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {card.ability.extra.money,card.ability.extra.batteries,}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_up
            card.ability.extra.batteries = card.ability.extra.batteries + card.ability.extra.batteries_up
            card.ability.extra.upgraded = true
        end
    end
})