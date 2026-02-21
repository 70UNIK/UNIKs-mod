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
        banned_tags = function(self)
            local banList = {}
            --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags

            banList[#banList+1] = {id = 'tag_charm'}
            
            return banList
        end,
		banned_cards = {
            { id = 'p_arcana_normal_1', ids = {
                'p_arcana_normal_1', 'p_arcana_normal_2',
                'p_arcana_normal_3', 'p_arcana_normal_4',
                'p_arcana_jumbo_1', 'p_arcana_jumbo_2',
                'p_arcana_mega_1', 'p_arcana_mega_2' }
            },
            {id = 'v_tarot_merchant'},
            {id = 'v_tarot_tycoon'},
            {id = 'c_unik_charleston'},
            {id = 'c_unik_whitney'},
            {id = 'c_talisman'},
            {id = 'c_immolate'},
            {id = 'c_devil'},
            {id = 'c_temperance'},
            {id = 'c_hermit'},
            {id = 'j_unik_golden_glove'},
		},
        banned_other = function(self)
			local banList = {}
			banList[#banList+1] = {id = 'bl_unik_raspberry_racket', type = 'blind'}
			return banList
		end,
	},

}