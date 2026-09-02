--the earthmover: ^1.1 Mult to Joker, after playing this 4 times, destroys itself and other copies of itself in deck, then creates an Ancient Blind in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_earthmover',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y =4},
    config = {
        extra = {
            value = 11,
            joker_emult = 1.3,
            joker_emultdown = 0.15,
            times = 7,
            timesdown = 1,
            unik_unique = true
        }},
    hues = {"Faded"},
    metalbreak = {colour = {55/255,55/255,55/255,1.0}},
    calculate = function(self, card, context) 
        if context.before then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists and not context.blueprint then
                card.ability.extra.times = card.ability.extra.times - 1
                return {
                    focus = card,
                    message = card.ability.extra.times .. "",
                    card =  card,
                    colour = G.C.RED,
                }
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            UNIK.blindside_chips_modifyV2({e_mult = card.ability.extra.joker_emult}) 
            return {
                message = "^" .. card.ability.extra.joker_emult .. localize('k_unik_jmult'),
                colour = G.C.BLACK,
                focus = card,
            }
        end
        if context.destroy_card and card.ability.extra.times <= 0 then
            if context.destroy_card == card and context.cardarea == G.play and not card.ability.extra.created  then
                card.ability.extra.created = true
                G.E_MANAGER:add_event(Event({
                    func = function() 
                            local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_unik_blindside_pentatope')
                            planet:add_to_deck()
                            G.consumeables:emplace(planet)
                        return true
                    end}))

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
            return not UNIK.check_if_exists('m_unik_blindside_earthmover') 
        else
            return false
        end
    end,
    unik_exquisite = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_unik_blindside_pentatope
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'unik_unique', set = 'Other'}
        return {
            vars = {
                card.ability.extra.joker_emult,card.ability.extra.times
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.joker_emult = card.ability.extra.joker_emult - card.ability.extra.joker_emultdown
        card.ability.extra.times = card.ability.extra.times - card.ability.extra.timesdown
        end
    end
})

--checks if a copy exists in deck, in the shop, or in boosters
function UNIK.check_if_exists(blind_key)
    if G.GAME.selected_back.effect.center.config.extra then
        if not G.GAME.selected_back.effect.center.config.extra.blindside then return nil end
        for i,v in pairs(G.playing_cards) do
            if v.config.center.key == blind_key then
                return true
            end
        end
        if G.pack_cards and G.pack_cards.cards then
            for i,v in pairs(G.pack_cards.cards) do
                if v.config.center.key == blind_key then
                    return true
                end
            end
        end
        if G.shop_jokers and G.shop_jokers.cards then
            for i,v in pairs(G.shop_jokers.cards) do
                if v.config.center.key == blind_key then
                    return true
                end
            end
        end
        if G.shop_booster and G.shop_booster.cards then
            for i,v in pairs(G.shop_booster.cards) do
                if v.config.center.key == blind_key then
                    return true
                end
            end
        end
        return false
    end
    --error("Blindside is not active! This check should not happen! Contact 70UNIK for assistance")
    return nil
end