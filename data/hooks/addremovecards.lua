function CheckSlots(card,slotLimit)
    --Check joker slots for when Joker Card is added, removed
    --if  context.cardarea == G.jokers and not context.blueprint_card and not context.retrigger_joker then
    --print("SlotCount")
    if G.jokers.config.card_limit <= slotLimit then
        selfDestruction(card,"k_unik_happiness3",G.C.BLACK)
    end
end

function selfDestruction(card,message,color,dissolve)
    -- This part plays the animation.
    G.E_MANAGER:add_event(Event({
        func = function()
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize(message),
                colour = color,
                card=card,
                delay = 0.5,
            })
            --Dissolving
            if (dissolve) then
                card:start_dissolve()
            --extinct animation
            else
                play_sound('tarot1')
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        G.jokers:remove_card(card)
                        card:remove()
                        card = nil
                        return true;
                    end
                }))
            end
            
            return true
        end
    }))
end


local removeHook = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if (self.added_to_deck) then
        --Pirahna Plant and other suit based cursed Jokers go here,
        
        --print("Joker deleted")
        --print(self.ability.name)
        --Happiness is mandatory: Joker slot check
        --Counter for autocannibalism
        local cannibalCards = 0
        local autoCannibalExists = false
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_happiness" then
                --print("checkSlots")
                CheckSlots(v,v.ability.extra.slotLimit)
            --Autocannibalism: check if any turtle beans, ice cream, popcorn or ramen remain
            elseif v.ability.name == "j_unik_autocannibalism" then
                autoCannibalExists = true
            elseif v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" or v.config.center.key == "j_cry_clicked_cookie" then
                cannibalCards = cannibalCards + 1
            elseif v.ability.name == "j_unik_ghost_trap" then
                if self.config.center.rarity == "cry_cursed" and self.ability.extra.getting_captured then
                    self.ability.extra.getting_captured = nil
                    v.ability.extra.x_mult = v.ability.extra.x_mult + v.ability.extra.x_mult_mod
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.0,
                        blockable = false,
                        func = function()
                            card_eval_status_text(v, "extra", nil, nil, nil, {
                                message = localize({
                                    type = "variable",
                                    key = "a_xmult",
                                    vars = {
                                        number_format(to_big(v.ability.extra.x_mult)),
                                    },
                                }),
                                colour = G.C.MULT,
                                card = v,
                                delay = 0.5
                            })
                            return true;
                        end
                    }))
                end
            end

        end
        --Apply depleted stickers if an autocannibalism exists
        if (cannibalCards > 0 and autoCannibalExists) then
            for _, v in pairs(G.jokers.cards) do
                --print("Joker in set:")
                --print(v.ability.name)
                if not v.ability.unik_depleted then
                    if v.ability.name == "Turtle Bean" then
                        --cancel out hand size increase
                        G.hand:change_size(-v.ability.extra.h_size)
                        v.ability.unik_depleted = true
                        v.ability.eternal = true
                        v.ability.extra.h_size = 0
                    elseif  v.ability.name == "Ramen" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true            
                        v.ability.x_mult = 1      
                    elseif v.ability.name == "Ice Cream" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.extra.chips = 0
                    elseif v.config.center.key == "j_cry_clicked_cookie" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.extra.chips = 0
                    elseif v.ability.name == "Popcorn" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.mult = 0
                    end
                end
            end
        elseif (autoCannibalExists)then
            --destroy all autocannibalism instances
            for _, v in pairs(G.jokers.cards) do
                --print("Joker in set:")
                --print(v.ability.name)
                if v.ability.name == "j_unik_autocannibalism" then
                    selfDestruction(v,"k_eaten_ex",G.C.BLACK)
                end
            end
        end
    end
    local ret = removeHook(self,from_debuff)
    return ret
