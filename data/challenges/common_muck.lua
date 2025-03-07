SMODS.Challenge{
    key = "unik_common_muck",
	rules = {
		custom = {
			{ id = "unik_common_only" },
		},
		modifiers = {},
	},
    jokers = {
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all jokers except commons (Riif roof is the only uncommon)
        banned_cards = {},
        banned_tags = {
            --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags
            {id = 'tag_cry_gambler'},
            {id = 'tag_cry_empowered'},
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_cry_epic'},
            {id = 'tag_cry_bettertop_up'},
        },
        --The box is banned
        banned_other = {
            {id = 'bl_cry_box', type = 'blind'},
            {id = 'bl_cry_striker', type = 'blind'},
            {id = 'bl_cry_windmill', type = 'blind'},
            {id = 'bl_cry_pin', type = 'blind'},
        },
    },

}