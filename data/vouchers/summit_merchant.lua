--Summit cards may spawn (spectral rates)
SMODS.Voucher{
    key = "unik_summit_merchant",
	config = { extra = {rate = 2} },
	atlas = "unik_vouchers",
	pos = { x = 0, y = 1 },
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.unik_summit_rate = (G.GAME.unik_summit_rate or 0) + 2
                return true
			end,
		}))
	end,
	unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.unik_summit_rate = math.max(0,G.GAME.unik_summit_rate - 2)
                return true
			end,
		}))
	end,
}