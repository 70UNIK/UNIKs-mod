SMODS.Blind{
    key = 'unik_purple_pentagram',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 0},
    boss_colour= HEX("7b00ff"),
    dollars = 8,
    mult = 2,
    config = {},
        death_message="special_lose_unik_killed_by_pentagram",
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            --print("vvvv")
            G.GAME.unik_killed_by_pentagram = true
            for i = 1, 4 do
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        local card2 = create_card("Joker", G.jokers, nil, 'unik_detrimental', nil, nil, nil, "unik_pentagram_curse")
                        print(card2.config.center.key)
                        --destroy card2 if its jimbo
                        card2:start_materialize()
                        card2:add_to_deck() --This causes problems. Why?
                        card2.ability.unik_disposable = true
                        G.jokers:emplace(card2)
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        G.ROOM.jiggle = G.ROOM.jiggle + 1
                        return true
                    end
                }))
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
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.config.center.rarity == 'unik_detrimental' and v.ability.unik_disposable then
                selfDestruction(v,"k_unik_pentagram_purified",G.C.MULT)
            end
        end
    end,
    defeat = function(self)
		G.GAME.unik_killed_by_pentagram = nil
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}