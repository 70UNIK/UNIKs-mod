SMODS.PokerHand { -- Spectrum House (Referenced from SixSuits)
  key = 'spectrum_house',
  above_hand = 'Flush House',
  visible = false,
  chips = 150,
  mult = 15,
  l_chips = 40,
  l_mult = 4,
  example = {
    { 'S_A',                true },
    { 'D_A', true },
    { 'C_A',                true },
    { "unik_CROSSES_7", true },
    { 'H_7',                true }
  },

  evaluate = function(parts)
    --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
    if #parts._3 < 1 or #parts._2 < 2 or not next(parts.unik_spectrum) then return {} end
    return { SMODS.merge_lists(parts._all_pairs, parts.unik_spectrum) }
  end
}