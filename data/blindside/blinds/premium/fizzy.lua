--retrigger rightmost blind based on number of hands and discards lost in round
BLINDSIDE.Blind({
    key = 'unik_blindside_fizzy',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 2},
    config = {
        rescore = 0,
        extra = {
            value = 23,
            rescores = 2,
            rescore = 1,
        }},
    hues = {"Blue", "Faded"},
    calculate = function(self, card, context) 
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and card.area == G.play and card.ability.extra.upgraded then
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
                for z = 1, card.ability.extra.rescores do
                    local strct = {}
                    strct[#strct+1] = context.scoring_hand[#context.scoring_hand]
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = card,
                        message = '+1',
                        colour = HEX("ff8bcb"),
                    }
                end   
            end
            
            
        end
        if context.cardarea == G.play and context.main_scoring and context.scoring_hand then
            card.ability.rescore = 0
            card.ability.extra.rescore = 1
            return {
                    func = function()
                        local area = context.scoring_hand
                        local retrigger_cards = {}
                        if area[#area] and area[#area] ~= card then
                            table.insert(retrigger_cards, area[#area])
                        end
                        for streak_index = 1, #retrigger_cards do
                            local streak_card = retrigger_cards[streak_index]
                            for _, play_card in ipairs(G.play.cards) do
                                if play_card == streak_card and streak_card.ability.extra.rescore ~= 1 then
                                    card:juice_up()
                                    local passed_context = context
                                    local retriggers = 0
                                    retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
                                    retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
                                    --card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = HEX("ff8bcb")})
                                    for i = 1, retriggers do
                                        card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = HEX("ff8bcb")})
                                        BLINDSIDE.rescore_card(play_card, passed_context)
                                    end
                                end
                            end
                        end
                        SMODS.calculate_context({rescore_cards = retrigger_cards})
                    end,
                }
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.upgraded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        end
        
        local retriggers = 0
        retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
        retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_fizzy_upgraded' or 'm_unik_blindside_fizzy',
            vars = {
                retriggers,
                card.ability.extra.rescores,

            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end,
    always_scores = true,
})