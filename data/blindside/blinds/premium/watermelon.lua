BLINDSIDE.Blind({
    key = 'unik_blindside_watermelon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 2},
    config = {
        extra = {
            value = 20,
            repetitions = 1,
        }},
    hues = {"Red", "Green"},
    calculate = function(self, card, context) 
         if context.unik_kite_experiment and ((context.scoring_hand and context.cardarea == G.play)) and card.area == G.play then
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
                    for i,v in pairs(context.scoring_hand) do
                        if v:is_color("Red", true, false) or (card.ability.extra.upgraded and v:is_color("Green", true, false)) then
                            strct[#strct+1] = v
                        end
                    end
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = card,
                        message = '+1',
                        colour = G.C.MULT
                    }
                end   
            end
        end
        if context.unik_kite_experiment and (context.cardarea == G.hand) and card.area == G.play then
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
                    for i,v in pairs(context.cardarea) do
                        if v:is_color("Red", true, false) or (card.ability.extra.upgraded and v:is_color("Green", true, false)) then
                            strct[#strct+1] = v
                        end
                    end
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = card,
                        message = '+1',
                        colour = G.C.MULT
                    }
                end   
            end
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and not card.ability.extra.upgraded then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Blue", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                    -- if not card.ability.extra.upgraded  then
                    --     G.play.cards[i].will_be_destroyed_1 = true
                    -- end
                     
                end
            end
            for i=1, #G.hand.cards do
                 if G.hand.cards[i]:is_color("Blue", true, false) then
                     G.hand.cards[i].config.center.blind_debuff(G.hand.cards[i], true)
                    --  if not card.ability.extra.upgraded  then
                    --     G.play.cards[i].will_be_destroyed_1 = true
                    -- end
                 end
               
            end
        end
        -- if context.cardarea == G.play and context.after and card.facing ~= 'back' and card.ability.extra.upgraded  then
        --     for i=1, #G.play.cards do
        --         if G.play.cards[i]:is_color("Blue", true, false) and G.play.cards[i] ~= card then
        --             G.play.cards[i]:set_debuff(false)
        --         end
        --     end
        --     for i=1, #G.hand.cards do
        --         if G.hand.cards[i]:is_color("Blue", true, false) then
        --             G.hand.cards[i]:set_debuff(false)
        --             local carder = G.hand.cards[i]
        --             if carder.facing == 'back' and (not carder.ability.extra or (carder.ability.extra and not carder.ability.extra.flipped)) then
        --                 G.E_MANAGER:add_event(Event({
        --                     func = function()
        --                         carder:flip()
        --                         return true
        --                     end,
        --                 }))
                        
        --             end
        --         end
                
        --     end
        -- end
        if context.destroy_card  and not card.ability.extra.upgraded and card.area == G.play and (context.cardarea == G.play or context.cardarea == G.hand) then
            if (context.destroy_card.area == G.play or context.destroy_card.area == G.hand) and context.destroy_card:is_color("Blue", true, false) then
                context.destroy_card.retain = true
                return { 
                    remove = true, 
                }
            end
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        -- local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.fail, card.ability.extra.chance, 'watermelon')
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_watermelon_upgraded' or 'm_unik_blindside_watermelon',
            -- vars = {chance,trigger}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})