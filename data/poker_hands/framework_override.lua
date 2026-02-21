SMODS.PokerHandPart:take_ownership("spectrum_spectrum",{
    func = function(hand)
        --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
    if #hand < 5 then return {} end
        local unique_suits
        if PB_UTIL and PB_UTIL.config.suits_enabled then
            unique_suits = PB_UTIL.get_unique_suits(hand, nil, true)
        else
            unique_suits = UNIK.get_unique_suits(hand, nil, true)
        end
        return (unique_suits >= 5) and { hand } or {}
    end
 })