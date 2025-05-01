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
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_happiness',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
	pos = { x = 0, y = 0 },
    cost = 0,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
    immutable = true,
    no_dbl = true,
    config = { extra = {slotLimit = -4} },
    pools = {["unik_copyrighted"] = true },
    -- loc_txt = {set = 'Joker', key = 'j_unik_happiness'},
    -- force it to become positive
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
        info_queue[#info_queue + 1] = G.P_CENTERS.j_smiley
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}),
            vars = { center.ability.extra.slotLimit } }
	end,
    --Check every time if a joker is added or removed from deck
    add_to_deck = function(self, card, context)
        CheckSlots(card,card.ability.extra.slotLimit)
        if #G.jokers.cards > 0 then
            G.jokers.cards[1]:set_edition({ unik_positive = true }, true,nil, true)
        end
        for i = 1, #G.consumeables.cards do
            G.consumeables.cards[i]:set_edition({ unik_positive = true }, true,nil, true)
        end
        --self:set_edition({ unik_positive = true }, true, nil, true)
    end,
    -- on self destruction, if no happiness instances exist (or at least 1), then remove eternal from all smiley faces.
    remove_from_deck = function(self,from_debuff)
        local happyCount = 0
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_happiness" then
                --print("checkSlots")
                --print("happyFound")
                happyCount = happyCount + 1
                --CheckSlots(v,v.ability.extra.slotLimit)
            end
        end
        if happyCount < 1 then
            for _, v in pairs(G.jokers.cards) do
                --print("Joker in set:")
                --print(v.ability.name)
                if v.ability.name == "Smiley Face" then
                    v.ability.eternal = false
                end
            end
        end
    end,
    --TODO: Make an actual shader for the "Positive" effect. It should be similar to negative, but without color inversion and instead should be a 180 hue shift.
    calculate = function(self, card, context)
        -- --If it
        -- if context.playing_card_added and context.cardarea == G.jokers then
        --     CheckSlots(card,card.ability.extra.slotLimit)
        -- end
        --Per hand, turn 2 leftmost played cards positive and create a tainted smiley face. Need to fix 
		if context.before and context.cardarea == G.jokers and Card.get_gameset(card) ~= "modest" then
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


                    return true
                end
            }))

            return{
                message = localize("k_unik_happiness1"),
                colour = G.C.BLACK,
                
            }
        end
        --works
        if context.after and context.cardarea == G.jokers then
            --print("create a smiley")
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.8, 0.8)
                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_smiley")
                    --force the edition over another
                    card2:set_edition({ unik_positive = true }, true, nil, true)
                    card2.ability.eternal = true
                    card2.ability.banana = true
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:start_materialize()
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
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_happiness"] = {
		text = {
			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
		},
        calc_function = function(card)
            local text = ""
            text = G.jokers and G.jokers.config and "(" .. card.ability.extra.slotLimit .. "/" .. G.jokers.config.card_limit .. ")" or "YOU SHOULDNT SEE THIS"
			card.joker_display_values.localized_text = text
        end
	}
end
