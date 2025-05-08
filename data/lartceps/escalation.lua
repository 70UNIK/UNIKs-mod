--cryptid: ^2 ante
--almananc: ^1.5 ante, ^1.5 tension, ^1.5 straddle (if either are enabled), rounded up of course
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 0, y = 0},
	key = 'unik_escalation',
    config = {extra = {cryptid_size = 2, almanac_size = 1.8}},
    immutable = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
        if (SMODS.Mods["jen"] or {}).can_load then
            local tension = false
            local straddle = false
            if Jen.config.straddle.enabled then
                straddle = true
            end
            if Jen.config.punish_reroll_abuse then
                tension = true
            end
            if tension or straddle then
                return {
                    key = "c_unik_escalation_almanac",
                    vars = {
                        center.ability.extra.almanac_size^3,
                        center.ability.extra.almanac_size,
                    },
                }
            else
                return {
                    key = "c_unik_escalation_cryptid",
                    vars = {
                        center.ability.extra.cryptid_size,
                        0,0,
                    },
                }
            end
            
        else
            return {
                key = "c_unik_escalation_cryptid",
                vars = {
                    center.ability.extra.cryptid_size,
                    0,0,
                },
            }
        end
		
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if (SMODS.Mods["jen"] or {}).can_load then
                local tension = false
                if Jen.config.straddle.enabled then
                    start_straddle()
                end
                if Jen.config.punish_reroll_abuse then
                    tension = true
                    if G.GAME.tension < 2 then
                        ease_tension(-G.GAME.tension + 2)
                    end
                    ease_tension(((G.GAME.tension^card.ability.extra.almanac_size)-G.GAME.tension))
                    card:juice_up(0.3, 0.5)
                end
                if tension or Jen.config.straddle.enabled then--its so cruel that its multiplicative with straddle
                    ease_ante(math.ceil(G.GAME.round_resets.ante*(card.ability.extra.almanac_size^3)))
                    card:juice_up(0.3, 0.5)
                else
                    ease_ante(math.ceil(G.GAME.round_resets.ante^card.ability.extra.cryptid_size))
                    card:juice_up(0.3, 0.5)
                end
                
            else
                ease_ante(math.ceil(G.GAME.round_resets.ante^card.ability.extra.cryptid_size))
                card:juice_up(0.3, 0.5)
            end
        return true end })) 
    end 
}