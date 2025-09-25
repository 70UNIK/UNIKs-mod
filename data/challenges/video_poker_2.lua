-- All Boss Blinds are Video Poker
-- All Blinds are Boss Blinds
-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_video_poker_2",
	rules = {
		custom = {
			{ id = "unik_all_video_poker" },
            { id = "unik_purple_scaling"},
            { id = "cry_rush_hour_ii" },
			{ id = "unik_no_skipping" },
		},
		modifiers = {

        },
	},
	jokers = {},
	deck = {
		type = "Challenge Deck",
	},
	apply = function(self)
        G.GAME.all_finishers = true
    end,
	restrictions = {
		banned_tags = {

		},
		banned_cards = function(self)
			local banList = {}
			banList[#banList + 1] = { id = "j_luchador" }
			if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
				banList[#banList + 1] = { id = "j_cry_lebaron_james"}
				banList[#banList + 1] = { id = "j_cry_number_blocks"}
				banList[#banList + 1] = { id = "v_cry_copies" }
				banList[#banList + 1] = { id = "v_cry_tag_printer" }
				banList[#banList + 1] = { id = "v_cry_clone_machine" }
				banList[#banList + 1] = {id = 'j_cry_effarcire'}
				banList[#banList + 1] = {id = 'j_cry_sus'}

				banList[#banList + 1] = {id = 'j_cry_filler'}

				banList[#banList + 1] = {id = 'j_cry_fractal'}
				
				banList[#banList + 1] = {id = 'v_cry_blankcanvas'}
				banList[#banList + 1] = {id = 'v_cry_stickyhand'}
				banList[#banList + 1] = {id = 'v_cry_grapplinghook'}
				banList[#banList + 1] = {id = 'v_cry_hyperspacetether'}
				
				banList[#banList + 1] = {id = 'v_recyclomancy'}
				banList[#banList + 1] = {id = 'v_cry_threers'}
				banList[#banList + 1] = {id = 'j_cry_huntingseason'}
				banList[#banList + 1] = { id = "j_cry_pickle" }
			end
		banList[#banList + 1] = {id = 'v_wasteful'}
		banList[#banList + 1] = {id = 'v_paint_brush'}
		banList[#banList + 1] = {id = 'v_palette'}
		banList[#banList + 1] = {id = 'j_half'}
		banList[#banList + 1] ={id = 'j_juggler'}
		banList[#banList + 1] = {id = 'j_troubadour'}
		banList[#banList + 1] ={id = 'j_drunkard'}
		banList[#banList + 1] =  {id = 'j_merry_andy'}
		banList[#banList + 1] ={id = 'j_turtle_bean'}
		banList[#banList + 1] = {id = 'j_sixth_sense'}
		banList[#banList + 1] = {id = 'j_dna'}
		
		banList[#banList + 1] = {id = 'j_square'}
		banList[#banList + 1] = {id = 'j_unik_cube_joker'}
		if (SMODS.Mods["extracredit"] or {}).can_load then
            banList[#banList + 1] = {id = 'j_ExtraCredit_alloy'}
			banList[#banList + 1] = {id = 'j_ExtraCredit_farmer'}
        end
		if (SMODS.Mods["Neato_Jokers"] or {}).can_load then
            banList[#banList + 1] = {id = 'j_neat_dayman'}
        end		
		if next(SMODS.find_mod("GrabBag")) then
			banList[#banList + 1] = {id = 'j_unik_halved'}
		end
			banList[#banList + 1] = { id = "j_chicot" }
			banList[#banList + 1] = { id = "j_throwback" }
			banList[#banList + 1] = { id = "j_diet_cola" }
            banList[#banList + 1] = { id = "c_pluto" }
			banList[#banList + 1] = { id = "c_chariot" }
			banList[#banList + 1] = { id = "c_devil" }
			banList[#banList + 1] = { id = "v_directors_cut" }
			banList[#banList + 1] = { id = "v_retcon" }
			banList[#banList + 1] = { id = "j_mime" }
			banList[#banList + 1] = { id = "j_raised_fist" }
			banList[#banList + 1] = { id = "j_reserved_parking" }
			banList[#banList + 1] = { id = "j_shoot_the_moon" }
			banList[#banList + 1] = { id = "j_baron" }
			banList[#banList + 1] = { id = "c_trance" }
			banList[#banList + 1] = { id = "c_unik_foundry"}
			banList[#banList + 1] = { id = "j_unik_borg_cube"}
			banList[#banList + 1] = {id = "j_unik_lone_despot"}
			banList[#banList + 1] = {id = "c_chariot"}
			
			
			
			-- Ban anything that relies on held effects
			return banList
		end,
		banned_other = function(self)
			local banList = {}
			for k, v in pairs(G.P_BLINDS) do
				if k ~= "bl_unik_video_poker" and v.boss then
					banList[#banList+1] = {id = k, type = 'blind'}
				end
			end
			return banList
		end,
	},

}