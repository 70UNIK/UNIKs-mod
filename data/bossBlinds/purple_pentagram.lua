SMODS.Blind{
    key = 'unik_purple_pentagram',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 0},
    boss_colour= HEX("7b00ff"),
    dollars = 8,
    mult = 2,
    config = {},
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            --print("vvvv")
            G.GAME.unik_killed_by_pentagram = true
            for i = 1, 4 do
                    local card2 = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "unik_pentagram_curse")
                    --destroy card2 if its jimbo
                    if (card2.ability.name ~= "Joker") then
                        card2:start_materialize()
                        card2:add_to_deck() --This causes problems. Why?
                        G.jokers:emplace(card2)
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        G.ROOM.jiggle = G.ROOM.jiggle + 1
                        delay(0.15)
                        
                    else
                        card2:remove()
                    end

            end
            local text = localize('k_unik_pentagram_start')
            attention_text({
                scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
            })
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,
    --If disabled, destroy up to 4 cursed Jokers
    disable = function(self)
        G.GAME.unik_killed_by_pentagram = nil
        local cursedDestroyed = 0
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.config.center.rarity == "cry_cursed" and cursedDestroyed < 4 then
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
                            delay = 0.0,
                            blockable = false,
                            func = function()
                                v:start_dissolve()
                                card_eval_status_text(v, "extra", nil, nil, nil, {
                                    message = localize("k_unik_pentagram_purified"),
                                    colour = G.C.MULT,
                                })
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                cursedDestroyed = cursedDestroyed + 1
            end
        end
    end,
    defeat = function(self)
		G.GAME.unik_killed_by_pentagram = nil
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}