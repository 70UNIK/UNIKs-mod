SMODS.Suit {
	key = 'Noughts',
	card_key = 'NOUGHTS',

	lc_atlas = 'unik_suits',
	lc_ui_atlas = 'unik_suits_ui',
	lc_colour = HEX("37e1c1"),

	hc_atlas = 'unik_suits_hc',
	hc_ui_atlas = 'unik_suits_ui_hc',
	hc_colour = HEX("00e17d"),

	pos = { y = 1 },
	ui_pos = { x = 1, y = 0 },

	in_pool = function(self, args)
		if args and args.initial_deck then
			local back = G.GAME.selected_back
			local back_config = back and back.effect.center.has_noughts
			if back_config then return true end
            return false
        end
		--if you have a base rank nought, have it appear only 1 in 3 at a time.
		if UNIK.suit_in_deck('unik_Noughts') then
			--appears at X0.25 the rate of usual suits
			if pseudorandom(pseudoseed("nought_spawn_rate")) < 0.33 then
				return true
			end
		end
		return false
	end
}

local bonuser = Card.get_chip_x_bonus
function Card:get_chip_x_bonus()
    local ret = bonuser(self)
    if self.base.suit == "unik_Noughts" and not SMODS.has_no_suit(self) and (not self.config.center.replace_base_card) then
        self.ability.custom_suit_x_chips = 0.2 + (self.base.nominal *0.01)
        ret = SMODS.multiplicative_stacking(ret,self.ability.custom_suit_x_chips)
    end
    
    -- TARGET: get_chip_x_bonus
    return ret
end
