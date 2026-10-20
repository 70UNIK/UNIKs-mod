SMODS.Blind{
    key = 'unik_purple_pentagram',
    boss = {min = -66, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 0},
    boss_colour= HEX("7b00ff"),
    dollars = 8,
    mult = 2,
    config = {},
        death_message="special_lose_unik_killed_by_pentagram",
    set_blind = function(self, reset, silent)

        if not reset then
            --print("vvvv")

            for i = 1, 4 do
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        local card2 = UNIK.create_detriment({severity = i < 3 and 1 or 2,seed = "unik_pentagram" })
                        card2.ability.created_by_pentagram = true
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
        for _, v in pairs(G.unik_detriment_area.cards) do
            if v.ability.created_by_pentagram then
                selfDestruction(v,"k_unik_pentagram_purified",G.C.MULT)
            end
            
        end
    end,
    defeat = function(self)
        for _, v in pairs(G.unik_detriment_area.cards) do
            if v.ability.created_by_pentagram then
                selfDestruction(v,"k_unik_pentagram_purified",G.C.MULT)
            end
            
        end
    end,
}