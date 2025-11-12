--Borg cube: Other steel edition cards give X2 Mult. Uncommon since it always has steel and it's literally an unconditional x2 mult otherwise.
SMODS.Joker {
    key = 'unik_borg_cube',
    atlas = 'unik_uncommon',
	pos = { x = 5, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {xmult = 2} },
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.unik_steel) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_steel
		end
        return { 
            vars = {center.ability.extra.xmult} 
        }
	end,
    pools = {["unik_cube"] = true },
    calculate = function(self, card, context)
        		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.unik_steel == true
			and card ~= context.other_joker
		then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.xmult),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.unik_steel == true then
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.unik_steel == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
                card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return
			else
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				x_mult = lenient_bignum(card.ability.extra.xmult),
				colour = G.C.MULT,
				card = card,
			}
		end
    end,
}