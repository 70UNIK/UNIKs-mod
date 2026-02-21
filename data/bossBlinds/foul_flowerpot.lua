
local function killEternals()
    for _, v in pairs(G.jokers.cards) do
        --print("Joker in set:")
        --print(v.ability.name)
        if (v.config.center.key == "j_flower_pot" and v.ability.unik_flower_pot) then
            selfDestruction(v,"k_unik_plant_no_face",G.C.RED)
            break
        end
    end
end
local function turnJokerintoJoker(location,jack)
    --avoid cursed jokers and ghosts and absolute jokers
    if (G.jokers.cards[location].config.center.key ~= "j_flower_pot" and not G.jokers.cards[location].ability.cry_absolute and not G.jokers.cards[location].ability.unik_taw and not G.jokers.cards[location].config.center.immune_to_vermillion) then
        --It will even destroy eternals!
        if G.jokers.cards[location].ability.eternal then
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_boo_eternal_bypass"), colour = G.C.RED }
            )
        else
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_flower_potted"), colour = G.C.RED }
            )            
        end
        local _card = copy_card(G.jokers.cards[jack], nil, nil, nil, nil)
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        _card.ability.eternal = nil
        _card.ability.unik_flower_pot = nil
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
    end
end

SMODS.Blind{
    key = 'unik_foul_flowerpot',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 37},
    boss_colour= HEX("90ced1"),
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
    death_card = {
        card = 'j_flower_pot', 
        mod_card = function(self, card) --used to apply editions and/or stickers
        end,
        quotes = {'special_lose_flowerpot'},
        say_times = 5,
    },
    --Create an eternal ghost
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_flower_pot")
            card2.ability.eternal = true
            card2.ability.unik_flower_pot = true
            card2:start_materialize()
            card2:add_to_deck() 
            G.jokers:emplace(card2)
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
            delay(0.15)
            G.ROOM.jiggle = G.ROOM.jiggle + 1
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,
    unik_before_play = function(self)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        local suiters = {'Spades','Diamonds','Hearts','Clubs'}
        local existingSuits = {}
             for i,v in pairs(scoring_hand) do
                if not SMODS.has_any_suit(v) then
                    for j=1,#suiters do
                        if v:is_suit(suiters[j]) and not existingSuits[suiters[j]] then
                            existingSuits[suiters[j]] = true;
                            break
                        end
                    end
                end
                
            end
            for i,v in pairs(scoring_hand) do
                if SMODS.has_any_suit(v) then
                    for j=1,#suiters do
                        if v:is_suit(suiters[j]) and not existingSuits[suiters[j]] then
                            existingSuits[suiters[j]] = true;
                            break
                        end
                    end
                end
                
            end
        if not existingSuits['Spades'] or not existingSuits['Clubs'] or not existingSuits['Hearts'] or not existingSuits['Diamonds'] then
            local ghostList = {}
            --Get all ghosts 
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                if G.jokers.cards[i].config.center.key == "j_flower_pot" then
                    table.insert(ghostList,i)
                end
            end
            -- for each ghost, convert adjacent jokers into ghosts
            for i=1,#ghostList do
                -- convert on left
                if (ghostList[i] > 1) then
                    turnJokerintoJoker(ghostList[i] - 1,ghostList[i])
                end
                -- convert on right
                if (ghostList[i] < #G.jokers.cards) then
                    turnJokerintoJoker(ghostList[i] + 1,ghostList[i])
                end
            end
        end
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
       killEternals()
        G.GAME.unik_pentagram_manager_fix = nil
    end,
    defeat = function(self)
        killEternals()
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}
