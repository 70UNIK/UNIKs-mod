SMODS.PokerHand { -- Straight Spectrum (Referenced from SixSuits)
  key = 'straight_spectrum',
  visible = false,
  chips = 120,
  mult = 10,
  l_chips = 45,
  l_mult = 4,
  example = {
    { 'C_T',                true},
    { 'D_9',                true },
    { 'H_8',                true },
    { "unik_CROSSES_7", true },
    { "S_6", true },
  },

  evaluate = function(parts)
    if not next(parts.unik_spectrum) or not next(parts._straight) then return {} end
    return { SMODS.merge_lists(parts.unik_spectrum, parts._straight) }
  end,

  modify_display_text = function(self, _cards, scoring_hand)
    local royal = true
    for j = 1, #scoring_hand do
      local rank = not SMODS.has_no_rank(scoring_hand[j]) and SMODS.Ranks[scoring_hand[j].base.value]
      royal = rank and royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
    end

    if royal then
      return self.key .. '_royal'
    end
  end
}