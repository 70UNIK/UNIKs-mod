--retriggers the joker to the left
SMODS.Joker {
    key = 'unik_copycat',
    atlas = "unik_rare",
    rarity = 3,
    pos = {x = 0, y = 1},
	cost = 11,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	immutable = true,
	calculate = function(self, card, context)
		if (context.retrigger_joker_check) and context.other_card ~= card then
            local otherone = nil
            if G.jokers.cards[#G.jokers.cards] ~= card then otherone = G.jokers.cards[#G.jokers.cards] end
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
