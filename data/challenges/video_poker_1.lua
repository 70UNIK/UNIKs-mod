-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_video_poker_1",
	rules = {
		custom = {
			{ id = "unik_all_video_poker" },
            { id = "cry_big_showdown"},
            { id = "unik_purple_scaling"},
		},
		modifiers = {
 
        },
	},
	jokers = {},
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = {

		},
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
            { id = "v_directors_cut" },
			{ id = "v_retcon" },
		},
        banned_other = {
        },
	},

}
