--+X0.75 Mult per item Banished this run, create a K I L L when scored (must have room)
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_dagger',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 9},
    config = {
        extra = {
            value = 1,
            x_mult_mod = 0.65,
            x_mult_mod_up = 0.35,
        }},
    hues = {"Red","Faded"},
    unik_ancient = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
             G.E_MANAGER:add_event(Event({
                func = function() 
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_unik_blindside_kill')
                        planet:add_to_deck()
                        G.consumeables:emplace(planet)
                        card:start_materialize()
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end}))
            local banned_items = UNIK.get_banned_count()
            return {
                x_mult = 1+card.ability.extra.x_mult_mod*banned_items
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_unik_blindside_kill
        local banned_items = UNIK.get_banned_count()

        return {
            vars = {card.ability.extra.x_mult_mod,1+card.ability.extra.x_mult_mod*banned_items}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult_mod = card.ability.extra.x_mult_mod + card.ability.extra.x_mult_mod_up
            card.ability.extra.upgraded = true
        end
    end
})