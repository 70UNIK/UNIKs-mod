--Almanac's replacement for Bigger Boo (Ghost is banned)
--Replace Ghosts with The Rot
--Otherwise functions the same
SMODS.Blind{
    key = 'unik_red_rot',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 17},
    boss_colour= HEX("ff0000"), 
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
		return "Convert Jokers adjacent to Rots into The Rot"
	end,
    --Create an eternal ghost
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            --print("vvvv")
            G.GAME.unik_killed_by_rot = true
                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jen_rot")
                    card2.ability.cry_absolute = true
                    --destroy card2 if its jimbo
                    -- if (card2.ability.name ~= "Joker") then
                    card2:start_materialize()
                    card2:add_to_deck() --This causes problems. Why?
                    G.jokers:emplace(card2)
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    delay(0.15)
                    play_sound('jen_gore6')
                    G.ROOM.jiggle = G.ROOM.jiggle + 1
                    -- else
                    --     card2:remove()
                    -- end
            local text = localize('k_unik_rot_start')
            attention_text({
                scale = 0.8, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
            })
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()

            --also immediately kill hunter. Code taken from hunter kill function as its considered "killed by the rot"
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                 if G.jokers.cards[i].ability.name == "j_jen_hunter" then
                    local card = G.jokers.cards[i]
                    card:flip()
                    card:juice_up(2, 0.8)
                    card_status_text(card, 'Dead!', nil, 0.05*card.T.h, G.C.BLACK, 2, 0, 0, nil, 'bm', 'jen_gore6')
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jen_rot', 'hunter_rot_death')
                            card2:add_to_deck()
                            G.jokers:emplace(card2)
                            card:set_eternal(nil)
                            card2:set_eternal(true)
                            play_sound('jen_gore6')
                            G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            return true
                        end
                    }))
                    for i = 1, card.ability.hands_replenished do
                        G.E_MANAGER:add_event(Event({
                            delay='0.1',
                            trigger='after',
                            func = function()
                                local hunter_prizes = { 'c_jen_solace', 'c_jen_sorrow', 'c_jen_singularity', 'c_jen_pandemonium', 'c_jen_spectacle' }
                                local card3 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, pseudorandom_element(hunter_prizes, pseudoseed('hunter_prizecards')), 'hunter_prizecard')
                                card3:add_to_deck()
                                G.consumeables:emplace(card3)
                                return true
                            end
                        }))
                    end
                    G.E_MANAGER:add_event(Event({
                        delay='1',
                        trigger='after',
                        func = function()
                            card:start_dissolve()
                            G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            return true
                        end
                    }))
                 end
            end
            
        end
    end,
    --stolen from Cryptid, similar to vermillion virus, except it detects where each ghost is, check for adjacent non cursed jokers and convert them into MORE ghosts!
    --less strong than above but worse long term effects
    cry_before_play = function(self)
        local ghostList = {}
        --Get all ghosts 
        for i=1,#G.jokers.cards do
            --print("POSSESS")
             if G.jokers.cards[i].ability.name == "j_jen_rot" then
                table.insert(ghostList,i)
             end
        end
        -- for each ghost, convert adjacent jokers into ghosts
        for i=1,#ghostList do
            -- convert on left
            if (ghostList[i] > 1) then
                turnJokerIntoRot(ghostList[i] - 1)
            end
            -- convert on right
            if (ghostList[i] < #G.jokers.cards) then
                turnJokerIntoRot(ghostList[i] + 1)
            end
        end
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
        killEternalRots()
        G.GAME.unik_killed_by_rot = nil
        G.GAME.unik_pentagram_manager_fix = nil
    end,
    defeat = function(self)
        killEternalRots()
		G.GAME.unik_killed_by_rot = nil
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}

function killEternalRots()
    for _, v in pairs(G.jokers.cards) do
        --print("Joker in set:")
        --print(v.ability.name)
        if (v.ability.name == "j_jen_rot" and v.ability.cry_absolute) or v.ability.cry_possessed then
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
                                colour = G.C.MULT,
                            })
                            return true;
                        end
                    }))
                    return true
                end
            }))
        end
    end
end
function turnJokerIntoRot(location)
    --avoid cursed jokers, rot, absolute, permaeternal and dissolve immune and absolute jokers
    if (G.jokers.cards[location].config.center.rarity ~= "cry_cursed" and G.jokers.cards[location].ability.name ~= "j_jen_rot" 
    and not G.jokers.cards[location].ability.cry_absolute
    and not G.jokers.cards[location].ability.jen_permaeternal
    and not G.jokers.cards[location].ability.jen_dissolve_immune
    and not G.jokers.cards[location].config.center.jen_permaeternal
    and not G.jokers.cards[location].config.center.jen_dissolve_immune
    and not G.jokers.cards[location].config.center.immune_to_vermillion
) then
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
                { message = localize("k_unik_headless_rotted"), colour = G.C.BLACK }
            )            
        end
        _card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jen_rot", "unik_ghost_spreader")
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        _card.ability.eternal = true
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
        play_sound('jen_gore6')
    end
end