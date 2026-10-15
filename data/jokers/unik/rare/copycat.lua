--retriggers the joker to the left
SMODS.Joker {
    key = 'unik_copycat',
    atlas = "unik_normal_jokers",
    rarity = 3,
    pos = {x = 10, y = 1},
	cost = 11,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	immutable = true,
	attributes = { 'position','copying','retrigger','joker'},
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
	unlocked = false,
  	discovered = false,
	check_for_unlock = function(self, args)
        if args.type == 'discard_custom' and args.cards then
       		 local eval = evaluate_poker_hand(args.cards)
			if next(eval['Flush Five']) then
				return true
			end
        end
    end,
}