end
local emplaceHook = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)

    emplaceHook(self,card, location, stay_flipped)
    --Happiness is mandatory: Joker slot check after the hook
    local cannibalCards = 0
    local autoCannibalExists = false
    
    if self == G.jokers then
        --Replace average alice with alice in a 0.6% chance (for now for test purposes, 60%)
        if (SMODS.Mods["extracredit"] or {}).can_load then
            if card.config.center.key == "j_ExtraCredit_averagealice" then
                if pseudorandom('unik_average_alice_exotic_change') < 0.8/100 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("k_unik_average_alice"),
                                colour = G.C.PURPLE,
                                card=card,
                            })
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true;
                                end
                            }))
                            local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_unik_extra_credit_alice")
                            card2:start_materialize()
                            card2:add_to_deck()
                            G.jokers:emplace(card2)
                            return true
                        end
                    }))
                end
            end
        end

        --print("Joker added")
        --print(card.ability.name)
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_happiness" then
                --print("checkSlots")
                CheckSlots(v,v.ability.extra.slotLimit)
                --Autocannibalism: forcibly apply eternal and depleted to all new and existing turtle beans, ice cream, popcorn and ramen Jokers
            elseif v.ability.name == "j_unik_autocannibalism" then
                autoCannibalExists = true
            elseif v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" or v.config.center.key == "j_cry_clicked_cookie" then
                cannibalCards = cannibalCards + 1
            --ghost trap functionality
            elseif v.ability.name == "j_unik_ghost_trap" then
                GhostTrap1(v)
            --Formidicus fix, now constantly destroys cursed jokers
            elseif v.config.center.key == "j_cry_formidiulosus" then
                for x, w in pairs(G.jokers.cards) do
                    if w.config.center.rarity == "cry_cursed" and not w.ability.extra.getting_captured then
                        --destory ghost
                        selfDestruction(w,"k_unik_pentagram_purified",G.C.MULT)
                        card_eval_status_text(v, "extra", nil, nil, nil, {
                            message = localize("k_nope_ex"),
                            colour = G.C.BLACK,
                            delay = 0.3
                        })
                    end
                end
            end

        end
    end
    --Apply depleted stickers if an autocannibalism exists
    if (cannibalCards > 0 and autoCannibalExists) then
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if not v.ability.unik_depleted then
                if v.ability.name == "Turtle Bean" then
                    --cancel out hand size increase
                    G.hand:change_size(-v.ability.extra.h_size)
                    v.ability.unik_depleted = true
                    v.ability.eternal = true
                    v.ability.extra.h_size = 0
                elseif  v.ability.name == "Ramen" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true            
                    v.ability.x_mult = 1   
                elseif v.ability.name == "Ice Cream" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.extra.chips = 0
                elseif v.config.center.key == "j_cry_clicked_cookie" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.extra.chips = 0
                elseif v.ability.name == "Popcorn" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.mult = 0
                end
            end
        end
    -- elseif (autoCannibalExists)then
    --     --destroy all autocannibalism instances
    --     for _, v in pairs(G.jokers.cards) do
    --         --print("Joker in set:")
    --         --print(v.ability.name)
    --         if v.ability.name == "j_unik_autocannibalism" then
    --             selfDestruction(v,"k_eaten_ex",G.C.BLACK)
    --         end
    --     end
    end
end

function GhostTrap1(self)
    for x, w in pairs(G.jokers.cards) do
        if w.config.center.rarity == "cry_cursed" and not w.ability.extra.getting_captured then
            --Add to value
            table.insert(self.ability.extra.cursed_joker_list,w)
            --set to list amount
            self.ability.extra.cursed_jokers = #self.ability.extra.cursed_joker_list
            w.ability.extra.getting_captured = true
            --destory ghost
            selfDestruction(w,"k_unik_ghost_trap_captured",G.C.MULT,true)
            --If too much
            if (self.ability.extra.cursed_jokers > self.ability.extra.cursed_joker_limit) then
                selfDestruction(self,"k_unik_ghost_trap_explode",G.C.BLACK)
            end
        end
    end
end

