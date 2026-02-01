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

function selfDestruction_noMessage(card,dissolve)
    -- This part plays the animation.
    G.E_MANAGER:add_event(Event({
        func = function()
            --Dissolving
            if (dissolve) then
                if SMODS.shatters(card) then
                    card:shatter()
                else
                    card:start_dissolve()
                end
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
        SMODS.calculate_context({ unik_remove_from_deck = true, removed = self, from_debuff = from_debuff})
        for _, v in pairs(G.jokers.cards) do
            if v.ability.name == "j_unik_happiness" then
                CheckSlots(v,v.ability.extra.slotLimit)
            end
        end
    end
    local ret = removeHook(self,from_debuff)
    return ret
end

local add_to_deck_hook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    add_to_deck_hook(self,from_debuff)
    SMODS.calculate_context({ unik_add_to_deck = true, added = self, from_debuff = from_debuff})
end

local emplaceHook = CardArea.emplace

function CardArea:emplace(card, location, stay_flipped)
    emplaceHook(self,card, location, stay_flipped)
    if  G.consumeables and G.jokers then
        SMODS.calculate_context({ unik_emplace = true, added = card, cardarea = self,location = location, isFlipped = stay_flipped})
    end
    --Happiness is mandatory: Joker slot check after the hook
    if card.ability.set == "unik_lartceps" then
        card.ability.eternal = true
        card.ability.perishable = nil
        card.ability.rental = true
        card.ability.unik_triggering = true
        card.ability.dissolve_immune = true
        card.ability.debuff_immune = true
        unik_set_sell_cost(card,-666)
    end
    if card.ability.unik_disposable or card.ability.unik_niko or card.ability.unik_depleted then
        unik_set_sell_cost(card,0)
    end
    if card.config.center.key == 'j_unik_eternal_egg' and (self == G.shop_jokers or self == G.shop_booster) then
        card.ability.eternal = true
    end
    --mainline:
    if self and self == G.consumeables and card.config.center.key == "c_unik_celeste" then
        card.ability.unik_decaying = true
        for i,v in pairs(G.consumeables.cards) do
            if v.config.center.key == "c_unik_celeste" and v ~= card then
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
                        n_card.ability.unik_decaying = true
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
        if self and self == G.consumeables and card.config.center.key == "c_unik_ebott" then
            card.ability.unik_decaying = true
        for i,v in pairs(G.consumeables.cards) do
            if v.config.center.key == "c_unik_ebott" and v ~= card then
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
                        n_card.ability.unik_decaying = true
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
            --Formidicus fix, now constantly destroys cursed jokers
            elseif v.config.center.key == "j_cry_formidiulosus" then
                for x, w in pairs(G.jokers.cards) do
                    if (w.config.center.rarity == 'unik_detrimental' or w.config.center.rarity == 'cry_cursed') and not w.ability.extra.getting_captured then
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
end

