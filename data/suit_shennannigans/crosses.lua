SMODS.Suit {
	key = 'Crosses',
	card_key = 'CROSSES',

	lc_atlas = 'unik_suits',
	lc_ui_atlas = 'unik_suits_ui',
	lc_colour = HEX("e8679a"),

	hc_atlas = 'unik_suits_hc',
	hc_ui_atlas = 'unik_suits_ui_hc',
	hc_colour = HEX("ff00ad"),

	pos = { y = 0 },
	ui_pos = { x = 0, y = 0 },

	in_pool = function(self, args)
		if args and args.initial_deck then
			local back = G.GAME.selected_back
			local back_config = back and back.effect.center.has_crosses
			if back_config then return true end
            return false
        end
		if UNIK.suit_in_deck('unik_Crosses') then
			--appears at X0.25 the rate of usual suits
			if pseudorandom(pseudoseed("cross_spawn_rate")) < 0.25 then
				return true
			end
		end
		return false
	end
}

local xmulter = Card.get_chip_x_mult
function Card:get_chip_x_mult(context)
    local ret = xmulter(self,context)

    if self.ability.set == 'Joker' then return 0 end
    if self.base.suit == "unik_Crosses" then
        self.ability.custom_suit_x_mult = 0.2 + (self.base.nominal *0.01)
        ret = SMODS.multiplicative_stacking(ret, self.ability.custom_suit_x_mult)
    end
    
    -- TARGET: get_chip_x_mult
    return ret
end

