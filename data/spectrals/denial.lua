--convert 3 selected cards to crosses
SMODS.Consumable{
    set = "Spectral",
	key = "unik_denial",
	pos = { x = 4, y = 0 },
	cost = 4,
	atlas = "unik_spectrals",
    config = {
		max_highlighted = 5,
        suit_conv = 'unik_Crosses'
	},
	loc_vars = function(self, info_queue, center)
		          info_queue[#info_queue + 1] = { set = "Other", key = "unik_crosses_info" }
		return { vars = {center.ability.max_highlighted,localize(
					"unik_Crosses",
					"suits_plural"
				),
				colours = {
					G.C.SUITS["unik_Crosses"],
				},
			},
			
		}
	end,
	 use = function(self)

        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({
					delay = 0.15,
					trigger= 'after',
					func = function()
						G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);
						return true
					end
			}))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
					delay = 0.1,
					trigger= 'after',
					func = function()
						G.hand.highlighted[i]:change_suit(self.config.suit_conv);
						return true
					end
			}))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
			G.E_MANAGER:add_event(Event({
				delay = 0.15,
				trigger= 'after',
				func = function()
					 G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3);
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