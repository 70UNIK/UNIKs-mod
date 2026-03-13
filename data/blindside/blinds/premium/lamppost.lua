BLINDSIDE.Blind({
    key = 'unik_blindside_lamppost',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 5},
    config = {
        rescore = 0,
        extra = {
            value = 20,
            repetitions = 1,
            rescores = 1,
            rescores_up = 1,
            repetitions_up = 1,
            rescore = 1,
        }},
    hues = {"Yellow", "Faded"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and not card.ability.extra.upgraded then
            for i=1, #G.play.cards do
                local adjacent = false
                if G.play.cards[i].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if i > 1 and G.play.cards[i-1].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if i < #G.play.cards and G.play.cards[i+1].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if not adjacent and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not card.ability.extra.upgraded  then
            for i=1, #G.play.cards do
                local adjacent = false
                if G.play.cards[i].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if i > 1 and G.play.cards[i-1].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if i < #G.play.cards and G.play.cards[i+1].config.center.key == 'm_unik_blindside_lamppost' then
                    adjacent = true
                end
                if not adjacent and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
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
                for z = 1, card.ability.extra.rescores do
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
        if context.cardarea == G.play and context.main_scoring and context.scoring_hand then
            card.ability.rescore = 0
            card.ability.extra.rescore = 1
            return {
                    func = function()
                        local self_pos = nil
                        local area = context.scoring_hand
                        local retrigger_cards = {}
                        for i=1, #context.scoring_hand do
                            if context.scoring_hand[i] == card then
                                self_pos = i
                            end
                        end
                        if self_pos then
                                if area[self_pos-1] then
                                table.insert(retrigger_cards, area[self_pos-1])
                            end
                            if area[self_pos+1] then
                                table.insert(retrigger_cards, area[self_pos+1])
                            end
                            for streak_index = 1, #retrigger_cards do
                                local streak_card = retrigger_cards[streak_index]
                                for _, play_card in ipairs(G.play.cards) do
                                    if play_card == streak_card and streak_card.ability.extra.rescore ~= 1 then
                                        card:juice_up()
                                        local passed_context = context
                                        card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.GOLD})
                                        for i = 1, card.ability.extra.repetitions do
                                            BLINDSIDE.rescore_card(play_card, passed_context)
                                        end
                                    end
                                end
                            end
                            SMODS.calculate_context({rescore_cards = retrigger_cards})
                        end
                    end,
                }
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_lamppost_upgraded' or 'm_unik_blindside_lamppost',
            vars = {
                card.ability.extra.repetitions,
                card.ability.extra.rescores
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.rescores = card.ability.extra.rescores + card.ability.extra.rescores_up
        card.ability.extra.upgraded = true
        end
    end
})