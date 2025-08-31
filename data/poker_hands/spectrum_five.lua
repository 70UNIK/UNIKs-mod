SMODS.PokerHand { -- Spectrum Five (Referenced from SixSuits)
  key = 'spectrum_five',
  above_hand = 'Flush Five',
  visible = false,
  chips = 180,
  mult = 18,
  l_chips = 55,
  l_mult = 3,
  example = {
    { 'S_7',                true },
    { 'D_7',                true },
    { "S_A", true, enhancement = "m_unik_pink" },
    { 'H_7',                true },
    { 'C_7',                true }
  },

  evaluate = function(parts)
    if not next(parts._5) or not next(parts.unik_spectrum) then return {} end
    return { SMODS.merge_lists(parts._5, parts.unik_spectrum) }
  end
}
