SMODS.Blind{
    --Hahahahahah no jolly for you
    key = 'unik_lily_sprunki_blind',
    config = {},
	boss = {
		min = 1,
		max = 10,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 7},
    boss_colour= HEX("d277db"),
    dollars = 5 ,
    mult = 2,
	set_blind = function(self)
		G.GAME.unik_eaten_by_lily = true
	end,
	disable = function(self)
		G.GAME.unik_eaten_by_lily = nil
	end,
	defeat = function(self)
		G.GAME.unik_eaten_by_lily = nil
	end,
}