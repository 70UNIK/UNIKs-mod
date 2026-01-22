
    SMODS.PokerHand { -- Spectrum (Referenced from SixSuits)
    key = 'spectrum',
    visible = false,
    chips = 50,
    mult = 6,
    l_chips = 20,
    l_mult = 2,
    example = {
        { 'S_2',                true },
        { 'D_7',                true },
        { 'C_3',                true },
        { "unik_NOUGHTS_A", true },
        { 'H_K',                true },
    },

    evaluate = function(parts)
        --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
        return parts.unik_spectrum
    end
    }
-- else
--     ---Override Bunco's implementation
--     if next(SMODS.find_mod("Bunco")) then
        
--     end
--     --Override paperback's implementation
--     if PB_UTIL and PB_UTIL.config.suits_enabled then
        
--     end
