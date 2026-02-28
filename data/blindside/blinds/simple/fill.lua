--+60 Chips, debuffs all held blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_fill',
    atlas = 'unik_blindside_blinds',
    pos = {x = 6, y = 0},
    config = {
        extra = {
            value = 24,
            chips = 65,
            chips_up = 65,
        }},
    hues = {"Red"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            for i=1, #G.hand.cards do
                G.hand.cards[i].config.center.blind_debuff(G.hand.cards[i], true)
                G.hand.cards[i].debuffed_by_fill = true
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            
            for i=1, #G.hand.cards do
                G.hand.cards[i]:set_debuff(false)
                G.hand.cards[i].debuffed_by_fill = nil
                local carder = G.hand.cards[i]
                if carder.facing == 'back' and (not carder.ability.extra or (carder.ability.extra and not carder.ability.extra.flipped)) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            carder:flip()
                            return true
                        end,
                    }))
                    
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end
})