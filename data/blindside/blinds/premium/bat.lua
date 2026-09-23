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
                if v:is_simple_blind() then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_mult = card.ability.extra.x_mult,
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
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})

function Card:is_simple_blind()
    if not self.config.center.basic and not self.config.center.rare and not self.config.center.curse and not self.config.center.legendary then
        for a,x in pairs(BLINDSIDE.crossmod_rarities) do
            if self.config.center[x.key] then
                return false
            end
        end
        return true
    end
    return false
    
end