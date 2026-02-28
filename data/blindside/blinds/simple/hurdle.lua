BLINDSIDE.Blind({
    key = 'unik_blindside_hurdle',
    atlas = 'unik_blindside_blinds',
    pos = {x = 6, y = 1},
    config = {
        extra = {
            value = 4,
            mult = 10,
            multup = 10,
        }},
    hues = {"Red"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if G.play.cards[1] ~= card then
                G.play.cards[1].config.center.blind_debuff(G.play.cards[1], true)
            else
                if card.facing ~= 'back' then 
                    card:flip()
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            if G.play.cards[1] ~= card then
                 G.play.cards[1]:set_debuff(false)
            else

            end
        end
        if context.cardarea == G.play and context.main_scoring then
            if card.facing ~= 'back' then
                 card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
                    
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
            
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.mult = card.ability.extra.mult+card.ability.extra.multup
            card.ability.extra.upgraded = true
        end
    end
})