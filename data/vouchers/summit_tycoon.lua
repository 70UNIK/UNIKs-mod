--Summit cards spawn at 2X rate.
SMODS.Voucher{
    key = "unik_summit_tycoon",
	config = { extra = {rate = 2} },
	atlas = "unik_vouchers",
	pos = { x = 1, y = 1 },
	requires = { "v_unik_summit_merchant" },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra.rate or self.config.extra.rate) } }
	end,
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.unik_summit_rate = (G.GAME.unik_summit_rate or 1) * card.ability.extra.rate
                return true
			end,
		}))
	end,
	unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.unik_summit_rate = (G.GAME.unik_summit_rate or 1) / card.ability.extra.rate
                return true
			end,
		}))
	end,
}