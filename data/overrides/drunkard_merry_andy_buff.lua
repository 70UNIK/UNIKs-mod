SMODS.Joker:take_ownership("j_drunkard",{
    demicoloncompat = true,
        blueprint_compat = true,
    config = { extra = { discards = 1},immutable = { max_hand_size_mod = 100 }, },
    loc_vars = function(self, info_queue, center)
		return { vars = {math.min(center.ability.extra.discards,center.ability.immutable.max_hand_size_mod)} }
	end,
    add_to_deck = function(self, card, from_debuff)

	end,
	remove_from_deck = function(self, card, from_debuff)

	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			ease_discard(
				math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards)
			)
			return{
				message = localize({
					type = "variable",
					key = "a_unik_discards",
					vars = {
						math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards),
					},
				}),
				colour = G.C.RED
			}
		end
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) then
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
						colour = G.C.RED
					})
					return true
				end,
			}))
			return {

			}
		end
	end,
},true)

SMODS.Joker:take_ownership("j_merry_andy",{
    demicoloncompat = true,
    blueprint_compat = true,
    config = { extra = { discards = 3},immutable = { max_hand_size_mod = 100,hand_size = -1 }, },
    loc_vars = function(self, info_queue, center)
		return { vars = {math.min(center.ability.extra.discards,center.ability.immutable.max_hand_size_mod),center.ability.immutable.hand_size} }
	end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.immutable.hand_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.immutable.hand_size)
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			ease_discard(
				math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards)
			)
			return{
				message = localize({
					type = "variable",
					key = "a_unik_discards",
					vars = {
						math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.discards),
					},
				}),
				colour = G.C.RED
			}
		end
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) then
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
						colour = G.C.RED
					})
					return true
				end,
			}))
			return {

			}
		end
	end,
},true)


