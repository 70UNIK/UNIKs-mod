--Spectral Merchant: Spectrals may appear in shop (rate = 2)
SMODS.Voucher{
    key = "unik_spectral_merchant",
	config = { extra = {rate = 2} },
	atlas = "unik_vouchers",
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
}
--Ghost Deck: start with spectral merchant
SMODS.Deck:take_ownership("ghost", {
    config = { consumables = {'c_hex'}, vouchers = { "v_unik_spectral_merchant" } },
},true)
--Cardsleeves: modify it to now have spectral merchant/tycoon.
if CardSleeves then
    local ghostSleeve = CardSleeves.Sleeve:get_obj('sleeve_casl_ghost')
    local ghostSleeveRef = ghostSleeve.loc_vars
    ghostSleeve.loc_vars = function(self)
        local key
        local vars = {}
        if self.get_current_deck_key() == "b_ghost" then
            key = self.key .. "_alt"
            self.config = { vouchers = { "v_unik_spectral_merchant" , "v_unik_spectral_tycoon"}, spectral_more_options = 2 }
            vars[#vars+1] = self.config.spectral_more_options
        else
            key = self.key
            self.config = { vouchers = { "v_unik_spectral_merchant" }, consumables = { 'c_hex' } }
            vars[#vars+1] = localize{type = 'name_text', key = self.config.consumables[1], set = 'Tarot'}
        end
        return { key = key, vars = vars }
    end
end