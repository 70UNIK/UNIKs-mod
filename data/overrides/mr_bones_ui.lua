--mr bones now will have a values stating which chips you need to survive.

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
		if context.game_over and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips * 1/card.ability.extra.amount) then
            selfDestruction_noMessage(card,false)
            return {
                message = localize('k_saved_ex'),
                saved = true,
                colour = G.C.RED
            }
        end
	end,
},true)