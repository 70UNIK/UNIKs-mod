BLINDSIDE.Blind({
    key = 'unik_blindside_chromatic',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 0},
    config = {
        extra = {
            value = 10,
            x_mult = 1.6,
            x_mult_up = 0.6,
        }},
    hues = {"Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if G.GAME.current_round.hands_left%2 ~= 0 then
                if card.facing ~= 'back' then 
                    card:flip()
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            
            if G.GAME.current_round.hands_left%2 ~= 0 then
                 card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
    
                }
            else
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
            
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        
        local active = (G.GAME.current_round.hands_left%2 == 0 and G.play and G.play.cards and #G.play.cards > 0) or G.GAME.current_round.hands_left%2 ~= 0
        return {
            vars = {
                card.ability.extra.x_mult, active and localize('k_active_ex') or localize('k_inactive_ex') , colours = {active and G.C.FILTER or  G.C.UI.TEXT_INACTIVE}
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