BLINDSIDE.Blind({
    key = 'unik_blindside_upgrade',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 8},
    config = {
        extra = {
            value = 20,
            mult = 4,
            chips = 30,
            mult_up = 4,
            chips_up = 30,
            chance = 1,
            trigger = 2,
        }},
    hues = {"Green" },
    rare = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
        if context.press_play and card.facing ~= 'back' then
            G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 1,
                    func = function()
                        if card.area == G.play and SMODS.pseudorandom_probability(card, pseudoseed("blind_upgrade_self"), card.ability.extra.chance, card.ability.extra.trigger, "blind_upgrade_self") then
                            upgrade_blinds({card})
                            return {
                                message = localize('k_upgrade_ex'),
                                colour = G.C.GREEN,
                            
                            }
                        end
                    return true
                end
            }))
        end
    end,
    loc_vars = function(self, info_queue, card)
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times or 0
        card.ability.extra.upgraded = false
        info_queue[#info_queue+1] = {key = 'unik_multi_upgrade', set = 'Other',vars={card.ability.extra.upgraded_times or 0}}
            local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'blind_upgrade_self')
        return {
            vars = {card.ability.extra.mult,card.ability.extra.chips,chance,trigger}
        }
    end,
    upgrade = function(card)
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_up
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
        card.ability.extra.upgraded = false
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times or 0
        card.ability.extra.upgraded_times = card.ability.extra.upgraded_times + 1
    end
})