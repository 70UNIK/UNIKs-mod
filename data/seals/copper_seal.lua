--Rescore card if scoring and adjacent to a card with another copper seal.
--Literally copper cards but more versatile.
--Spectral: Turing
SMODS.Seal {
    key = 'copper',
    atlas = "unik_seals",
    pos = { x = 0, y = 0 },
    badge_colour = G.C.UNIK_COPPER,
    calculate = function(self, card, context)
        if context.unik_after_effect and context.cardarea and context.cardarea == G.hand  then
            -- print("XXXXXXXXVVVV")
            -- print(context.cardarea.cards)
            local success = false
            for i = 1, #context.cardarea.cards do
                if context.cardarea.cards[i] == card then
                    if i > 1 and context.cardarea.cards[i-1].seal and context.cardarea.cards[i-1].seal == 'unik_copper' and not context.cardarea.cards[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.cardarea.cards and context.cardarea.cards[i+1].seal and context.cardarea.cards[i+1].seal == 'unik_copper' and not context.cardarea.cards[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = 1
                }
            end
        end
        if context.unik_after_effect and context.scoring_hand then
            local success = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    if i > 1 and context.scoring_hand[i-1].seal and context.scoring_hand[i-1].seal == 'unik_copper' and not context.scoring_hand[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.scoring_hand and context.scoring_hand[i+1].seal and context.scoring_hand[i+1].seal == 'unik_copper' and not context.scoring_hand[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = 1
                }
            end
        end
       
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}

local bunc_original_calculate_main_scoring = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    local calc_card_area = context.cardarea
    bunc_original_calculate_main_scoring(context, scoring_hand)

    -- Post-scoring
    
    local rescoring_cards = {}
    local max_rescore = 0
    local eval = {}

    SMODS.calculate_context({main_scoring = true, cardarea = calc_card_area, full_hand = G.play.cards, scoring_hand = scoring_hand, unik_after_effect = true},eval)
    for j,x in ipairs(calc_card_area.cards) do
        local card = x
        local rescores = 0
        for i = 1, #eval do
            if eval[i] then
                if eval[i].enhancement then
                    if eval[i].enhancement.rescore and eval[i].enhancement.card == card then
                        rescores = rescores + 1
                    end
                end
                if eval[i].seals then
                    if eval[i].seals.rescore and eval[i].seals.card == card then
                        rescores = rescores + 1
                    end
                end
            end
        end
        rescoring_cards[#rescoring_cards+1] = {card = card,rescore = rescores}
    end
    
    -- print(#rescoring_cards)
    -- print(rescoring_cards)
    local eval2 = {}
    SMODS.calculate_context({unik_kite_experiment = true,rescored_cards = rescoring_cards, cardarea = context.cardarea, full_hand = G.play.cards,scoring_hand = scoring_hand},eval2)
    for i = 1, #eval2 do
        if eval2[i] and eval2[i].jokers and eval2[i].jokers.target_cards and eval2[i].jokers.mod_rescore then
            local triggered = false
            for j,x in pairs(eval2[i].jokers.target_cards) do
                for y,c in pairs(rescoring_cards) do
                    if c.card == x then
                        triggered = true
                        c.rescore = c.rescore + eval2[i].jokers.mod_rescore
                    end
                end
            end
            if triggered then
                card_eval_status_text(eval2[i].jokers.card, 'jokers', nil, nil, nil, eval2[i].jokers)
            end
        end
    end

    for i,v in pairs(rescoring_cards) do
        max_rescore = math.max(max_rescore,v.rescore)
    end
    for i = 1, max_rescore do
        local combinedTable = {}
         
        -- SMODS.calculate_context({unik_post_rescore = true,rescored_cards = combinedTable})
        for _,v in pairs(rescoring_cards) do
            if i <= v.rescore then
                combinedTable[#combinedTable+1] = v
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        v.card:juice_up(1,1)
                        return true
                    end
                }))
            end
        end
        play_area_status_text(localize('k_unik_repeat'))
        SMODS.calculate_context({unik_post_rescore = true,rescored_cards = combinedTable,cardarea = calc_card_area})
        for _,v in pairs(rescoring_cards) do
            if i <= v.rescore then
                local pased = context
                pased.cardarea = calc_card_area 
                SMODS.score_card(v.card, pased)
            end
        end
        
    end

end

-- function UNIK.calculate_rescore(context, scoring_hand)
--     local newcardtable = context.full_hand

--     for i,v in pairs(context.scoring_hand) do
--         for j,w in pairs(newcardtable) do
--             if w == v then
--                 w.is_a_scoring_card = true
--             end
--         end
--     end

--     local eval = {}
--     local rescoring_cards = {}
--     local rescoring_counter = {}
--     local max_rescores = 0
--     --print("-------------------------")
--     SMODS.calculate_context({unik_rescore_card = true, full_hand = newcardtable,scoring_hand = scoring_hand.cards, cardarea = context.cardarea},eval)
--     for i,v in ipairs(context.cardarea.cards) do
--         local rescores = 0
--         for i = 1, #eval do
--             --print(eval[i])
            
--             if (eval[i] and eval[i].seals and eval[i].seals.card and eval[i].seals.card == v) then
--                 if eval[i].seals.rescore then
--                 --  print("Rescore ".. eval[i].seals.rescore .. " times")
--                     rescores = rescores + eval[i].seals.rescore
--                 end
--             end
--             if (eval[i] and eval[i].enhancement and eval[i].enhancement.card and eval[i].enhancement.card == v) then
--                 if eval[i].enhancement.rescore then
--                 --  print("Rescore ".. eval[i].seals.rescore .. " times")
--                     rescores = rescores + eval[i].enhancement.rescore
--                 end
--             end
--         end
--         if rescores > 0 then
--             rescoring_cards[#rescoring_cards+1] = v
--             rescoring_counter[#rescoring_counter+1] = rescores
--         end
--     end

--     for j,w in pairs(newcardtable) do
--         if w.is_a_scoring_card then
--             w.is_a_scoring_card = nil
--         end
--     end
    
--     local combinedTable = {}
--     for i = 1, #rescoring_cards do
--         combinedTable[#combinedTable+1] = {card = rescoring_cards[i], rescores = rescoring_counter[i]}
--     end
--     local eval2 = {}
--     SMODS.calculate_context({unik_kite_experiment = true,rescored_cards = combinedTable, cardarea = context.cardarea, full_hand = newcardtable,scoring_hand = scoring_hand},eval2)
--     for i = 1, #eval2 do
--         if eval2[i] and eval2[i].jokers and eval2[i].jokers.target_cards and eval2[i].jokers.mod_rescore then
--             local triggered = false
--             for j,x in pairs(eval2[i].jokers.target_cards) do
--                 for y,c in pairs(combinedTable) do
--                     if c.card == x then
--                         triggered = true
--                         c.rescores = c.rescores + eval2[i].jokers.mod_rescore
--                     end
--                 end
--             end
--             if triggered then
--                 card_eval_status_text(eval2[i].jokers.card, 'jokers', nil, nil, nil, eval2[i].jokers)
--             end
--         end
--     end
--     for i,v in pairs(combinedTable) do
--         max_rescores = math.max(v.rescores,max_rescores)
--     end
--     --print("MAX RESCORES = " .. max_rescores)
--    -- print(#rescoring_cards)
--     for i = 1, max_rescores do
         
--          for j = #combinedTable, 1, -1 do
--             --progressively delete cards from table that fall below the current counter.
--             if combinedTable[j].rescores < i then
--                 table.remove(combinedTable,j)
--             end
--         end
--         for i,v in pairs(combinedTable) do
--             G.E_MANAGER:add_event(Event({
--                 trigger = 'before',
--                 func = function()
--                     v.card:juice_up(1,1)
--                     return true
--                 end
--             }))
            
--         end
--         SMODS.calculate_context({unik_post_rescore = true,rescored_cards = combinedTable})
--         play_area_status_text(localize('k_unik_repeat'))
--         for i,v in pairs(combinedTable) do
--             local pased = context
--             SMODS.score_card(v.card, pased)
--         end
        
       
--     end
    
-- end

-- --Kite experiment changes:
-- -- 1 in 2 chance for all rescoring copper cards to gain +1 rescore.