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
            xmult_up = 0.3
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and card.area == G.play then
            local isScoring = false
            local index = -1
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    isScoring = true
                    index = i
                    break
                end
            end
            if isScoring and index > 0 then
                local validCards = {}
                for z = 1, card.ability.extra.repetitions do
                    local strct = {}
                    if index > 1 then
                        strct[#strct+1] = context.scoring_hand[index - 1]
                    end
                    if index < #context.scoring_hand then
                        strct[#strct+1] = context.scoring_hand[index + 1]
                    end
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = card,
                        message = '+1',
                    }
                end   
            end
            
            
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
        card.ability.extra.upgraded = true
        end
    end
})