--mr bones now will have a values stating which chips you need to survive.
--also only one mr bones will trigger at a time

SMODS.Joker:take_ownership("j_mr_bones",{
    config = { extra = { amount = 4 },},
    loc_vars = function(self, info_queue, center)
        local blindsize = 0
        if G.GAME.blind then
            blindsize = G.GAME.blind.chips * 1/center.ability.extra.amount
        end
		return { vars = {1/center.ability.extra.amount,blindsize} }
	end,
    blueprint_compat = false,
	calculate = function(self, card, context)
		if context.game_over and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips * 1/card.ability.extra.amount) and not G.GAME.unik_mr_bones_buffer then
            G.GAME.unik_mr_bones_buffer = true
            selfDestruction_noMessage(card,false)
            return {
                message = localize('k_saved_ex'),
                saved = true,
                colour = G.C.RED,
                func = function(self)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.unik_mr_bones_buffer = nil
                            return true
                        end
                    }))
                    
                end
            }
        end
	end,
},true)