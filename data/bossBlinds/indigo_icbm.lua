SMODS.Blind{
    key = 'unik_indigo_icbm',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 1},
    boss_colour= HEX("250088"),
    dollars = 8,
    mult = 0.5,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
        G.GAME.unik_nuke_activate = true
	end,
    disable = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
	defeat = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
}