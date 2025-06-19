--+1 discard when blind selected cause we need a discards version of blurred joker.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_shitty_joker',
    atlas = 'unik_common',
	pos = { x = 0, y = 1 },
    rarity = 1,
	-- Modest
    config = { extra = { discards = 1},immutable = { max_hand_size_mod = 1000 }, },
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.discards} }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) or context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_discard(
						math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards)
					)
					card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_unik_discards",
							vars = {
								math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards),
							},
						}),
					})
					return true
				end,
			}))
		end
	end,
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