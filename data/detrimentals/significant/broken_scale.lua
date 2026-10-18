UNIK.detriment{
    key = "unik_broken_scale",
    atlas = "unik_detriments",
	pos = { x = 1, y = 1 },
    severity = 2,
    attributes = { 'detrimental','scaling' },
    config = { extra = {rounds = 0,round_limit = 8} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = { center.ability.extra.rounds,center.ability.extra.round_limit } }
    end,
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    immutable = true,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        if scalar_value > 0 then
            return {
                override_scalar_value = {
                    value = scalar_value/3, 
                },
            }
        end
    end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.unik_detriments and not context.repetition and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds > card.ability.extra.round_limit then
                selfDestruction(card,"k_unik_weapon_destroyed",G.C.BLACK)
            else
                return{
                    message = card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit,
                    colour = G.C.BLACK,
                }
            end
        end
    end,
}
