-- convert 3 selected cards to noughts
SMODS.Consumable{
    set = "Spectral",
	key = "unik_ring",
	pos = { x = 7, y = 5 },
	cost = 4,
	atlas = "unik_consumables",
    config = {
		cards = 6,
        suit_conv = 'unik_Noughts'
	},
		loc_vars = function(self, info_queue, center)
			          info_queue[#info_queue + 1] = { set = "Other", key = "unik_noughts_info" }
		return { vars = {center.ability.cards,localize(
					"unik_Noughts",
					"suits_plural"
				),
				colours = {
					G.C.SUITS["unik_Noughts"],
				},
			 },
			
		}
	end,
	can_use = function (self, card)
       	for key, value in pairs(G.hand.cards) do
			if value.base.suit ~= card.ability.suit_conv then
				return true
			end
		end
        return false
    end,
	 use = function(self,card)

		local validCards = {}
		local temp_hand = {}
		for k, v in ipairs(G.hand.cards) do 
			if v.base.suit ~= card.ability.suit_conv then
				temp_hand[#temp_hand+1] = v 
			end
		end
		table.sort(temp_hand, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
		pseudoshuffle(temp_hand, pseudoseed('unik_ring'))

		for i = 1, math.min(card.ability.cards,#temp_hand) do 
			validCards[#validCards+1] = temp_hand[i] 
		end
		table.sort(validCards, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
        for i=1, #validCards do
            local percent = 1.15 - (i-0.999)/(#validCards-0.998)*0.3
			G.E_MANAGER:add_event(Event({
					delay = 0.15,
					trigger= 'after',
					func = function()
						validCards[i]:flip();play_sound('card1', percent);validCards[i]:juice_up(0.3, 0.3);
						return true
					end
			}))
        end
        delay(0.2)
        for i=1, #validCards do
			G.E_MANAGER:add_event(Event({
					delay = 0.1,
					trigger= 'after',
					func = function()
						validCards[i]:change_suit(card.ability.suit_conv);
						return true
					end
			}))
        end
        for i=1, #validCards do
            local percent = 0.85 + ( i - 0.999 ) / ( #validCards - 0.998 ) * 0.3
			G.E_MANAGER:add_event(Event({
				delay = 0.15,
				trigger= 'after',
				func = function()
					 validCards[i]:flip(); play_sound('tarot2', percent, 0.6); validCards[i]:juice_up(0.3, 0.3);
					return true
				end
			}))
        end
		G.E_MANAGER:add_event(Event({
			delay = 0.2,
			trigger= 'after',
			func = function()
					G.hand:unhighlight_all();
				return true
			end
		}))
        delay(0.5)
    end,
}