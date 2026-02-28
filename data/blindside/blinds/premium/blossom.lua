--Rescores the first played blind twice --> If held, rescores the first and last played blinds twice, retained
BLINDSIDE.Blind({
    key = 'unik_blindside_blossom',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 2},
    config = {
        extra = {
            value = 20,
            repetitions = 2,
        }},
    hues = {"Red", "Faded"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and ((not context.cardarea and not context.main_eval) or context.main_eval) and card.area == G.hand then
            local validCards = {}
            print("1")
            for i = 1, card.ability.extra.repetitions do
                local strct = {}
                strct[#strct+1] = context.scoring_hand[1]
                if card.ability.extra.upgraded then
                    strct[#strct+1] = context.scoring_hand[#context.scoring_hand]
                end
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card = card,
                    message = '+1',
                    colour = HEX('F16C74'),
                }
            end   
            
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_blossom_upgraded' or 'm_unik_blindside_blossom',
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
--eval G.hand.cards[1]:set_ability('m_unik_blindside_blossom')
--eval G.hand.cards[1]:set_ability('m_bld_staff')