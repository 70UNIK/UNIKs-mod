--Rush hour but instead of hit the road, you have No standing Zone instead
SMODS.Challenge{
	key = "unik_rush_hour_4",
	order = 8,
	rules = {
		custom = {
			{ id = "cry_rush_hour" },
			{ id = "cry_rush_hour_ii" },
			{ id = "cry_rush_hour_iii" },
			{ id = "cry_no_tags" },
		},
		modifiers = {},
	},
	jokers = {
		{ id = "j_unik_no_standing_zone", stickers = { "cry_absolute" }, edition = "cry_oversat" },
	},
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
			{ id = "j_throwback" },
			{ id = "j_diet_cola" },
			{ id = "v_directors_cut" },
			{ id = "v_retcon" },
			{ id = "j_cry_pickle" },
			{ id = "v_cry_copies" },
			{ id = "v_cry_tag_printer" },
			{ id = "v_cry_clone_machine" },
		},
        banned_other = {

        },
	},

}