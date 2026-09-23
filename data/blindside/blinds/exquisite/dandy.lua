BLINDSIDE.Blind({
    key = 'unik_blindside_dandy',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 4},
    config = {
        extra = {
            value = 3,
            x_mult = 1.75,
            x_chips = 1.75,
            x_mult_up = 0.75,
            x_chips_up = 0.75,
        }},
    hues = {"Faded","Red","Green","Yellow","Blue","Purple"},
    unik_exquisite = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            
            return {
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        
        return {
            vars = {card.ability.extra.x_mult,card.ability.extra.x_chips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult +card.ability.extra.x_mult_up
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_up
            card.ability.extra.upgraded = true
        end
    end
})

local debuffcheck = BLINDSIDE.can_debuff_card_externally
function BLINDSIDE.can_debuff_card_externally(card)
    local ret = debuffcheck(card)
    local dandyexists = false
    if card.config.center.key == 'm_unik_blindside_dandy' then
        card:set_debuff(false)
        return false
    end
    if G.play then
        for i,v in pairs(G.play.cards) do
            if v.config.center.key == 'm_unik_blindside_dandy' then
                dandyexists = true
            end
        end
        if dandyexists and card.area == G.play then
            return false
        end
    end
    
    return ret
end