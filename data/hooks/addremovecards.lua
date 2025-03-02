function CheckSlots(card,slotLimit)
    --Check joker slots for when Joker Card is added, removed
    --if  context.cardarea == G.jokers and not context.blueprint_card and not context.retrigger_joker then
    --print("SlotCount")
    if G.jokers.config.card_limit <= slotLimit then
        selfDestruction(card,"k_unik_happiness3",G.C.BLACK)
        --print("trytodestroy")
        -- This part plays the animation.
            -- G.E_MANAGER:add_event(Event({
            --     func = function()
            --         play_sound('tarot1')
            --         card.T.r = -0.2
            --         card:juice_up(0.3, 0.4)
            --         card.states.drag.is = true
            --         card.children.center.pinch.x = true
            --         -- This part destroys the card.
            --         G.E_MANAGER:add_event(Event({
            --             trigger = 'after',
            --             delay = 0.3,
            --             blockable = false,
            --             func = function()
            --                 G.jokers:remove_card(card)
            --                 card:remove()
            --                 card = nil
            --                 return true;
            --             end
            --         }))
            --         return true
            --     end
            -- }))
            -- return {
            --     message = localize(),
            --     colour = G.C.BLACK,
            -- }
    end
end

function selfDestruction(card,message,color)
    -- This part plays the animation.
    G.E_MANAGER:add_event(Event({
        func = function()
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
            return true
        end
    }))
    return {
        message = localize(message),
        colour = color,
    }
end

local removeHook = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if (self.added_to_deck) then
        --print("Joker deleted")
        --print(self.ability.name)
        --Happiness is mandatory: Joker slot check
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_happiness" then
                --print("checkSlots")
                CheckSlots(v,v.ability.extra.slotLimit)
            --Plant: dynamic face card check
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
    if self == G.jokers then
        --print("Joker added")
        --print(card.ability.name)
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_happiness" then
                --print("checkSlots")
                CheckSlots(v,v.ability.extra.slotLimit)
            end

        end
    end
end