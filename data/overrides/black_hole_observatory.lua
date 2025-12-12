--malicious face can add black holes
--they are considered X1.5 mult unconditionally for observatory

SMODS.Consumable:take_ownership("c_black_hole",{
    calculate = function(self, card, context)
		if
			G.GAME.used_vouchers.v_observatory
			and context.joker_main
		then
			local value = G.P_CENTERS.v_observatory.config.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { x_mult = value }
		end
	end,
}, true)