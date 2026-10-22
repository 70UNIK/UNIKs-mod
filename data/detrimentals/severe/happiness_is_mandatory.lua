UNIK.detriment{
    key = "unik_happiness_is_mandatory",
    atlas = "unik_detriments",
	pos = { x = 3, y = 3 },
    severity = 3,
    attributes = { 'detrimental','modify_card','editions','joker_slot','detriment' },
    config = { extra = {min_cards = 4} },
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
        return { 
            vars = { center.ability.extra.min_cards } }
	end,
	blueprint_compat = true,
    immutable = true,
    dongtong_compat = false,
    in_pool = function(self, args)
        return true
    end,
    add_to_deck = function(self, card, from_debuff)
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
	end,
    calculate = function(self, card, context)

		if context.before and context.cardarea == G.unik_detriment_area then
            --print("turn them happy")
            
            
            local positives = {}
            for i,v in pairs(context.scoring_hand) do
                if v.edition and v.edition.unik_positive then
                    table.insert(positives, v)
                end
            end
            --print(facedowns)
            if #positives >= card.ability.extra.min_cards then
                selfDestruction(card,"k_unik_happiness3",G.C.BLACK)

            else
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
                    message = localize("k_unik_happiness2"),
                    colour = G.C.BLACK,
                    
                }
            end
            
        end
    end
}
