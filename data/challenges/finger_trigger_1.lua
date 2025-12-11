SMODS.Challenge{
    key = "unik_finger_trigger",
	rules = {
		modifiers = {},
        custom = {
            { id = "unik_all_triggering"},
		},
	},
    jokers = {
        { id = "j_cavendish", edition = "negative"},
	},
	deck = {
		type = "Challenge Deck",
        cards = {
            { s = "D", r = "2", stickers = {"unik_triggering"} },
			{ s = "D", r = "3", stickers = {"unik_triggering"}  },
			{ s = "D", r = "4", stickers = {"unik_triggering"}  },
			{ s = "D", r = "5", stickers = {"unik_triggering"}  },
			{ s = "D", r = "6", stickers = {"unik_triggering"}  },
			{ s = "D", r = "7", stickers = {"unik_triggering"} },
			{ s = "D", r = "8", stickers = {"unik_triggering"}  },
			{ s = "D", r = "9", stickers = {"unik_triggering"}  },
			{ s = "D", r = "T", stickers = {"unik_triggering"}  },
			{ s = "D", r = "J", stickers = {"unik_triggering"}  },
			{ s = "D", r = "Q", stickers = {"unik_triggering"}  },
			{ s = "D", r = "K", stickers = {"unik_triggering"}  },
			{ s = "D", r = "A", stickers = {"unik_triggering"}  },
			{ s = "C", r = "2", stickers = {"unik_triggering"}  },
			{ s = "C", r = "3", stickers = {"unik_triggering"}  },
			{ s = "C", r = "4", stickers = {"unik_triggering"}  },
			{ s = "C", r = "5", stickers = {"unik_triggering"}  },
			{ s = "C", r = "6", stickers = {"unik_triggering"}  },
			{ s = "C", r = "7", stickers = {"unik_triggering"}  },
			{ s = "C", r = "8", stickers = {"unik_triggering"}  },
			{ s = "C", r = "9", stickers = {"unik_triggering"}  },
			{ s = "C", r = "T", stickers = {"unik_triggering"}  },
			{ s = "C", r = "J", stickers = {"unik_triggering"}  },
			{ s = "C", r = "Q", stickers = {"unik_triggering"}  },
			{ s = "C", r = "K", stickers = {"unik_triggering"}  },
			{ s = "C", r = "A", stickers = {"unik_triggering"}  },
			{ s = "H", r = "2", stickers = {"unik_triggering"}  },
			{ s = "H", r = "3", stickers = {"unik_triggering"}  },
			{ s = "H", r = "4", stickers = {"unik_triggering"}  },
			{ s = "H", r = "5", stickers = {"unik_triggering"}  },
			{ s = "H", r = "6", stickers = {"unik_triggering"}  },
			{ s = "H", r = "7", stickers = {"unik_triggering"}  },
			{ s = "H", r = "8", stickers = {"unik_triggering"}  },
			{ s = "H", r = "9", stickers = {"unik_triggering"}  },
			{ s = "H", r = "T", stickers = {"unik_triggering"}  },
			{ s = "H", r = "J", stickers = {"unik_triggering"}  },
			{ s = "H", r = "Q", stickers = {"unik_triggering"}  },
			{ s = "H", r = "K", stickers = {"unik_triggering"}  },
			{ s = "H", r = "A", stickers = {"unik_triggering"}  },
			{ s = "S", r = "2", stickers = {"unik_triggering"}  },
			{ s = "S", r = "3", stickers = {"unik_triggering"}  },
			{ s = "S", r = "4", stickers = {"unik_triggering"}  },
			{ s = "S", r = "5", stickers = {"unik_triggering"}  },
			{ s = "S", r = "6", stickers = {"unik_triggering"}  },
			{ s = "S", r = "7", stickers = {"unik_triggering"}  },
			{ s = "S", r = "8", stickers = {"unik_triggering"}  },
			{ s = "S", r = "9", stickers = {"unik_triggering"}  },
			{ s = "S", r = "T", stickers = {"unik_triggering"}  },
			{ s = "S", r = "J", stickers = {"unik_triggering"}  },
			{ s = "S", r = "Q", stickers = {"unik_triggering"}  },
			{ s = "S", r = "K", stickers = {"unik_triggering"}  },
			{ s = "S", r = "A", stickers = {"unik_triggering"}  },
        }
	},
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for i,v in pairs(G.playing_cards) do
					v.ability.unik_triggering = true
				end
				return true
			end,
		}))
        
    end,
    restrictions = {
		banned_cards = function(self)
            local bannedCards = {}
             bannedCards[#bannedCards+1] = {id = 'j_unik_yes_nothing'}

            return bannedCards
        end,  
    },

}