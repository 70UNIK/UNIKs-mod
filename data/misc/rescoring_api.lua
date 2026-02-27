--blindside: hook into it's own rescore function to obtain all its retriggers
if BLINDSIDE then
    local blindscore = BLINDSIDE.rescore_card
    function BLINDSIDE.rescore_card(card, context)
        local ret = blindscore(card, context)
        if not G.GAME.unik_block_blindside_rescore then
            card.blindside_rescore =  card.blindside_rescore or 0
            card.blindside_rescore =  card.blindside_rescore + 1
        end

        return ret
    end
end

local localBonusHook = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
    localBonusHook(specific_vars, desc_nodes)
    if specific_vars and specific_vars.bonus_rescores then
        localize{type = 'other', key = 'card_extra_rescore', nodes = desc_nodes, vars = {specific_vars.bonus_rescores}}
    end
end

local bunc_original_calculate_main_scoring = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    local calc_card_area = context.cardarea
    bunc_original_calculate_main_scoring(context, scoring_hand)

    -- Post-scoring
    local eval = {}
    SMODS.calculate_context({cardarea = calc_card_area, full_hand = G.play.cards, scoring_hand = scoring_hand, unik_after_effect = true},eval)
    --Enhancements
    local enhancementRescores = {}
    local sealRescores = {}
    local micelRescores = {}
    for i = 1, #eval do
        if eval[i] and type(eval[i]) == 'table' then
            for i,v in pairs(eval[i]) do
                if i == 'seals' then
                    if v.rescore and v.card then
                        v.card.unik_rescored = true
                        sealRescores[#sealRescores+1] = {card = v.card, rescore = v.rescore}
                    end
                elseif i == 'enhancement' then
                    if v.rescore and v.card then
                        v.card.unik_rescored = true
                        enhancementRescores[#enhancementRescores+1] = {card = v.card, rescore = v.rescore}
                    end
                elseif i ~= 'jokers' then
                    if v.rescore and v.card then
                        v.card.unik_rescored = true
                        micelRescores[#micelRescores+1] = {card = v.card, rescore = v.rescore}
                    end
                end
            end

        end
    end
    
    --perma_rescores
    if scoring_hand and calc_card_area ~= "unscored" and (calc_card_area == G.play) then
        for i,v in pairs(scoring_hand) do
            if v.ability and v.ability.perma_rescores and v.ability.perma_rescores > 0 then
                v.unik_rescored = true
                micelRescores[#micelRescores+1] = {card = v, rescore = v.ability.perma_rescores}
            end
        end
    end
    if (calc_card_area == G.hand) then
        for i,v in pairs(calc_card_area.cards) do
            if v.ability and v.ability.perma_rescores and v.ability.perma_rescores > 0 then
                v.unik_rescored = true
                micelRescores[#micelRescores+1] = {card = v, rescore = v.ability.perma_rescores}
            end
        end
    end
    --Jokers
    --Jokers will have individualized "source" and "message"
    --Will take in rescored cards as well cause kite experiment relies on that.
    local jokerRescores = {}
    local eval2 = {}
    SMODS.calculate_context({unik_kite_experiment = true, cardarea = calc_card_area, full_hand = G.play.cards,scoring_hand = scoring_hand},eval2)
    for i = 1, #eval2 do
        if eval2[i] and type(eval2[i]) == 'table' then
            for i,v in pairs(eval2[i]) do
                --for scenarios such as rescoring a random card and that card changes
                if v.target_cards and type( v.target_cards) == 'table' and  v.target_cards[1] and  v.target_cards[1].unik_scoring_segment then
                    for w = 1, #v.target_cards do
                        local struct = {}
                        for x = 1, #v.target_cards[w] do
                            struct[#struct+1] = {card = v.target_cards[w][x], rescore = 1}
                        end
                        struct.source = v.card or nil
                        struct.message = v.message or nil
                        struct.colour = v.colour or nil
                        --"""JOker"""
                        jokerRescores[#jokerRescores+1] = struct
                    end
                elseif v.target_cards and v.rescore then
                    local struct = {}
                    --If specified as a table, then individualize for each card(ideally align EXACTLY with the cards, but has mesures)
                    if type(v.rescore) == 'table' then
                        for z = 1, math.min(#v.target_cards,#v.rescore) do
                            local x = v.target_cards[z]
                            local rescoreAmount = v.rescore[z]
                            x.unik_rescored = true
                            struct[#struct+1] = {card = x, rescore = rescoreAmount}
                        end
                    --Otherwise apply for all selected cards
                    else
                        for j,x in pairs(v.target_cards) do
                            x.unik_rescored = true
                            struct[#struct+1] = {card = x, rescore = v.rescore}
                        end
                    end

                    struct.source = v.card or nil
                    struct.message = v.message or nil
                    struct.colour = v.colour or nil
                    jokerRescores[#jokerRescores+1] = struct
                end

            end
        end
    end
    --Amalgamate the tables:
    local combinedTable = {}
    combinedTable[#combinedTable+1] = enhancementRescores
    combinedTable[#combinedTable+1] = sealRescores
    combinedTable[#combinedTable+1] = micelRescores

    for i,v in pairs(jokerRescores) do
      --  print(v)
        combinedTable[#combinedTable+1] = v
    end
    for i,v in pairs(combinedTable) do
        local max_rescore = 0
        print("RESCORE")
        for j,w in pairs(v) do
            if type(w) == 'table' and w.rescore then
                max_rescore = math.max(max_rescore,w.rescore)
            end
            
        end
        for j = 1,max_rescore do
            local rescoring_cards = {}
            for k,w in pairs(v) do
                if type(w) == 'table' and w.card and w.rescore and j <= w.rescore then
                    rescoring_cards[#rescoring_cards+1] = w.card

                end
            end
             G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    for k,w in pairs(v) do
                        if type(w) == 'table' and w.card and w.rescore and j <= w.rescore then
                                    w.card:juice_up(1,1)

                        end
                    end
                    return true
                end
            }))
            play_area_status_text(localize('k_unik_repeat'))
            SMODS.calculate_context({unik_post_rescore = true,rescored_cards = rescoring_cards,cardarea = calc_card_area, full_hand = G.play.cards,scoring_hand = scoring_hand})
            if v.source and v.message then
                card_eval_status_text(v.source, "extra", nil, nil, nil, {
                    message = v.message,
                    colour = v.colour or G.C.FILTER,
                    card=v.source,
                })
                
            end
            for _,x in pairs(rescoring_cards) do
                local pased = context
                pased.cardarea = calc_card_area 

                SMODS.score_card(x, pased)
                if BLINDSIDE and x.blindside_rescore then
                    for z = 1, x.blindside_rescore do
                        G.GAME.unik_block_blindside_rescore = true
                        card_eval_status_text(x, "extra", nil, nil, nil, {
                            message = (localize('k_again_ex')),
                            colour = v.colour or G.C.FILTER,
                            card=x,
                        })
                        BLINDSIDE.rescore_card(x, context)

                        G.GAME.unik_block_blindside_rescore = nil
                    end
                end
            end


        end
    end
    --     --clean table
    for i,v in pairs(calc_card_area.cards) do
        if v.unik_rescored then
          --  print("CLEAN")
            v.unik_rescored = nil
        end
        v.blindside_rescore = nil
    end
    for i,v in pairs(G.play.cards) do
        if v.unik_rescored then
           -- print("CLEAN")
            v.unik_rescored = nil
        end
        v.blindside_rescore = nil
    end


end

--challenge: rescore effects on end of round
local after_round_rescore = SMODS.calculate_end_of_round_effects
function SMODS.calculate_end_of_round_effects(context)
    after_round_rescore(context)
    if not G.GAME.suppress_rescoring then
        G.GAME.suppress_rescoring = true
    
        local eval = {}
        SMODS.calculate_context({cardarea = context.cardarea, unik_after_effect = true, unik_end_of_round = true},eval)
        local enhancementRescores = {}
        local sealRescores = {}
        local micelRescores = {}
        for i = 1, #eval do
            if eval[i] and type(eval[i]) == 'table' then
                for i,v in pairs(eval[i]) do
                    if i == 'seals' then
                        if v.rescore and v.card then
                            v.card.unik_rescored = true
                            sealRescores[#sealRescores+1] = {card = v.card, rescore = v.rescore}
                        end
                    elseif i == 'enhancement' then
                        if v.rescore and v.card then
                            v.card.unik_rescored = true
                            enhancementRescores[#enhancementRescores+1] = {card = v.card, rescore = v.rescore}
                        end
                    elseif i ~= 'jokers' then
                        if v.rescore and v.card then
                            v.card.unik_rescored = true
                            micelRescores[#micelRescores+1] = {card = v.card, rescore = v.rescore}
                        end
                    end
                end

            end
        end

                --perma_rescores
        if  (context.cardarea == G.hand) then
            for i,v in pairs(context.cardarea.cards) do
                if v.ability and v.ability.perma_rescores and v.ability.perma_rescores > 0 then
                    v.unik_rescored = true
                    micelRescores[#micelRescores+1] = {card = v, rescore = v.ability.perma_rescores}
                end
            end
        end
            local jokerRescores = {}
        local eval2 = {}
        SMODS.calculate_context({unik_kite_experiment = true, cardarea = context.cardarea, unik_end_of_round = true},eval2)
        for i = 1, #eval2 do
                            --for scenarios such as rescoring a random card and that card changes
            if eval2[i] and eval2[i].jokers and eval2[i].jokers.target_cards and type(eval2[i].jokers.target_cards) == 'table' and eval2[i].jokers.target_cards[1] and eval2[i].jokers.target_cards[1].unik_scoring_segment then
                for w = 1, #eval2[i].jokers.target_cards do
                    local struct = {}
                    for x = 1, #eval2[i].jokers.target_cards[w] do
                        struct[#struct+1] = {card = eval2[i].jokers.target_cards[w][x], rescore = 1}
                    end
                    struct.source = eval2[i].jokers.card
                    struct.message = eval2[i].jokers.message
                    struct.colour = eval2[i].jokers.colour
                    jokerRescores[#jokerRescores+1] = struct
                end
            elseif eval2[i] and eval2[i].jokers and eval2[i].jokers.target_cards and eval2[i].jokers.rescore then
                local struct = {}
                --If specified as a table, then individualize for each card(ideally align EXACTLY with the cards, but has mesures)
                if type(eval2[i].jokers.rescore) == 'table' then
                    for z = 1, math.min(#eval2[i].jokers.target_cards,#eval2[i].jokers.rescore) do
                        local x = eval2[i].jokers.target_cards[z]
                        local rescoreAmount = eval2[i].jokers.rescore[z]
                        x.unik_rescored = true
                        struct[#struct+1] = {card = x, rescore = rescoreAmount}
                    end
                --Otherwise apply for all selected cards
                else
                    for j,x in pairs(eval2[i].jokers.target_cards) do
                        x.unik_rescored = true
                        struct[#struct+1] = {card = x, rescore = eval2[i].jokers.rescore}
                    end
                end
                
                
                -- if triggered then
                --     card_eval_status_text(eval2[i].jokers.card, 'jokers', nil, nil, nil, eval2[i].jokers)
                -- end
                struct.source = eval2[i].jokers.card
                struct.message = eval2[i].jokers.message
                struct.colour = eval2[i].jokers.colour
                jokerRescores[#jokerRescores+1] = struct
            end
        end
        --Amalgamate the tables:
        local combinedTable = {}
        combinedTable[#combinedTable+1] = enhancementRescores
        combinedTable[#combinedTable+1] = sealRescores
        combinedTable[#combinedTable+1] = micelRescores

        for i,v in pairs(jokerRescores) do
        --  print(v)
            combinedTable[#combinedTable+1] = v
        end
        for i,v in pairs(combinedTable) do
            local max_rescore = 0
            for j,w in pairs(v) do
                if type(w) == 'table' and w.rescore then
                    max_rescore = math.max(max_rescore,w.rescore)
                end
                
            end
            for j = 1,max_rescore do
                local rescoring_cards = {}
                for k,w in pairs(v) do
                    if type(w) == 'table' and w.card and w.rescore and j <= w.rescore then
                        rescoring_cards[#rescoring_cards+1] = w.card

                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        for k,w in pairs(v) do
                            if type(w) == 'table' and w.card and w.rescore and j <= w.rescore then
                                        w.card:juice_up(1,1)

                            end
                        end
                        return true
                    end
                }))
                play_area_status_text(localize('k_unik_repeat'))
                SMODS.calculate_context({unik_post_rescore = true,rescored_cards = rescoring_cards,cardarea = context.cardarea})
                if v.source and v.message then
                    card_eval_status_text(v.source, "extra", nil, nil, nil, {
                        message = v.message,
                        colour = v.colour or G.C.FILTER,
                        card=v.source,
                    })
                    
                end
                if #rescoring_cards > 0 then
                    local pased = context
                    pased.unik_end_round_rescored_cards = rescoring_cards
                    after_round_rescore(pased)
                end
                
            end
        end
            --clean table
        for i,v in pairs(context.cardarea.cards) do
            if v.unik_rescored then
            --  print("CLEAN")
                v.unik_rescored = nil
            end
        end
        for i,v in pairs(G.play.cards) do
            if v.unik_rescored then
            -- print("CLEAN")
                v.unik_rescored = nil
            end
        end
    end
    G.GAME.suppress_rescoring = nil
end