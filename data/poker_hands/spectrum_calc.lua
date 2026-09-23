--spectrumAPI takes precidence
if SpectrumAPI then
  SpectrumAPI.configuration.misc.spectrum_example_suit = "unik_CROSSES"
	local calc = SpectrumAPI.get_suit
  
	function SpectrumAPI.get_suit(card)
		if card.config.center.unik_specific_suit then
			return card.config.center.unik_specific_suit
		end
		if SMODS.has_any_suit(card) then
			return math.random(1, 1000000)
		end
		return calc(card)
		
	end
else
	SMODS.PokerHandPart { -- Spectrum base (Referenced from SixSuits)
	key = 'spectrum',
	func = function(hand)
    --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
		local requiredCards = math.max(0,SMODS.four_fingers() - UNIK.paved_calc())
		if #hand < requiredCards then return {} end
		local unique_suits = UNIK.get_unique_suits(hand, nil, true)
		--print(unique_suits .. " " .. requiredCards)
		return (unique_suits >= requiredCards) and { hand } or {}
	end
	}
end
--Override paperback's implementation of suit count
if PB_UTIL and PB_UTIL.config.suits_enabled then
    function PB_UTIL.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
        local suit_count = 0
		for _ in pairs(unik_get_all_suits2()) do
			suit_count = suit_count + 1
		end
		-- Initilize a bipartite matching algorithm because math is tight
		local b = BipGraph(#scoring_hand, suit_count)

		for card_index, card in ipairs(scoring_hand) do
			local suit_index = 0
			for suit, _ in pairs(unik_get_all_suits2()) do
			suit_index = suit_index + 1
			if card:is_suit(suit, bypass_debuff, flush_calc) then
				-- Add edges for each card based on suits
				b:addEdge(card_index, suit_index)
			end
			end
		end

		-- Gets maximum number of matches.
		return b:hopcroftKarp()
    end
end

function UNIK.spectrum_played()
  local spectrum_played = false
  if G and G.GAME and G.GAME.hands then
    for k, v in pairs(G.GAME.hands) do
      if string.find(k, "Spectrum", nil, true) or string.find(string.lower(k), "spectrum", nil, true) then
        if G.GAME.hands[k].played > 0 then
          spectrum_played = true
          break
        end
      end
    end
  end
  --print(spectrum_played)
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

--extremely experimental function that is designed to work with patches from all in jest. Still has problems.
function UNIK.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
	local suit_count = 0
	for _ in pairs(unik_get_all_suits2()) do
		suit_count = suit_count + 1
	end
	-- Initilize a bipartite matching algorithm because math is tight
	local b = BipGraph(#scoring_hand, suit_count)

	for card_index, card in ipairs(scoring_hand) do
		local suit_index = 0
		for suit, _ in pairs(unik_get_all_suits2()) do
		suit_index = suit_index + 1
		if card:is_suit(suit, bypass_debuff, flush_calc) then
			-- Add edges for each card based on suits
			b:addEdge(card_index, suit_index)
		end
		end
	end

	-- Gets maximum number of matches.
	return b:hopcroftKarp()
end