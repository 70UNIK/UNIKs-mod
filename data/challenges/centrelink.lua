--start with an eternal negative welfare payment and an eternal rental vagabond; arcana cards cannot spawn in the shop and all arcana packs are banned.
SMODS.Challenge{
    key = "unik_centrelink",
	rules = {
		custom = {
			{ id = "unik_no_arcana" },
            {id = 'no_reward'},

		},
		modifiers = {
            extra_hand_bonus = 0,
            {id = 'dollars', value = -10},
        },
	},
	jokers = {
        { id = "j_unik_welfare_payment", edition = "negative", extra_stickers = {'unik_taw','rental'}},
        { id = "j_vagabond", extra_stickers = {'unik_taw','rental'}},
        { id = "j_credit_card"},
    },
	deck = {
		type = "Challenge Deck",
	},
	apply = function(self)
        G.GAME.tarot_rate = 0
    end,
	restrictions = {
         banned_cards = function(self)
                local bannedCards = {}
                bannedCards[#bannedCards+1] = { id = 'p_arcana_normal_1', ids = {
                'p_arcana_normal_1', 'p_arcana_normal_2',
                'p_arcana_normal_3', 'p_arcana_normal_4',
                'p_arcana_jumbo_1', 'p_arcana_jumbo_2',
                'p_arcana_mega_1', 'p_arcana_mega_2' }
            }
                bannedCards[#bannedCards+1] = {id = 'v_tarot_tycoon'}
                bannedCards[#bannedCards+1] = {id = 'c_unik_charleston'}
                bannedCards[#bannedCards+1] = {id = 'c_unik_whitney'}
                bannedCards[#bannedCards+1] = {id = 'c_talisman'}
                bannedCards[#bannedCards+1] = {id = 'c_immolate'}
                bannedCards[#bannedCards+1] = {id = 'c_devil'}
                bannedCards[#bannedCards+1] = {id = 'c_unik_oligarch'}
                bannedCards[#bannedCards+1] = {id = 'c_temperance'}
                bannedCards[#bannedCards+1] = {id = 'c_hermit'}
                bannedCards[#bannedCards+1] = {id = 'm_gold'}
                bannedCards[#bannedCards+1] = {id = 'm_unik_dollar'}
                
                for i,v in pairs(G.P_CENTERS) do
                    if SMODS.has_attribute(v, "economy") or SMODS.has_attribute(v, "tarot") and v.key ~= 'j_vagabond'
                    then
                        bannedCards[#bannedCards+1] = {id = v.key}
                    end
                end

                return bannedCards
            end,
            banned_tags = function(self)
                local bannedCards = {}
                for i,v in pairs(G.P_TAGS) do
                    if SMODS.has_attribute(v, "economy") or SMODS.has_attribute(v, "tarot")  then
                        bannedCards[#bannedCards+1] = {id = v.key}
                    end
                end
                return bannedCards
            end,
        banned_other = function(self)
			local banList = {}
			banList[#banList+1] = {id = 'bl_unik_raspberry_racket', type = 'blind'}
			return banList
		end,
	},

}