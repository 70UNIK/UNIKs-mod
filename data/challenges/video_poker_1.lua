-- all boss blinds are Video Poker
SMODS.Challenge{
    key = "unik_video_poker_1",
	rules = {
		custom = {
			{ id = "unik_all_video_poker" },
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
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
            { id = "v_directors_cut" },
			{ id = "v_retcon" },
		},
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
