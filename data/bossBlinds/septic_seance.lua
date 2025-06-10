SMODS.Blind{
    key = 'unik_septic_seance',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 25},
    boss_colour= HEX("5e7297"),
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
    death_message = "special_lose_unik_seance",
    get_loc_debuff_text = function(self)
		return localize("k_unik_septic_seance")
	end,
    --Create an eternal ghost
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            --print("vvvv")
                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_seance")
                    card2.ability.eternal = true
                    card2.ability.unik_septic_seance = true
                    --destroy card2 if its jimbo
                    -- if (card2.ability.name ~= "Joker") then
                    card2:start_materialize()
                    card2:add_to_deck() --This causes problems. Why?
                    G.jokers:emplace(card2)
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    delay(0.15)
                    G.ROOM.jiggle = G.ROOM.jiggle + 1
                    -- else
                    --     card2:remove()
                    -- end
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,
    calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled then
			--visual cue to wiggle all jokers
			if context.other_card:get_id() == 11 then
                G.GAME.unik_jack_discarded = true
            end
		end
	end,
    --stolen from Cryptid, similar to vermillion virus, except it detects where each ghost is, check for adjacent non cursed jokers and convert them into MORE ghosts!
    --less strong than above but worse long term effects
    cry_before_play = function(self)
        local hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        if hand ~= localize("Royal Flush", "poker_hands") and hand ~= localize("Straight Flush", "poker_hands") then
            local ghostList = {}
            --Get all ghosts 
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                if G.jokers.cards[i].config.center.key == "j_seance" then
                    table.insert(ghostList,i)
                end
            end
            -- for each ghost, convert adjacent jokers into ghosts
            for i=1,#ghostList do
                -- convert on left
                if (ghostList[i] > 1) then
                    turnJokerIntoSeance(ghostList[i] - 1,ghostList[i])
                end
                -- convert on right
                if (ghostList[i] < #G.jokers.cards) then
                    turnJokerIntoSeance(ghostList[i] + 1,ghostList[i])
                end
            end
        end
        
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
       killEternalSeances()
        G.GAME.unik_pentagram_manager_fix = nil
        G.GAME.unik_jack_discarded = nil
    end,
    defeat = function(self)
        killEternalSeances()
        G.GAME.unik_pentagram_manager_fix = nil
        G.GAME.unik_jack_discarded = nil
	end,
}

function killEternalSeances()
    for _, v in pairs(G.jokers.cards) do
        --print("Joker in set:")
        --print(v.ability.name)
        if (v.config.center.key == "j_seance" and v.ability.unik_septic_seance) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    v.T.r = -0.2
                    v:juice_up(0.3, 0.4)
                    v.states.drag.is = true
                    v.children.center.pinch.x = true
                    -- This part destroys the card.
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            v:start_dissolve()
                            card_eval_status_text(v, "extra", nil, nil, nil, {
                                message = localize("k_extinct_ex"),
                                colour = HEX('424e54'),
                            })
                            return true;
                        end
                    }))
                    return true
                end
            }))
            break
        end
    end
end
function turnJokerIntoSeance(location,jack)
    --avoid cursed jokers and ghosts and absolute jokers
    if (G.jokers.cards[location].config.center.key ~= "j_seance" and not G.jokers.cards[location].ability.cry_absolute and not G.jokers.cards[location].config.center.immune_to_vermillion) then
        --It will even destroy eternals!
        if G.jokers.cards[location].ability.eternal then
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_boo_eternal_bypass"), colour = HEX('424e54') }
            )
        else
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_seance_or_else"), colour = HEX('424e54') }
            )            
        end
        _card = copy_card(G.jokers.cards[jack], nil, nil, nil, nil)
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        _card.ability.eternal = nil
        _card.ability.unik_septic_seance = nil
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
    end
end