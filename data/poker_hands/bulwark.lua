SMODS.PokerHand({
	key = "unik_bulwark",
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
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	evaluate = function(parts, hand)
		local stones = {}
		for i, card in ipairs(hand) do
			if
				SMODS.has_no_suit(card.config.center_key) and SMODS.has_no_rank(card.config.center_key)
			then
				stones[#stones + 1] = card
			end
		end
		return #stones >= 5 and { stones } or {}
	end,
})