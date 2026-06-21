BLINDSIDE.Blind({
    key = 'unik_blindside_circus',
    atlas = 'unik_blindside_blinds',
    pos = {x = 9, y = 3},
    config = {
        extra = {
            value = 20,
            x_mult_p = 1.5,
            x_mult_p_up = 0.5,
            x_mult_e_=1.75,
            x_mult_e_up=0.5,
            x_mult_l=2,
            x_mult_l_up=0.5,
            x_mult_a = 2.25,
            x_mult_a_up = 0.5,
        }},
    hues = {"Red"},
    unik_exquisite = true,
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.main_scoring then
            for i,v in pairs(context.scoring_hand) do
                if v.config.center.rare then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult_p,
                        colour = G.C.RED,
                    }, v)
                end
                for a,x in pairs(BLINDSIDE.crossmod_rarities) do
                    if v.config.center[x.key] and x.key ~= 'unik_exquisite' and x.key ~= 'unik_ancient' and x.key ~= 'unik_exotic' then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                card:juice_up()
                                return true
                            end
                        }))
                        SMODS.calculate_effect({
                            x_mult = card.ability.extra.x_mult_e,
                            colour = G.C.RED,
                        }, v)
                    end
                end
                if v.config.center.unik_exquisite then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult_e,
                        colour = G.C.RED,
                    }, v)
                end
                if v.config.center.legendary then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult_l,
                        colour = G.C.RED,
                    }, v)
                end
                if v.config.center.unik_ancient or v.config.center.unik_exotic then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult_a,
                        colour = G.C.RED,
                    }, v)
                end

            end
            return {
                
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.x_mult}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult_p = card.ability.extra.x_mult_p + card.ability.extra.x_mult_p_up
            card.ability.extra.x_mult_e = card.ability.extra.x_mult_e + card.ability.extra.x_mult_e_up
            card.ability.extra.x_mult_l = card.ability.extra.x_mult_l + card.ability.extra.x_mult_l_up
            card.ability.extra.x_mult_a = card.ability.extra.x_mult_a + card.ability.extra.x_mult_a_up
            card.ability.extra.upgraded = true
        end
    end
})