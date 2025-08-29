--cryptid: ^2 ante
--almananc: ^1.5 ante, ^1.5 tension, ^1.5 straddle (if either are enabled), rounded up of course
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 4, y = 1},
	key = 'unik_escalation',
    config = {extra = {cryptid_size = 1.25, almanac_size = 1.8}},
    immutable = true,
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    loc_vars = function(self, info_queue, center)
        return {
            key = "c_unik_escalation_cryptid",
            vars = {
                center.ability.extra.cryptid_size,
                0,0,
            },
        }	
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            ease_ante(math.ceil(G.GAME.round_resets.ante^card.ability.extra.cryptid_size))
            card:juice_up(0.3, 0.5)
        return true end })) 
    end ,
    in_pool = function()
		return lartcepsCheck()
	end,
}