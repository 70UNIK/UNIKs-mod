--Spectral Merchant: Spectrals may appear in shop (rate = 2)
SMODS.Voucher{
    key = "unik_spectral_merchant",
	config = { extra = {rate = 2} },
	atlas = "placeholder_voucher",
	pos = { x = 0, y = 0 },
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 0) + 2
                return true
			end,
		}))
	end,
	unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function()
                G.GAME.spectral_rate = math.max(0,G.GAME.spectral_rate - 2)
                return true
			end,
		}))
	end,
    --Dont Spawn if in ghost deck/sleeve
    in_pool = function(self)
        if G.GAME.selected_sleeve == 'sleeve_casl_ghost' or G.GAME.selected_back.name == "Ghost Deck" then
            return false
        end
        return true
    end
}