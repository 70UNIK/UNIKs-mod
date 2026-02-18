
--rework:
--add positive and limited edition to a random joker on play and positive to a random played card, self destructs after reaching -4 joker slots

function CheckSlots(card,slotLimit)
    --Check joker slots for when Joker Card is added, removed
    --if  context.cardarea == G.jokers and not context.blueprint_card and not context.retrigger_joker then
    if G.jokers.config.card_limit <= slotLimit then
        --print("trytodestroy")
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
                message = localize("k_unik_happiness3"),
                colour = G.C.BLACK,
                card=card,
            }
    end
end


SMODS.Joker {
	key = 'unik_happiness',
    atlas = 'unik_cursed',
    rarity = 'unik_detrimental',
	pos = { x = 0, y = 0 },
    cost = 0,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
    immutable = true,
    no_dbl = true,
    config = { extra = {slotLimit = 0,destroyed = false} },
    pools = {["unik_copyrighted"] = true },
    -- loc_txt = {set = 'Joker', key = 'j_unik_happiness'},
    -- force it to become positive
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
        return { 
            vars = { center.ability.extra.slotLimit } }
	end,
    --TODO: Make an actual shader for the "Positive" effect. It should be similar to negative, but without color inversion and instead should be a 180 hue shift.
    update = function(self,card,dt)
        if G.jokers.config.card_limit <= card.ability.extra.slotLimit and not card.ability.extra.destroyed then
            card.ability.extra.destroyed = true
            selfDestruction(card,'k_unik_happiness3',G.C.BLACK)
        end
    end,
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
            --print("turn them happy")
            
            G.E_MANAGER:add_event(Event({

                func = function()
                    
                    local validCards = {}
                    for i,v in pairs(G.play.cards) do
                        if not v.edition then
                            validCards[#validCards + 1] = v
                        elseif v.edition and not v.edition.unik_positive then
                            validCards[#validCards + 1] = v
                        end
                    end
                    if #validCards > 0 then
                        card:juice_up(0.8, 0.8)
                        local select = pseudorandom_element(validCards, pseudoseed("unik_positive_card_select"))
                        select:set_edition({ unik_positive = true }, true,nil, true)
                    end

                    local validJokers = {}
                    for i,v in pairs(G.jokers.cards) do
                        if not v.edition then
                            validJokers[#validJokers + 1] = v
                        elseif v.edition and not v.edition.unik_positive then
                            validJokers[#validJokers + 1] = v
                        end
                    end
                    if #validJokers > 0 then
                        card:juice_up(0.8, 0.8)
                        local select = pseudorandom_element(validJokers, pseudoseed("unik_positive_joker_select"))
                        select:set_edition({ unik_positive = true }, true,nil, true)
                    end
                    return true
                end
            }))

            return{
                message = localize("k_unik_happiness2"),
                colour = G.C.BLACK,
                
            }
        end
    end
}