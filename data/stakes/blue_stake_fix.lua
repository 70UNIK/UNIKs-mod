--Reworked blue stake:
--Must defeat Ante 10 (1 x 1.25) to win.
SMODS.Stake:take_ownership('blue', {
    modifiers = function()
		G.E_MANAGER:add_event(Event({trigger = 'before',func = function() 
			G.GAME.win_ante = G.GAME.win_ante + 2
		return true end })) 
	end,
})