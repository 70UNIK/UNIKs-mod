--the bubbles: adjacent blinds held in hand are rescored 2 times --> 4 times
 BLINDSIDE.Blind({
    key = 'unik_blindside_bubbles',
    atlas = 'unik_blindside_blinds',
    pos = {x = 6, y = 2},
    rare = true,
    config = {
        extra = {
            value = 20,
            repetitions = 2,
        }},
        hues = {"Blue", "Yellow"},
        calculate = function(self, card, context) 
            if context.unik_kite_experiment and context.cardarea == G.hand and ((not context.cardarea and not context.main_eval) or context.main_eval) and card.area == G.hand then
                local validCards = {}
                 local self_pos = nil
                 local currcard = context.blueprint_card or card
                for i=1, #G.hand.cards do
                    if G.hand.cards[i] == currcard then
                        self_pos = i
                    end
                end
                
                for i = 1, card.ability.extra.repetitions do
                    local strct = {}
                    if self_pos > 1 then
                        strct[#strct+1] = G.hand.cards[self_pos - 1]
                    end
                    if self_pos < #G.hand.cards then
                        strct[#strct+1] = G.hand.cards[self_pos + 1]
                    end
                    
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = context.blueprint_card  or card,
                        message = '+1',
                        colour = HEX('F7F063'),
                    }
                end   
                
            end
            if context.repetition and context.cardarea == G.hand and card.area == G.hand and card.ability.extra.upgraded then
                local self_pos = nil
                for i=1, #G.hand.cards do
                    if G.hand.cards[i] == card then
                        self_pos = i
                    end
                end
                if G.hand.cards[self_pos-1] == context.other_card then
                    return {
                        repetitions = card.ability.extra.repetitions
                    }
                end
                if G.hand.cards[self_pos+1] == context.other_card then
                    return {
                        repetitions = card.ability.extra.repetitions
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
            return {
                key = card.ability.extra.upgraded and 'm_unik_blindside_bubbles_upgraded' or 'm_unik_blindside_bubbles',
                vars = {
                    card.ability.extra.repetitions
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            end
        end
    })