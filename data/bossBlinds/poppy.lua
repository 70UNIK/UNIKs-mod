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
	loc_vars = function(self, info_queue, card)
		return { vars = { 2.5 * get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_poppy_placeholder") } }
	end,
	set_blind = function(self)
		G.GAME.unik_killed_by_poppy = true
		--To make it work with obsidian orb, it uses flag
		G.GAME.unik_poppy_ceil = true
	end,
	disable = function(self)
		G.GAME.unik_killed_by_poppy = nil
		G.GAME.unik_poppy_ceil = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_poppy = nil
		G.GAME.unik_poppy_ceil = nil
	end,
}