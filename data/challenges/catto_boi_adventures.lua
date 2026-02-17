--start with checkered deck, 3 negative decaying the star and catto boi, if catto boi is destroyed, INSTANTLY LOSE
--all non diamonds, hearts and spades randomly become spades and hearts after round
--all jokers that use hearts and spades are banned.
SMODS.Challenge{
    key = "unik_catto_boi_adventures",
	rules = {
		custom = {
		},
		modifiers = {

        },
	},
	jokers = {
        { id = "j_unik_catto_boi", extra_stickers = {'unik_mad'}},
    },
    consumeables = {
        {id = 'c_star',edition= 'negative'},
        {id = 'c_star'},
        {id = 'c_star'},
    },
	deck = {
		type = "Checkered Deck",
                cards = {
            { s = "S", r = "3",},
			{ s = "S", r = "4",},
			{ s = "S", r = "5",},
			{ s = "S", r = "6",  },
			{ s = "S", r = "7", },
			{ s = "S", r = "8",  },
			{ s = "S", r = "9",  },
			{ s = "S", r = "T",   },
			{ s = "S", r = "J",  },
			{ s = "S", r = "Q",  },
			{ s = "S", r = "K",   },
			{ s = "S", r = "A",   },
                        { s = "S", r = "3",},
			{ s = "S", r = "4",},
			{ s = "S", r = "5",},
			{ s = "S", r = "6",  },
			{ s = "S", r = "7", },
			{ s = "S", r = "8",  },
			{ s = "S", r = "9",  },
			{ s = "S", r = "T",   },
			{ s = "S", r = "J",  },
			{ s = "S", r = "Q",  },
			{ s = "S", r = "K",   },
			{ s = "S", r = "A",   },
                        { s = "H", r = "3",},
			{ s = "H", r = "4",},
			{ s = "H", r = "5",},
			{ s = "H", r = "6",  },
			{ s = "H", r = "7", },
			{ s = "H", r = "8",  },
			{ s = "H", r = "9",  },
			{ s = "H", r = "T",   },
			{ s = "H", r = "J",  },
			{ s = "H", r = "Q",  },
			{ s = "H", r = "K",   },
			{ s = "H", r = "A",   },
                            { s = "H", r = "3",},
			{ s = "H", r = "4",},
			{ s = "H", r = "5",},
			{ s = "H", r = "6",  },
			{ s = "H", r = "7", },
			{ s = "H", r = "8",  },
			{ s = "H", r = "9",  },
			{ s = "H", r = "T",   },
			{ s = "H", r = "J",  },
			{ s = "H", r = "Q",  },
			{ s = "H", r = "K",   },
			{ s = "H", r = "A",   },
        }
	},
	restrictions = {
        -- banned_tags = function(self)
        --     local banList = {}
        --     --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags

        --     banList[#banList+1] = {id = 'tag_charm'}
            
        --     return banList
        -- end,
		banned_cards = {

		},
        banned_other = function(self)
			local banList = {}
			banList[#banList+1] = {id = 'bl_goad', type = 'blind'}
            banList[#banList+1] = {id = 'bl_head', type = 'blind'}
			return banList
		end,
	},

}