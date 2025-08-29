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
        banned_cards = {
            { id = "p_cry_meme_1", ids = { "p_cry_meme_1", "p_cry_meme_two", "p_cry_meme_three" } },
            { id = "p_unik_cube_1", ids = { "p_unik_cube_1", "p_unik_cube_two", "p_unik_cube_three" } },
        },
        banned_tags = {
            --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags
            {id = 'tag_cry_gambler'},
            {id = 'tag_cry_empowered'},
            {id = 'tag_unik_demon'},
            {id = 'tag_unik_extended_empowered'},
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_cry_epic'},
            {id = 'tag_cry_bettertop_up'},
            {id = 'tag_cry_loss'},
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