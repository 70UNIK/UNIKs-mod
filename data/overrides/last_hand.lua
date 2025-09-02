--Panopticon and --The World: LAst hand fix
SMODS.Joker:take_ownership("j_panopticon", {
    calculate = function(self, card, context)
		if context.on_select_play and not context.blueprint and not context.retrigger_joker then
			if not G.GAME.cry_panop_juggle then
				G.GAME.cry_panop_juggle = G.GAME.current_round.hands_left
			end
			G.GAME.current_round.hands_left = 0
		end
		if context.after and not context.blueprint and not context.retrigger_joker then
			if G.GAME.cry_panop_juggle then
				G.GAME.current_round.hands_left = G.GAME.cry_panop_juggle
				G.GAME.cry_panop_juggle = nil
			end
		end
	end,
},true)