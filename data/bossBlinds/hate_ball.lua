SMODS.Blind{
    key = 'unik_hate_ball',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 31},
    boss_colour= HEX("58696d"),
    dollars = 8,
    mult = 2,
    config = {},
       --Disable if doing Jokerless:
    in_pool = function()
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
        return true
	end,
    pronouns = "he_him",
    death_message = "special_lose_hate_ball",
    get_loc_debuff_text = function(self)
		return localize("k_unik_hate_ball")
	end,
    unik_before_play = function(self)
        local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        local has8 = false
        for i,v in pairs(G.hand.highlighted) do
            if v:get_id() == 8 then
                has8 = true
            end
        end
        if not has8 then
            local validCards = {}
            --Get all ghosts 
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                if G.jokers.cards[i].config.center.key ~= "j_8_ball" and not G.jokers.cards[i].ability.unik_taw and not G.jokers.cards[i].ability.cry_absolute and not G.jokers.cards[i].config.center.immune_to_vermillion then
                    validCards[#validCards+1] = G.jokers.cards[i]
                end
            end
            if #G.jokers.cards > 0 then
                local jackshit = pseudorandom_element(validCards, pseudoseed("unik_hateball_select"))
                local index = -1
                for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i] == jackshit then
                        turnJokerIntoEight(i)
                        break
                    end
                end
                
            end
        end
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
        G.GAME.unik_pentagram_manager_fix = nil
    end,
    defeat = function(self)
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}
function turnJokerIntoEight(location,jack)
    --avoid cursed jokers and ghosts and absolute jokers
    if (G.jokers.cards[location].config.center.key ~= "j_8_ball" and not G.jokers.cards[location].ability.unik_taw and not G.jokers.cards[location].ability.cry_absolute and not G.jokers.cards[location].config.center.immune_to_vermillion) then
        --It will even destroy eternals!
        if G.jokers.cards[location].ability.eternal then
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_boo_eternal_bypass"), colour = G.C.BLACK }
            )
        else
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_hate_8"), colour = G.C.BLACK }
            )            
        end
        local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_8_ball")
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        _card.ability.eternal = nil
        _card.ability.unik_jackshit = nil
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
    end
end