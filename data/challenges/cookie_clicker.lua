-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_cookie_clicker_1",
	rules = {
		custom = {
			{ id = "unik_all_cookie" },
            { id = "unik_legendary_at_any_time" },
		},
		modifiers = {
 
        },
	},
	jokers = {},
	deck = {
		type = "Challenge Deck",
	},
	apply = function(self)
    end,
	restrictions = {
		banned_tags = {

		},
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
            { id = "v_directors_cut" },
			{ id = "v_retcon" },
		},
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