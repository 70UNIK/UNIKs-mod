--X1.35 Mult, rescores adjacent blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_copper',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 3},
    config = {
        extra = {
            value = 20,
            x_mult = 1.3,
            repetitions = 1,
            xmult_up = 0.3,
            repetitions_up = 1,
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.unik_after_effect and context.scoring_hand then
            local success = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    if i > 1 and context.scoring_hand[i-1]:is_color("Yellow") and not context.scoring_hand[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.scoring_hand and context.scoring_hand[i+1]:is_color("Yellow") and not context.scoring_hand[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = card.ability.extra.repetitions
                }
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
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.repetitions
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.xmult_up
            card.ability.extra.repetitions = card.ability.extra.repetitions + card.ability.extra.repetitions_up
        card.ability.extra.upgraded = true
        end
    end
})