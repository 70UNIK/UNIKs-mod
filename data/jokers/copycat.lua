--retriggers the joker to the left
SMODS.Joker {
    key = 'unik_copycat',
    atlas = "placeholders",
    rarity = 3,
    pos = {x = 2, y = 0},
	cost = 11,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            local otherone = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and i > 1 then otherone = G.jokers.cards[i-1] end
            end
			if otherone ~= nil and context.other_card == otherone then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
}
