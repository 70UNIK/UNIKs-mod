
SMODS.Blind{
    key = 'unik_bigger_boo',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 4},
    boss_colour= HEX("daeaee"),
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
    get_loc_debuff_text = function(self)
		return "Convert Jokers adjacent to Ghosts into Ghosts"
	end,
    death_message = 'special_lose_unik_bigger_boo',
    --Create an eternal ghost
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            --print("vvvv")
                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_ghost")
                    card2.ability.eternal = true
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
            local text = localize('k_unik_boo_start')
            attention_text({
                scale = 0.8, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
            })
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,

    --less strong than above but worse long term effects
    cry_before_play = function(self)
        local ghostList = {}
        --Get all ghosts 
        for i=1,#G.jokers.cards do
            --print("POSSESS")
             if G.jokers.cards[i].ability.name == "j_cry_ghost" then
                table.insert(ghostList,i)
             end
        end
        -- for each ghost, convert adjacent jokers into ghosts
        for i=1,#ghostList do
            -- convert on left
            if (ghostList[i] > 1) then
                turnJokerIntoGhost(ghostList[i] - 1)
            end
            -- convert on right
            if (ghostList[i] < #G.jokers.cards) then
                turnJokerIntoGhost(ghostList[i] + 1)
            end
        end
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
        killEternalGhosts()
    end,
    defeat = function(self)
        killEternalGhosts()
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}

function killEternalGhosts()
    for _, v in pairs(G.jokers.cards) do
        --print("Joker in set:")
        --print(v.ability.name)
        if (v.ability.name == "j_cry_ghost" and v.ability.eternal) or v.ability.cry_possessed then
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
                                message = localize("k_unik_boo_disabled"),
                                colour = G.C.MULT,
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
function turnJokerIntoGhost(location)
    --avoid cursed jokers and ghosts and absolute jokers
    if (G.jokers.cards[location].config.center.rarity ~= "cry_cursed" and G.jokers.cards[location].ability.name ~= "j_cry_ghost" and not G.jokers.cards[location].ability.cry_absolute) then
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
                { message = localize("k_unik_boo_possessed"), colour = G.C.BLACK }
            )            
        end
        _card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_ghost", "unik_ghost_spreader")
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
    end
end