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
    config = { extra = {min_cards = 4,destroyed = false} },
    pools = {["unik_copyrighted"] = true },
    -- loc_txt = {set = 'Joker', key = 'j_unik_happiness'},
    -- force it to become positive
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
        return { 
            vars = { center.ability.extra.min_cards } }
	end,
    calculate = function(self, card, context)
        if context.on_select_play
        then
            local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            local positives = {}
             for i = 1, #scoring_hand do
                if scoring_hand[i].edition and scoring_hand[i].edition.unik_positive then
                    table.insert(positives, scoring_hand[i])
                end
            end
            --print(facedowns)
            if #positives >= card.ability.extra.min_cards then
                selfDestruction(card,"k_unik_happiness3",G.C.BLACK)

            end
        end
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