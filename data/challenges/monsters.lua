--All boss blinds are the decision or Purple Pentagram
--All blinds are boss blinds
SMODS.Challenge{
	key = "unik_monsters",
	rules = {
		custom = {
			{ id = "cry_rush_hour_ii" },
			{ id = "cry_no_tags" },
            { id = "unik_cursed_only"},
		},
		modifiers = {                

    },
	},
	jokers = {
		{ id = "j_ring_master", stickers = { "cry_absolute" }, edition = "negative" },
        { id = "j_ceremonial", stickers = { "perishable" }},
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
		banned_other = {},
	},

}