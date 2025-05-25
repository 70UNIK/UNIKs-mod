--spectrals appear 6x times in shop
--No adjustable slider here
SMODS.Voucher{
    key = "unik_spectral_acclimator",
	config = { extra = {rate = 6} },
	atlas = "placeholder_voucher",
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra.rate or self.config.extra.rate) } }
	end,
    requires = { "v_unik_spectral_tycoon" },
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 1) * card.ability.extra.rate
                return true
			end,
		}))
	end,
    pools = { ["Tier3"] = true },
	unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 1) / card.ability.extra.rate
                return true
			end,
		}))
	end,
    in_pool = function(self)
        return G.GAME.used_vouchers.v_unik_spectral_tycoon
    end
}