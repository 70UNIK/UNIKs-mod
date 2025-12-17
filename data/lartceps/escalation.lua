SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 4, y = 1},
	key = 'unik_escalation',
    config = {extra = {ante = 2}},
    immutable = true,
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    loc_vars = function(self, info_queue, center)
        return {
            key = "c_unik_escalation",
            vars = {
                center.ability.extra.ante
            },
        }	
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            ease_ante(G.GAME.round_resets.ante*card.ability.extra.ante - G.GAME.round_resets.ante)
            card:juice_up(0.3, 0.5)
        return true end })) 
    end ,
    in_pool = function()
		return lartcepsCheck()
	end,
}