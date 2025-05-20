--Every shop reroll in this ante increases blind requirements by 1.5x
--When entering blind, say "AND THERES THE REROLLLLLLL!!!", the obvious reference being that infamous PC company
SMODS.Blind{
    key = 'unik_artisan_builds',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 10},
    boss_colour= HEX("152c54"),
    dollars = 5,
    mult = 2,
	--Only appear if you have at least 5 stone cardsSMODS.has_no_suit(v)
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.unik_killed_by_artisan_builds = true
            G.GAME.unik_original_chips_artisan = G.GAME.blind.chips
            if G.GAME.ante_rerolls and G.GAME.ante_rerolls > 0 then
                for i = 1,G.GAME.ante_rerolls do
                    G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.unik_original_chips_artisan * 0.5)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)

                end
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true
                local text = localize('k_unik_artisan_builds')
                attention_text({
                    scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
            end
            
        end
    end,
    disable = function()
        G.GAME.unik_killed_by_artisan_builds = nil
        G.GAME.blind.chips = G.GAME.unik_original_chips_artisan
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
    end,
    defeat = function()
        G.GAME.unik_killed_by_artisan_builds = nil
        G.GAME.ante_rerolls = 0
    end
}

--hook into reroll
local rerollin = G.FUNCS.reroll_shop
function G.FUNCS:reroll_shop()
    if G.GAME.unik_artisan_reroll_time then
        G.GAME.ante_rerolls = G.GAME.ante_rerolls + 1
        -- print(G.GAME.global_rerolls)
        -- print(G.GAME.ante_rerolls)
        -- print(G.GAME.global_rerolls_pause_val)
    end
    G.GAME.global_rerolls = G.GAME.global_rerolls + 1
    local vars = rerollin(self)
    return vars
end