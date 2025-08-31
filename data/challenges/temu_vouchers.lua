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
        { id = "j_unik_coupon_codes", stickers = { "eternal" }, edition = "negative" },
        { id = "j_unik_coupon_codes", stickers = { "eternal" }, edition = "negative" },
        { id = "j_unik_coupon_codes", stickers = { "eternal" }, edition = "negative" },
    },
    consumeables = {
    },
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = {
            { id = 'tag_voucher'},
            { id = 'tag_cry_better_voucher'}
		},
		banned_cards = {
		},
        banned_other = {
        },
	},

}
