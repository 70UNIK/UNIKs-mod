SMODS.PokerHandPart:take_ownership("six_spectrum",{
    func = function(hand)
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