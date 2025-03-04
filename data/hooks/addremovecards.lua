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
            elseif v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" then
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
                                card = v
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
            elseif v.ability.name == "Turtle Bean" or v.ability.name == "Ramen" or v.ability.name == "Ice Cream" or v.ability.name == "Popcorn" then
                cannibalCards = cannibalCards + 1
            --ghost trap functionality
            elseif v.ability.name == "j_unik_ghost_trap" then
                GhostTrap1(v)
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