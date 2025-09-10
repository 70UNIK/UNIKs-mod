--If a cursed Joker is spawned, destroy it. It runs constantly if there are at least 1 cursed joker(s)
--For each destroyed cursed Joker, gain 1.5x Mult.
--If exceeding 8 cursed jokers, it will self destruct and RELEASE ALL CURSED JOKERS contained inside.
--Selling or its destruction will also release all cursed jokers.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_ghost_trap',
    atlas = 'unik_rare',
    rarity = 3,
	pos = { x = 0, y = 0 },
    cost = 8,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	experimental = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 1.5,limit = 10,destroyed = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.limit} }
	end,
	-- on self destruction, release all cursed jokers

    calculate = function(self, card, context)
		if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		--mahahahahah
		if context.forcetrigger and not context.blueprint and not context.retrigger_joker and not context.repetition then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
    end,
}
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_ghost_trap"] = {
-- 		text = {
-- 			{
-- 				border_nodes = {
-- 					{ text = "X"},
-- 					{
-- 						ref_table = "card.ability.extra",
-- 						ref_value = "x_mult",
-- 						retrigger_type = "exp",
-- 					},
-- 				},
-- 				border_colour = G.C.MULT,
-- 			},
-- 		},
-- 		reminder_text = {
-- 			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER },
-- 		},
-- 		calc_function = function(card)
-- 			card.joker_display_values.localized_text = "(" .. (card.ability.extra.cursed_jokers .. "/" .. card.ability.extra.cursed_joker_limit)
-- 				.. ")"
-- 		end,
-- 	}
-- end