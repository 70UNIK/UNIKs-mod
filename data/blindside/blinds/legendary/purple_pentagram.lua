BLINDSIDE.Blind({
    key = 'unik_blindside_purple_pentagram',
    atlas = 'unik_blindside_blinds',
    pos = {x = 9, y = 0},
    config = {
        extra = {
            value = 1,
            x_mult = 2,
            x_mult_up = 1,
            triggered_this_round = false,
        }},
    hues = {"Purple"},
    legendary = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
             G.E_MANAGER:add_event(Event({
                func = function() 
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_unik_blindside_backstab')
                        planet:add_to_deck()
                        G.consumeables:emplace(planet)
                        card:start_materialize()
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end}))
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.end_of_round then
            card.ability.extra.triggered_this_round = false
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_unik_blindside_backstab
        return {
            vars = {card.ability.extra.x_mult}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})