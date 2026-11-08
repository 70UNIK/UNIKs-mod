--Create 20 Cursed Jokers
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 0, y = 1},
	key = 'unik_hellspawn',
    config = {extra = {subpars = 10, significants = 7, severes = 3}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
	attributes = { 'detrimental','rarity','joker' },
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.subpars,
				center.ability.extra.significants,
				center.ability.extra.severes
			},
		}
	end,
	use = function(self, card, area, copier)
        local showman = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_ring_master', 'tempshowman')
		showman.ability.eternal = true
		showman:add_to_deck()
		G.jokers:emplace(showman)

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i = 1, card.ability.extra.subpars do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
						--TODO swap out 
                        play_sound("timpani")
                        UNIK.create_detriment({severity = 1,seed = "unik_hellspawn_sub" })
						return true
					end
				}))
			end
			for i = 1, card.ability.extra.significants do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
						--TODO swap out 
                        play_sound("timpani")
                        UNIK.create_detriment({severity = 2,seed = "unik_hellspawn_sig" })
						return true
					end
				}))
			end
			for i = 1, card.ability.extra.severes do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
						--TODO swap out 
                        play_sound("timpani")
                        UNIK.create_detriment({severity = 3,seed = "unik_hellspawn_sev" })
						return true
					end
				}))
			end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            selfDestruction_noMessage(showman,false)
            return true end })) 
        return true end })) 
        
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}