--Create 20 Cursed Jokers
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 0, y = 1},
	key = 'unik_hellspawn',
    config = {extra = {jokers = 20}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.jokers,
			},
		}
	end,
	use = function(self, card, area, copier)
        local showman = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_ring_master', 'tempshowman')
		showman.ability.eternal = true
		showman:add_to_deck()
		G.jokers:emplace(showman)

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i = 1, card.ability.extra.jokers do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
                        play_sound("timpani")
                        local card_ = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "unik_hellspawn")
                        card_:start_materialize()
                        card_:add_to_deck()
                        G.jokers:emplace(card_)
                        card:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            selfDestruction_noMessage(showman,false)
            return true end })) 
        return true end })) 
        
    end 
}