--calculate debuffed cards if Death is used (replace card)
local deathDebuffCopy = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    local res = deathDebuffCopy(other, new_card, card_scale, playing_card, strip_edition)
    if G.jokers then
        for x, h in pairs(G.jokers.cards) do
            if h.ability.name == "j_unik_the_plant" then
                local faceCards = 0
                if G.deck and h.added_to_deck then 
                    for i, w in pairs(G.deck.cards) do
                        if w:is_face(true) then
                            SMODS.debuff_card(w,true,"unik_plant")
                            faceCards = faceCards + 1  
                        -- Handle incase others do have debuffs
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,"unik_plant")
                        end
                    end
                end
                if G.hand and h.added_to_deck then 
                    for i, w in pairs(G.hand.cards) do
                        if w:is_face(true) then
                            SMODS.debuff_card(w,true,"unik_plant")
                            faceCards = faceCards + 1  
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,"unik_plant")
                        end
                    end
                end
                if G.play and h.added_to_deck then 
                    for i, w in pairs(G.play.cards) do
                        if w:is_face(true) then
                            SMODS.debuff_card(w,true,"unik_plant")
                            faceCards = faceCards + 1  
                        -- Handle incase others do have debuffs
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,"unik_plant")
                        end
                    end
                end
                if G.discard and h.added_to_deck then 
                    for i, w in pairs(G.discard.cards) do
                        if w:is_face(true) then
                            SMODS.debuff_card(w,true,"unik_plant")
                            faceCards = faceCards + 1  

                            -- Handle incase others do have debuffs
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,"unik_plant")
                        end
                    end
                end 
                if h.added_to_deck then
                    h.ability.extra.faceCards = faceCards
                    if (faceCards < h.ability.extra.minFaceCards or faceCards <= 0) and h.ability.extra.selfDestruct == false and G.jokers then
                        selfDestruction(h,"k_unik_plant_no_face",HEX("709284"))
                        h.ability.extra.selfDestruct = true
                    end
                end   
            elseif h.ability.name == "j_unik_caveman_club" or  h.ability.name == "j_unik_broken_window" or h.ability.name == "j_unik_goading_joker" or  h.ability.name == "j_unik_headless_joker" then
                local Cards = 0
                if G.deck and h.added_to_deck then 
                    for i, w in pairs(G.deck.cards) do
                        --bypass debuff to ensure it doesnt self destruct
                        if w:is_suit(h.ability.extra.suit,true) then
                            Cards = Cards + 1
                            SMODS.debuff_card(w,true,h.ability.extra.debuff_name)

                            -- Handle incase others do have debuffs
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,h.ability.extra.debuff_name)
                        end
                    end
                end
                if G.hand and h.added_to_deck then 
                    for i, w in pairs(G.hand.cards) do
                        if w:is_suit(h.ability.extra.suit,true) then
                            Cards = Cards + 1     
                            SMODS.debuff_card(w,true,h.ability.extra.debuff_name)           
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,h.ability.extra.debuff_name)
                        end
                    end
                end
                if G.play and h.added_to_deck then 
                    for i, w in pairs(G.play.cards) do
                        if w:is_suit(h.ability.extra.suit,true) then
                            Cards = Cards + 1  
                            SMODS.debuff_card(w,true,h.ability.extra.debuff_name)
                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,h.ability.extra.debuff_name)
                        end
                    end
                end
                if G.discard and h.added_to_deck then 
                    for i, w in pairs(G.discard.cards) do
                        if w:is_suit(h.ability.extra.suit,true) then
                            Cards = Cards + 1     
                            SMODS.debuff_card(w,true,h.ability.extra.debuff_name)

                        elseif not w.debuff then
                            SMODS.debuff_card(w,false,h.ability.extra.debuff_name)
                        end
                    end
                end 
                if h.added_to_deck then
                    h.ability.extra.cards = Cards
                    if (Cards < h.ability.extra.minCards or Cards <= 0) and h.ability.extra.selfDestruct == false and G.jokers then
                        selfDestruction(h,h.ability.extra.death_message,HEX(h.ability.extra.color))
                        h.ability.extra.selfDestruct = true
                    end
                end
            end
        end
    end
    return res
end


