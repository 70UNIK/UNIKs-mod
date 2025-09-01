-- cannot get vouchers from the shop (Trade is banned), instead you can only get vouchers from 4 Coupon Codes (and a negative KEYGEN)
SMODS.Challenge{
    key = "unik_coupon_codes_only",
	rules = {
		custom = {
			{ id = "cry_no_vouchers" },
		},
		modifiers = {
 
        },
	},
	jokers = {
        { id = "j_unik_coupon_codes", eternal = true, edition = "negative" },
        { id = "j_unik_coupon_codes", eternal = true, edition = "negative" },
        { id = "j_unik_coupon_codes", eternal = true, edition = "negative" },
    },
    consumeables = {
    },
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = function(self)
			local banlist = {}
            banlist[#banlist + 1] = { id = 'tag_voucher'}
			if Cryptid then
				banlist[#banlist + 1] = { id = 'tag_cry_better_voucher'}
			end
             return banlist
		end,
		banned_cards = {
		},
        banned_other = {
        },
	},

}
