--X1.75 Mult, debuffs all non-red Blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_stop',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 3},
    config = {
        extra = {
            value = 14,
            x_mult = 1.75,
            x_mult_up = 0.75,
        }},
    hues = {"Red"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if not G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if not G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
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