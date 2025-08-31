SMODS.PokerHand({
	key = "bulwark",
	visible = false,
	chips = 70,
	mult = 7,
	l_chips = 25,
	l_mult = 1,
	example = {
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
	},
	evaluate = function(parts, hand)
		local stones = {}
		for i, card in ipairs(hand) do
			if
				card.config.center_key == "m_stone"
				or (card.config.center.no_rank and card.config.center.no_suit and not card.config.center.not_stoned)
			then
				stones[#stones + 1] = card
			end
		end
		return #stones >= 5 and { stones } or {}
	end,
})