--Forcibly link 1-3 lartceps cards to 3 in 4 cards in deck each
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_polyminos',
    cost = 0,
	pos = {x = 0, y = 1},
	key = 'unik_parasite',
    config = {extra = {lart_min = 1, lart_max = 3, base = 1, odds = 4}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true
	end,
        set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
        	    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_namta
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.base, center.ability.extra.odds, 'unik_parasite')
        return {vars = {center.ability.extra.lart_min,center.ability.extra.lart_max,new_numerator,new_denominator}}
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local cards_created = {}
            for i,v in pairs(G.playing_cards) do
                if SMODS.pseudorandom_probability(card, 'unik_parasite', card.ability.extra.base, card.ability.extra.odds, 'unik_parasite') then
                    local cards = {}
                    local proceed = false
                    for j = 1, pseudorandom('unik_parasite_cards_added',1,3) do
                        G.E_MANAGER:add_event(Event({
                            delay = 0.1,
                            func = function()
                                
                                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                                local edition = G.P_CENTERS.c_base
                                local card_ = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, pseudorandom_element(G.P_CARDS, pseudoseed('garbage_random')), G.P_CENTERS.m_unik_namta, {playing_card = G.playing_card})
                                if G.GAME.selected_back.effect.config.cry_force_edition and G.GAME.selected_back.effect.config.cry_force_edition ~= "random" then
                                    local edition = {}
                                    edition[G.GAME.selected_back.effect.config.cry_force_edition] = true
                                    card_:set_edition(edition, true, true);
                                end
                                if math.floor(i/2) ~= i then play_sound('card1') end
                                table.insert(G.playing_cards, card_)
                                G.deck:emplace(card_)
                                cards_created[#cards_created+1] = card_
                                cards[#cards+1] = card_
                                proceed = true
                                return true
                            end
                        }))
                        
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            cards[#cards+1] = v
                            link_cards(cards,self.key)
                            return true
                        end
                    }))
                    
                end
            end
            
            
            card:juice_up(0.3, 0.5)
            delay(0.1)
			G.E_MANAGER:add_event(Event({
					delay = 0.1,
					trigger= 'after',
					func = function()
						playing_card_joker_effects(cards_created)
						return true
					end
			}))
        return true end })) 
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}