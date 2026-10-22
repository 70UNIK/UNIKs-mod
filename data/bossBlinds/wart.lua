SMODS.Blind{
    key = 'unik_wart',
    boss = {min = 3}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 44},
    boss_colour= HEX("e07850"),
    dollars = 5,
    mult = 2,
    config = {},
    set_blind = function(self, reset, silent)

        if not reset then
            --print("vvvv")

            G.E_MANAGER:add_event(Event({
                delay = 0.5,
                func = function()
                    local card2 = UNIK.create_detriment({severity = 1,seed = "unik_wart" })
                    card2.ability.created_by_wart = true
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    G.ROOM.jiggle = G.ROOM.jiggle + 1
                    return true
                end
            }))
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,
    --If disabled, destroy up to 4 cursed Jokers
    disable = function(self)
        for _, v in pairs(G.unik_detriment_area.cards) do
            if v.ability.created_by_wart then
                selfDestruction(v,"k_unik_pentagram_purified",G.C.MULT)
            end
            
        end
    end,
    defeat = function(self)
        for _, v in pairs(G.unik_detriment_area.cards) do
            if v.ability.created_by_wart then
                v.ability.created_by_wart = nil
            end
            
        end
    end,
}