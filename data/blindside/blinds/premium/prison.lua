--the prison: X4 Mult to Joker, burns, after this is played 3 times, banishes itself and all other copies of the prison in deck, then creates a Legendary Blind in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_prison',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y =4},
    config = {
        extra = {
            value = 11,
            joker_xmult = 3,
            joker_xmult_down = 1,
            times = 5,
            timesdown = 1,
            unik_unique = true
        }},
    hues = {"Faded"},
    gore6_break = true,
    calculate = function(self, card, context) 
        if context.before then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists then
                card.ability.extra.times = card.ability.extra.times - 1
                return {
                    focus = card,
                    message = card.ability.extra.times .. "",
                    card = card,
                    colour = G.C.RED,
                }
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            UNIK.blindside_chips_modifyV2({x_mult = card.ability.extra.joker_xmult}) 
            return {
                message = "X" .. card.ability.extra.joker_xmult .. localize('k_unik_jmult'),
                colour = G.C.BLACK,
                focus = card,
            }
        end
        if context.destroy_card and card.ability.extra.times <= 0 then
            if context.destroy_card == card and context.cardarea == G.play then
                local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_bld_blindsoul')
                planet:add_to_deck()
                G.consumeables:emplace(planet)
                return { remove = true }
            end
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card and card.ability.extra.times > 0 then
            return { remove = true }
        end
        
    end,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            for i,v in pairs(G.playing_cards) do
                if v.config.center.key == 'm_unik_blindside_prison' then
                    return false
                end
            end
            if G.pack_cards then
                for i,v in pairs(G.pack_cards.cards) do
                    if v.config.center.key == 'm_unik_blindside_prison' then
                        return false
                    end
                end
            end
            if G.shop_jokers then
                for i,v in pairs(G.shop_jokers.cards) do
                    if v.config.center.key == 'm_unik_blindside_prison' then
                        return false
                    end
                end
            end
            if G.shop_booster then
                for i,v in pairs(G.shop_booster.cards) do
                    if v.config.center.key == 'm_unik_blindside_prison' then
                        return false
                    end
                end
            end
            
            return pseudorandom('cage'..G.SEED) < 0.4
        else
            return false
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_bld_blindsoul
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'unik_unique', set = 'Other'}
        return {
            vars = {
                card.ability.extra.joker_xmult,card.ability.extra.times
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.joker_xmult = card.ability.extra.joker_xmult - card.ability.extra.joker_xmult_down
        card.ability.extra.times = card.ability.extra.times - card.ability.extra.timesdown
        end
    end
})