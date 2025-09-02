SMODS.PokerHandPart { -- Spectrum base (Referenced from SixSuits)
  key = 'spectrum',
  func = function(hand)
    local requiredCards = 5 - UNIK.paved_calc()
    if #hand < requiredCards then return {} end
    local unique_suits = UNIK.get_unique_suits(hand, nil, true)
    return (unique_suits >= requiredCards) and { hand } or {}
  end
}

--Override paperback's implementation of suit count
if PB_UTIL and PB_UTIL.config.suits_enabled then
    function PB_UTIL.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
        -- Set each suit's count to 0
        local suits = {}

        --for all regular and enhancement based suits...
        for k, _ in pairs(SMODS.Suits) do
            suits[k] = 0
        end

        -- First we cover all the non Wild Cards in the hand
        for _, card in ipairs(scoring_hand) do
            if not SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
                suits[suit] = count + 1
                break
                end
            end
            end
        end

        -- Then we cover Wild Cards, filling the missing suits
        for _, card in ipairs(scoring_hand) do
            if SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
                suits[suit] = count + 1
                break
                end
            end
            end
        end

        -- Count the amount of suits that were found
        local num_suits = 0

        for _, v in pairs(suits) do
            if v > 0 then num_suits = num_suits + 1 end
        end

        return num_suits
    end
end

function UNIK.spectrum_played()
  local spectrum_played = false
  if G and G.GAME and G.GAME.hands then
    for k, v in pairs(G.GAME.hands) do
      if string.find(k, "Spectrum", nil, true) then
        if G.GAME.hands[k].played > 0 then
          spectrum_played = true
          break
        end
      end
    end
  end

  return spectrum_played
end

function UNIK.contains_spectrum(hands)
  if PB_UTIL and PB_UTIL.config.suits_enabled then
    return  PB_UTIL.contains_spectrum(hands)
  end
  for k, v in pairs(hands) do
    if (k:find('Spectrum', nil, true) or k:find('spectrum', nil, true) or k:find('unik_spectrum', nil, true)) and #v > 0 then
      return true
    end
  end
end

--stolen from paperback again
function UNIK.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
  -- Set each suit's count to 0
  local suits = {}

  --for all regular and enhancement based suits...
  for k, _ in pairs(SMODS.Suits) do
    suits[k] = 0
  end

  -- First we cover all the non Wild Cards in the hand
  for _, card in ipairs(scoring_hand) do
    if not SMODS.has_any_suit(card) then
      for suit, count in pairs(suits) do
        if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
          suits[suit] = count + 1
          break
        end
      end
    end
  end

  -- Then we cover Wild Cards, filling the missing suits
  for _, card in ipairs(scoring_hand) do
    if SMODS.has_any_suit(card) then
      for suit, count in pairs(suits) do
        if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
          suits[suit] = count + 1
          break
        end
      end
    end
  end

  -- Count the amount of suits that were found
  local num_suits = 0

  for _, v in pairs(suits) do
    if v > 0 then num_suits = num_suits + 1 end
  end
  return num_suits
end