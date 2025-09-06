-- All Boss Blinds are Video Poker
-- All Blinds are Boss Blinds
-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_cookie_clicker_2",
	rules = {
		custom = {
			{ id = "unik_all_cookie" },
            { id = "unik_legendary_at_any_time" },
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
	restrictions = {
		banned_tags = {

		},
		banned_cards = function(self)
			local banList = {}
			banList[#banList + 1] = { id = "j_luchador" }
			if Cryptid then
				banList[#banList + 1] = { id = "v_cry_copies" }
				banList[#banList + 1] = { id = "v_cry_tag_printer" }
				banList[#banList + 1] = { id = "v_cry_clone_machine" }

				banList[#banList + 1] = {id = 'j_cry_filler'}
				banList[#banList + 1] = { id = "j_cry_pickle" }
			end
			banList[#banList + 1] = { id = "j_chicot" }
			banList[#banList + 1] = { id = "j_throwback" }
			banList[#banList + 1] = { id = "j_diet_cola" }
			banList[#banList + 1] = { id = "v_directors_cut" }
			banList[#banList + 1] = { id = "v_retcon" }
			
			
			
			-- Ban anything that relies on held effects
			return banList
		end,
		banned_other = function(self)
			local banList = {}
			for k, v in pairs(G.P_BLINDS) do
				if k ~= "bl_unik_cookie" and k ~= "bl_unik_epic_cookie" and v.boss then
					banList[#banList+1] = {id = k, type = 'blind'}
				end
			end
			return banList
		end,
	},

}