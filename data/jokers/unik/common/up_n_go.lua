SMODS.Joker {
	key = 'unik_up_n_go',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 5, y = 0 },
    cost = 4,
    config = { extra = {x_mult = 2.5}, immutable = {rounds = 3}},
    loc_vars = function(self, info_queue, center)
        return { 
            vars = { center.ability.extra.x_mult,center.ability.immutable.rounds } }
    end,
	blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
	pools = { ["Food"] = true},
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                x_mult = card.ability.extra.x_mult,
            }
        end
        if context.force_trigger then
            card.ability.immutable.rounds = card.ability.immutable.rounds - 1
            if to_big(card.ability.immutable.rounds) <= to_big(0) then
                selfDestruction(card,"k_drank_ex",G.C.RED)
            else
                return{
                    x_mult = card.ability.extra.x_mult,
                }
            end
        end

		if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            card.ability.immutable.rounds = card.ability.immutable.rounds - 1
            if to_big(card.ability.immutable.rounds) <= to_big(0) then
                selfDestruction(card,"k_drank_ex",G.C.RED)
            else
                return{
                    message = card.ability.immutable.rounds.."",
                }
            end
        end
    end
} 