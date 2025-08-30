--Broken Scale: Scaling Jokers 1/3 as fast
--Self destructs after e^2 rounds (>7 rounds)
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_broken_scale',
    atlas = 'unik_cursed',
    rarity = UnikDetrimentalRarity(),
    no_dbl = true,
	pos = { x = 0, y = 2 },
    cost = 1,
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
		if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
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
    end
} 
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_broken_scale"] = {
-- 		text = {
-- 			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
-- 		},
--         calc_function = function(card)
--             local text = ""
--             text = "(" .. card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit .. ")"
-- 			card.joker_display_values.localized_text = text
--         end
-- 	}
-- end