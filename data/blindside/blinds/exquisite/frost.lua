BLINDSIDE.Blind({
    key = 'unik_blindside_frost',
    atlas = 'unik_blindside_blinds',
    pos = {x = 9, y = 5},
    config = {
        extra = {
            value = 3,
            chips = 200,
            chips_up = 200,
            ignore_hand_selection = true,
        }},
    hues = {"Blue"},
    always_scores = true,
    unik_exquisite = true,
    calculate = function(self, card, context)
           if context.cardarea == G.play and context.main_scoring then
                return {
                    chips = card.ability.extra.chips
                }
            end
    end,
    loc_vars = function(self, info_queue, card)
        
        return {
            vars = {card.ability.extra.chips,1}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end
})