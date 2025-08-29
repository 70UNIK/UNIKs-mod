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
    card_eval_status_text(card, "extra", nil, nil, nil, {
        message = localize(message),
        colour = color,
        card=card,
        delay = 0.5,
    })
end

local removeHook = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if (self.added_to_deck) then
       --print("10")
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
            elseif v.config.center.key =="j_cry_starfruit" or v.config.center.key == "j_mf_lollipop" or v.config.center.key == "j_paperback_nachos" or v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" or v.config.center.key == "j_cry_clicked_cookie" then
                cannibalCards = cannibalCards + 1
            elseif v.ability.name == "j_unik_ghost_trap" and not v.debuff then
                if self.config.center.rarity == "cry_cursed" and self.ability.extra.getting_captured then
                    self.ability.extra.getting_captured = nil
                    SMODS.scale_card(v, {
                        ref_table =v.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_mod",
                        message_key = "a_xmult",
                        message_colour = G.C.MULT,
                    })
                    -- v.ability.extra.x_mult = v.ability.extra.x_mult + v.ability.extra.x_mult_mod
                    -- G.E_MANAGER:add_event(Event({
                    --     trigger = 'after',
                    --     delay = 0.0,
                    --     blockable = false,
                    --     func = function()
                    --         card_eval_status_text(v, "extra", nil, nil, nil, {
                    --             message = localize({
                    --                 type = "variable",
                    --                 key = "a_xmult",
                    --                 vars = {
                    --                     number_format(to_big(v.ability.extra.x_mult)),
                    --                 },
                    --             }),
                    --             colour = G.C.MULT,
                    --             card = v,
                    --             delay = 0.5
                    --         })
                    --         return true;
                    --     end
                    -- }))
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
                    --Lollipop
                    elseif v.config.center.key == "j_mf_lollipop" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.x_mult = 1
                    --Nachos
                    elseif v.config.center.key == "j_paperback_nachos" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.extra.X_chips = 1
                    --starfruit
                    elseif v.config.center.key == "j_cry_starfruit" then
                        v.ability.unik_depleted = true
                        v.ability.eternal = true    
                        v.ability.emult = 1
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

local add_to_deck_hook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    add_to_deck_hook(self,from_debuff)
   --print("1")
    if G.jokers then
        if G.jokers.cards then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "j_unik_ghost_trap" and not v.debuff then
                    GhostTrap1(v)
                end
            end
        end
    end
end

local emplaceHook = CardArea.emplace

function CardArea:emplace(card, location, stay_flipped)

    emplaceHook(self,card, location, stay_flipped)
    --Happiness is mandatory: Joker slot check after the hook
    local cannibalCards = 0
    local autoCannibalExists = false
    if card.ability.set == "unik_lartceps" then
        card.ability.cry_absolute = true
        card.ability.perishable = nil
        card.ability.rental = true
        card.ability.unik_triggering = true
        card.ability.dissolve_immune = true
        card.ability.debuff_immune = true
    end
    --mainline:
    if self and self == G.consumeables and card.config.center.key == "c_cry_pointer" and Card.get_gameset(card) ~= "madness" then
        for i,v in pairs(G.consumeables.cards) do
            if v.config.center.key == "c_cry_pointer" and v ~= card then
                local edition = nil
                if card.edition then
                    edition = card.edition.key 
                end
                card:start_dissolve()
                --fallback to soul.
                 G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_soul', 'sup')
                        n_card.no_omega = true
                        n_card:add_to_deck()
                        if edition then
                            n_card:set_edition(edition, true)
                        end 
                        G.consumeables:emplace(n_card)
                        return true;
                    end
                }))
                break
            end
        end
    end
    if card.ability.unik_triggering then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            blockable = false,
            func = function()
                card.ability.unik_can_autotrigger = true
                return true;
            end
        }))
    end
    if self == G.jokers then
       --print("11")
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
            elseif v.config.center.key == "j_cry_starfruit" or v.config.center.key == "j_mf_lollipop" or v.config.center.key == "j_paperback_nachos" or v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" or v.config.center.key == "j_cry_clicked_cookie" then
                cannibalCards = cannibalCards + 1
            --ghost trap functionality
            elseif v.ability.name == "j_unik_ghost_trap" and not v.debuff then
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
                        if G.GAME.unik_prevent_killing_cursed_jokers and not G.GAME.unik_prevent_killing_cursed_jokers2 then
                            --die
                            selfDestruction(v,"k_extinct_ex",G.C.BLACK)
                            G.GAME.unik_prevent_killing_cursed_jokers2 = true
                            -- G.E_MANAGER:add_event(  -- From buffoonery, supposed to oneshot you
                            -- Event({
                            --     trigger = "after",
                            --     delay = 0.2,
                            --     func = function()

                            --         return true
                            --     end,
                            -- }))
                            local text = localize('k_unik_legendary_pentagram_die')
                            attention_text({
                                scale = 2, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
                            })
                            G.ROOM.jiggle = G.ROOM.jiggle + 5
                            if G.STATE ~= G.STATES.SELECTING_HAND then
                                return false
                            end
                            G.STATE = G.STATES.HAND_PLAYED
                            G.STATE_COMPLETE = true
                            end_round()
                        end
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
                    v.ability.extra.Xmult = 1   
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
                    v.ability.extra.mult = 0
                --Lollipop
                elseif v.config.center.key == "j_mf_lollipop" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.x_mult = 1
                --Nachos
                elseif v.config.center.key == "j_paperback_nachos" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.extra.X_chips = 1
                elseif v.config.center.key == "j_cry_starfruit" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.emult = 1
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
            selfDestruction(w,"k_unik_pentagram_purified",G.C.MULT)
            if G.GAME.unik_prevent_killing_cursed_jokers and not G.GAME.unik_prevent_killing_cursed_jokers2 then
                --die
                selfDestruction(self,"k_extinct_ex",G.C.BLACK)
                G.GAME.unik_prevent_killing_cursed_jokers2 = true
                G.E_MANAGER:add_event(  -- From buffoonery, supposed to oneshot you
                Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        if G.STATE ~= G.STATES.SELECTING_HAND then
                            return false
                        end
                        G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = true
                        end_round()
                        return true
                    end,
                }))
                local text = localize('k_unik_legendary_pentagram_die')
                attention_text({
                    scale = 2, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
                })
                G.ROOM.jiggle = G.ROOM.jiggle + 5
            end
        end
    end
end

