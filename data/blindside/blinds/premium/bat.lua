BLINDSIDE.Blind({
    key = 'unik_blindside_bat',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 4},
    config = {
        extra = {
            value = 20,
            x_mult = 1.5,
            x_mult_up = 0.5,
        }},
    hues = {"Red" , "Yellow"},
    rare = true,
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.main_scoring then
            for i,v in pairs(context.scoring_hand) do
                if (not v.config.center.basic and not v.config.center.rare and not v.config.center.curse and not v.config.center.legendary and not v.config.center.unik_ancient and not v.config.center.unik_exotic) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult,
                        colour = G.C.DARK_EDITION,
                    }, v)
                    
                    
                end

            end
            return {
                message = "" .. "",
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
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})

