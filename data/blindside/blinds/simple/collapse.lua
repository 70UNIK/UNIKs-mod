BLINDSIDE.Blind({
    key = 'unik_blindside_collapse',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 1},
    config = {
        extra = {
            value = 4,
            chips = 85,
            chips_up = 85,
        }},
    hues = {"Faded"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Faded", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Faded", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)
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
            card.ability.extra.chips = card.ability.extra.chips+card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end
})