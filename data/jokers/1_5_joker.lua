--10 mult for playing 5 cards (not all will have to score), +4 mult for any additional cards above 5
SMODS.Atlas {
	key = "unik_one_and_a_half_joker",
	path = "unik_one_and_a_half_joker.png",
	px = 71,
	py = 144
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_1_5_joker',
    atlas = 'unik_one_and_a_half_joker',
    rarity = 1,
	pos = { x = 0, y = 0 },
	-- Modest
    config = { extra = { mult = 10, mult_mod = 8,hand_size = 5} },
	gameset_config = {
		modest = { extra = { mult = 8, mult_mod = 6,hand_size = 5} },
	},
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	display_size = { w = 71, h = 144 },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult,center.ability.extra.mult_mod,center.ability.extra.hand_size} }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand >= card.ability.extra.hand_size then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult + card.ability.extra.mult_mod * (#context.full_hand - card.ability.extra.hand_size)}},
                    mult_mod = card.ability.extra.mult
                }
			end
		end
	end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_1_5_joker"] = {
		text = {
            { text = "+" },
            { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
        },
		reminder_text = {
			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER,scale = 0.3},
		},
        text_config = { colour = G.C.MULT },
        calc_function = function(card)
            local hand = JokerDisplay.current_hand
            card.joker_display_values.mult = hand and #hand > 0 and #hand >= card.ability.extra.hand_size and
                card.ability.extra.mult + card.ability.extra.mult_mod * (#hand - card.ability.extra.hand_size) or 0
			card.joker_display_values.localized_text = (hand and #hand > 0 and #hand >= card.ability.extra.hand_size and "(" .. #hand .. ' ' .. localize('k_unik_cards') .. ")") or ''
        end
	}
end