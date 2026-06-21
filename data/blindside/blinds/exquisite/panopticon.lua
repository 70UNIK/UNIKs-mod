--^^1.03 Chips to joker
--after playing this 8 times,
--create an exotic blind, destroys all other blinds, itself included. it is the only way to obtain an exotic blind.
BLINDSIDE.Blind({
    key = 'unik_blindside_panopticon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y =4},
    config = {
        extra = {
            value = 11,
            joker_eechips = 1.02,
            joker_eechips_down = 0.012,
            times = 8,
            timesdown = 2,
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
            if exists and not context.blueprint then
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
            UNIK.blindside_chips_modifyV2({ee_chips = card.ability.extra.joker_eechips}) 
            return {
                message = "^^" .. tostring(card.ability.extra.joker_eechips) .. localize('k_unik_jchips'),
                colour = G.C.BLACK,
                focus = card,
            }
        end
        if context.destroy_card and card.ability.extra.times <= 0 then
            if context.destroy_card ~= card and context.cardarea == G.play then
                card.ability.extra.created = true

                 G.E_MANAGER:add_event(Event({
                    func = function() 
                local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_unik_blindside_portal')
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
            
            return not UNIK.check_if_exists('m_unik_blindside_panopticon')  and pseudorandom('panopticon_spawn'..G.SEED) < 0.5
        else
            return false
        end
    end,
    unik_exquisite = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_unik_blindside_portal
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'unik_unique', set = 'Other'}
        return {
            vars = {
                tostring(card.ability.extra.joker_eechips),card.ability.extra.times
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.joker_eechips = card.ability.extra.joker_eechips - card.ability.extra.joker_eechips_down
        card.ability.extra.times = card.ability.extra.times - card.ability.extra.timesdown
        end
    end
})