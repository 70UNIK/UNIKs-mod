--effect now is 100% a carbon copy of thd descending,minus the exponential blind size.
SMODS.Scoring_Calculation({
	key = 'unik_plus',
	func = function(self, chips, mult, flames)
		return chips + mult
	end,
	text = '+',
	colour = G.C.UNIK_EYE_SEARING_RED,
})

SMODS.Blind{
    key = 'unik_salmon_steps',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 26},
    boss_colour= HEX("f27c6e"),
    dollars = 8,
    mult = 2,
    unik_exponent = {1,0.7},
    config = {},
    death_message = 'special_lose_salmon_steps',
    set_blind = function(self)
		G.GAME.unik_old_scoring_calculation_key = G.GAME.current_scoring_calculation.key
		SMODS.set_scoring_calculation('unik_plus')
	end,
	disable = function(self)
		SMODS.set_scoring_calculation(G.GAME.unik_old_scoring_calculation_key)
	end,
	defeat = function(self)
		SMODS.set_scoring_calculation(G.GAME.unik_old_scoring_calculation_key)
	end,
}

