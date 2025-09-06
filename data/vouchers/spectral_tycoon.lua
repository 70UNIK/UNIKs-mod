--Spectrals appear 2x times (rate = 4)
SMODS.Voucher{
    key = "unik_spectral_tycoon",
	config = { extra = {rate = 3} },
	atlas = "unik_vouchers",
	pos = { x = 1, y = 0 },
	requires = { "v_unik_spectral_merchant" },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra.rate or self.config.extra.rate) } }
	end,
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 1) * card.ability.extra.rate
                return true
			end,
		}))
	end,
	unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 1) / card.ability.extra.rate
                return true
			end,
		}))
	end,
}