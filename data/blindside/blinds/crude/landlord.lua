-- -$3 per trinket owned, burns
BLINDSIDE.Blind({
    key = 'unik_blindside_landlord',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 6},
    config = {
        extra = {
            value = 30,
            money = -3,
            moneyup = 6,
            stubborn = true,
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            local dollars = 0
            for i, blindcard in pairs(G.jokers.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            blindcard:juice_up()
                            card:juice_up(0.6, 0.1)
                            play_sound('coin1', 0.8 + (0.9 + 0.2*math.random())*0.2, 0.8)
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7   
                            return true
                        end
                    }))
                    dollars = dollars + card.ability.extra.money
                end
            return {
                p_dollars = dollars,
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'} 
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_landlord_upgraded' or 'm_unik_blindside_landlord',
            vars = {
                math.abs(card.ability.extra.money),
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.moneyup
            card.ability.extra.upgraded = true
        end
    end
})