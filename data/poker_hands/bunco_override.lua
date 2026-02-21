--Override of bunco's spectrum functionality cause
SMODS.PokerHand:take_ownership("bunc_Spectrum",{
    evaluate = function(parts)
        --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
        return parts.unik_spectrum
    end
 })

 SMODS.PokerHand:take_ownership("bunc_Spectrum House",{
    evaluate = function(parts)
        --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
        if #parts._3 < 1 or #parts._2 < 2 or not next(parts.unik_spectrum) then return {} end
        return { SMODS.merge_lists(parts._all_pairs, parts.unik_spectrum) }
    end
 })

  SMODS.PokerHand:take_ownership("bunc_Straight Spectrum",{
    evaluate = function(parts)
        --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
        if not next(parts.unik_spectrum) or not next(parts._straight) then return {} end
        return { SMODS.merge_lists(parts.unik_spectrum, parts._straight) }
    end,
 })

SMODS.PokerHand:take_ownership("bunc_Spectrum Five",{
   evaluate = function(parts)
    --DO NOT EVALUATE WITH BLINDSIDE ACTIVE!!!!!
		if UNIK.hasBlindside() then
			return false
		end
    if not next(parts._5) or not next(parts.unik_spectrum) then return {} end
    return { SMODS.merge_lists(parts._5, parts.unik_spectrum) }
  end
 })

