--Bloater: +1 Hand Size, add (Bloaters used + 1) * 10 random cards to your hand
SMODS.Consumable{
    set = "Spectral",
	key = "unik_bloater",
	pos = { x = 2, y = 2 },
	cost = 4,
	atlas = "placeholders",
	order = 90,
    config = {
		extra = {
            hand_size = 1
        }
	},
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
        G.GAME.unik_bloater_bloat = G.GAME.unik_bloater_bloat or 0
        local formula = (G.GAME.unik_bloater_bloat + 1) * 10
		return { vars = {center.ability.extra.hand_size,formula } }
	end,
	use = function(self, card, area, copier)
        G.GAME.unik_bloater_bloat  = G.GAME.unik_bloater_bloat  or 0
        local formula = (G.GAME.unik_bloater_bloat + 1) * 10
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local cardsCreated = {}
            for i = 1, formula do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
                        G.hand:change_size(card.ability.extra.hand_size)
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local edition = G.P_CENTERS.c_base
						local card_ = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, pseudorandom_element(G.P_CARDS, pseudoseed('garbage_random')), G.P_CENTERS.c_base, {playing_card = G.playing_card})
						if G.GAME.selected_back.effect.config.cry_force_edition and G.GAME.selected_back.effect.config.cry_force_edition ~= "random" then
							local edition = {}
							edition[G.GAME.selected_back.effect.config.cry_force_edition] = true
							card_:set_edition(edition, true, true);
						end
						if math.floor(i/2) ~= i then play_sound('card1') end
						table.insert(G.playing_cards, card_)

						G.deck:emplace(card_)
						card:juice_up(0.3, 0.5)
						cardsCreated[#cardsCreated+1] = card
						return true
					end
				}))
			end
			delay(0.1)
			G.E_MANAGER:add_event(Event({
					delay = 0.1,
					trigger= 'after',
					func = function()
						playing_card_joker_effects(cardsCreated)
						return true
					end
			}))
        return true end })) 
	end,
}