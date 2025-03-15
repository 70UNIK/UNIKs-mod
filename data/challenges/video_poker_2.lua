-- All Boss Blinds are Video Poker
-- All Blinds are Boss Blinds
-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_video_poker_2",
	rules = {
		custom = {
			{ id = "unik_all_video_poker" },
            { id = "cry_big_showdown"},
            { id = "unik_purple_scaling"},
            { id = "cry_rush_hour_ii" },
			{ id = "cry_no_tags" },
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
			{ id = "j_throwback" },
			{ id = "j_diet_cola" },
            { id = "c_pluto" },
			{ id = "c_chariot" },
			{ id = "c_devil" },
			{ id = "v_directors_cut" },
			{ id = "v_retcon" },
			{ id = "j_cry_pickle" },
			{ id = "j_mime" },
			{ id = "j_raised_fist" },
			{ id = "j_reserved_parking" },
			{ id = "j_shoot_the_moon" },
			{ id = "j_baron" },
			{ id = "j_cry_lebaron_james"},
			{ id = "j_cry_number_blocks"},
			{ id = "c_trance" },
			{ id = "v_cry_copies" },
			{ id = "v_cry_tag_printer" },
			{ id = "v_cry_clone_machine" },
			-- Ban anything that relies on held effects
			
		},
        banned_other = {
        },
	},

}
for i = 1, #G.CHALLENGES do
    if G.CHALLENGES[i].id == 'c_unik_video_poker_2' and #G.CHALLENGES[i].restrictions.banned_cards <=22 then
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_cry_effarcire'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_cry_sus'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_sixth_sense'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_dna'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_cry_huntingseason'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_square'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_unik_cube_joker'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_cry_filler'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_half'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_juggler'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_troubadour'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_drunkard'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_merry_andy'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_turtle_bean'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_cry_fractal'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_paint_brush'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_palette'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_cry_blankcanvas'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_cry_stickyhand'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_cry_grapplinghook'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_cry_hyperspacetether'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_wasteful'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_recyclomancy'}
		G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_cry_threers'}
		if (SMODS.Mods["extracredit"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_alloy'}
			G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_farmer'}
        end
		if (SMODS.Mods["Neato_Jokers"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_neat_dayman'}
        end
	end
end