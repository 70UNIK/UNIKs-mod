--+10 Mult, debuffs all scoring red blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_approval',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 0},
    config = {
        extra = {
            value = 24,
            mult = 10,
            mult_up = 10,
        }},
    hues = {"Green"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                    
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)

                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                mult = card.ability.extra.mult
            }
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
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_up
            card.ability.extra.upgraded = true
        end
    end
})