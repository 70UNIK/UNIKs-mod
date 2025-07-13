SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 2, y = 1},
	key = 'unik_garbage',
    config = {extra = {size = 100}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.size,
			},
		}
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local cardsCreated = {}
            for i = 1, card.ability.extra.size do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
                        
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
						card_:start_materialize()
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
    in_pool = function()
		return lartcepsCheck()
	end,
}