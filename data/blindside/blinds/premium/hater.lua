BLINDSIDE.Blind({
    key = 'unik_blindside_hater',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 5},
    config = {
        extra = {
            value = 18,
            x_mult = 2,
            x_mult_up = 1,
        }},
    hues = {"Blue", "Red"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            card.hater_scoring = nil
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    card.hater_scoring = true
                    break
                end
            end
            
        end
        if context.after then
            card.hater_scoring = nil
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})