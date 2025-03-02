SMODS.Blind{
    --Hahahahahah no jolly for you
    key = 'unik_the_poppy',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 6},
    boss_colour= HEX("ff4a64"),
    dollars = 5 ,
    mult = 2,
	set_blind = function(self)
		G.GAME.unik_killed_by_poppy = true
	end,
	disable = function(self)
		G.GAME.unik_killed_by_poppy = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_poppy = nil
	end,
}