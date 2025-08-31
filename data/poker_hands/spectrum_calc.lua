SMODS.PokerHandPart { -- Spectrum base (Referenced from SixSuits)
  key = 'spectrum',
  func = function(hand)
    if #hand < 5 then return {} end
    local unique_suits = UNIK.get_unique_suits(hand, nil, true)
    return (unique_suits >= 5) and { hand } or {}
  end
}
--Override paperback's implementation of suit count
if PB_UTIL and PB_UTIL.config.suits_enabled then
    function UNIK.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
        -- Set each suit's count to 0
        local suits = {}

        --for all regular and enhancement based suits...
        for k, _ in pairs(unik_get_all_suits2()) do
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

--stolen from paperback again
function UNIK.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
  -- Set each suit's count to 0
  local suits = {}

  --for all regular and enhancement based suits...
  for k, _ in pairs(unik_get_all_suits2()) do
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