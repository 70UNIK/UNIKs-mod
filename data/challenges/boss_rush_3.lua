--Absolute AP joker
--Absolute border wall
--Absolute flesh pampticon
--banana rigged cavendish x5
--banana rigged gros michael
--Same rules as Boss Rush 2
-- All blinds are boss blinds
-- and showdown blinds can appear anywhere
-- must win ante 13 to win
-- all final blinds per ante are repleaced with obsidian orb
SMODS.Challenge{
	key = "unik_boss_rush_3",
	rules = {
		custom = {
			{ id = "cry_rush_hour_ii" },
			{ id = "cry_no_tags" },
            { id = "cry_big_showdown"},
            { id = "unik_ante_13_victory"},
            { id = "unik_obsidian_swarm"},
		},
		modifiers = {                
            {id = 'joker_slots', value = 7},
            {id = 'consumable_slots', value = 3},
    },
	},
	jokers = {
		{ id = "j_cry_apjoker", stickers = { "cry_absolute" } },
		{ id = "j_cry_apjoker", stickers = { "cry_absolute","banana" } },
		{ id = "j_cry_big_cube", stickers = { "cry_absolute","banana" } },
		{ id = "j_unik_jsab_chelsea", stickers = { "cry_absolute" } },
        { id = "j_cry_fleshpanopticon", stickers = { "cry_absolute" }},
        { id = "j_unik_border_wall", stickers = { "cry_absolute" }},
        { id = "j_mr_bones", stickers = { "cry_absolute" }, edition = "negative" },
        { id = "j_cavendish", stickers = { "cry_rigged","perishable","banana","cry_flickering","pinned","cry_absolute","eternal" }, edition = "unik_positive" },
        { id = "j_cavendish", stickers = { "cry_rigged","perishable","banana","cry_flickering","pinned","cry_absolute","eternal" }, edition = "unik_positive" },
		{ id = "j_cavendish", stickers = { "cry_rigged","perishable","banana","cry_flickering","pinned","cry_absolute","eternal" }, edition = "unik_positive" },
		{ id = "j_cavendish", stickers = { "cry_rigged","perishable","banana","cry_flickering","pinned","cry_absolute","eternal" }, edition = "unik_positive" },
		{ id = "j_cavendish", stickers = { "cry_rigged","perishable","banana","cry_flickering","pinned","cry_absolute","eternal" }, edition = "unik_positive" },
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
