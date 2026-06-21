BLINDSIDE.Blind({
    key = 'unik_blindside_jail',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 3},
    config = {
        extra = {
            value = 3,
            chips = 60,
            chips_up = 60,
            mult = 8,
            mult_up = 8,
            status = "active"
        }},
    hues = {"Faded"},
    unik_exquisite = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
        if context.bld_actually_defeated_boss then
            card.ability.extra.status = "active"
        end
        if context.before and card.ability.extra.status ~= "inactive" and not context.blueprint then
            card.ability.extra.status = "inactive"
            add_tag(Tag('tag_bld_imprisonment'))
            return {
                message = localize('k_tagged_ex'),
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_bld_imprisonment
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            key = card.ability.extra.status ~= "inactive" and 'm_unik_blindside_jail' or 'm_unik_blindside_jail_inactive', vars = {card.ability.extra.mult,card.ability.extra.chips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_up
            card.ability.extra.upgraded = true
        end
    end
})

local debuffcheck = Card.bld_can_debuff_card_externally
function Card:bld_can_debuff_card_externally()
    local ret = debuffcheck(self)
    local dandyexists = false
    if self.config.center.key == 'm_unik_blindside_dandy' then
        self:set_debuff(false)
        return false
    end
    if G.play then
        for i,v in pairs(G.play) do
            if v.config.center.key == 'm_unik_blindside_dandy' then
                dandyexists = true
            end
        end
        if dandyexists and self.area == G.play then
            return false
        end
    end
    
    return ret
end