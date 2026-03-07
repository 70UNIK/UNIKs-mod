--when scored, other scoring simple blinds give X1.3 Mult
BLINDSIDE.Blind({
    key = 'unik_blindside_riff',
    atlas = 'unik_blindside_blinds',
    pos = {x = 6, y = 4},
    config = {
        extra = {
            value = 23,
            x_chips = 1.3,
            x_chips_up = 0.3,
        }},
    hues = {"Blue" },
    common = true,
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.main_scoring then
            for i,v in pairs(context.scoring_hand) do
                if v.config.center.basic then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        x_chips = card.ability.extra.x_chips,
                        colour = G.C.DARK_EDITION,
                    }, v)
                    
                    
                end

            end
            return {

            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.x_chips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_up
            card.ability.extra.upgraded = true
        end
    end
})