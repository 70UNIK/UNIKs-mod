
--Properly making depleted jokers work
--Clicked cookie
SMODS.Joker:take_ownership("j_cry_clicked_cookie",{
	config = {
		extra = {
			chips = 200,
			chip_mod2 = 1,
			depleted_threshold = -200,
		},
	},
	pools = { ["autocannibalism_food"] = true, ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		local key = 'j_cry_clicked_cookie2'
		local sign = "+"
		if center.ability and center.ability.unik_depleted then
			key = 'j_cry_clicked_cookie_depleted'
		end
		if center.ability and center.ability.extra and center.ability.extra.chips and center.ability.extra.chips <= 0 then
			sign = ""
		end 
		return {
			key = key,
			vars = {
				sign,
				center.ability.extra.chips,
				center.ability.extra.chip_mod2,
				center.ability.extra.depleted_threshold,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			local sign = "+"
			if  to_big(card.ability.extra.chips) <=  to_big(0) then
				sign = ""
			end 
			return {
				card = card,
				chip_mod = lenient_bignum(card.ability.extra.chips),
				message = sign .. number_format(card.ability.extra.chips),
				colour = G.C.CHIPS,
			}
		end
		if context.cry_press  and not context.blueprint then
			if (not card.ability.unik_depleted and to_big(card.ability.extra.chips) - to_big(card.ability.extra.chip_mod2) <= to_big(0))
				or (card.ability.unik_depleted and to_big(card.ability.extra.chips) - to_big(card.ability.extra.chip_mod2) <= to_big(card.ability.extra.depleted_threshold))
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_eaten_ex"), colour = G.C.CHIPS }
				)
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_mod2",
					scaling_message = {
						message = "-" .. number_format(card.ability.extra.chip_mod2),
						colour = G.C.CHIPS,
					},
				})
								return {

				}
			end
		end
	end,
}, true)
--Ice cream
SMODS.Joker:take_ownership("j_ice_cream",{
	config = {
		extra = {chips = 100, chip_mod2 = 5,depleted_threshold = -100}
	},
	loc_vars = function(self, info_queue, center)
		local key = 'j_ice_cream'
		local sign = "+"
		if center.ability.unik_depleted then
			key = 'j_ice_cream_depleted'
		end
		if lenient_bignum(center.ability.extra.chips) <= lenient_bignum(0) then
			sign = ""
		end 
		return {
			key = key,
			vars = {
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.chip_mod2),
				sign,
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			if (card.ability.unik_depleted and card.ability.extra.chips - card.ability.extra.chip_mod2 < card.ability.extra.depleted_threshold) or (not card.ability.unik_depleted and card.ability.extra.chips - card.ability.extra.chip_mod2 <= 0) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = localize('k_melted_ex'),
					colour = G.C.CHIPS
				}
			else
				 SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_mod2",
					operation = "-",
					message_key = 'a_chips_minus',
					message_colour = G.C.CHIPS,
				})
								return {

				}
			end
		end
		if context.joker_main then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips, 
				colour = G.C.CHIPS
			}
		end
	end,

}, true)
--Popcorn
SMODS.Joker:take_ownership("j_popcorn",{
	config = {
		extra = {mult = 20, extra = 4,depleted_threshold = -20},
	},
	loc_vars = function(self, info_queue, center)
		local key = 'j_popcorn'
		local sign = "+"
		if center.ability.unik_depleted then
			key = 'j_popcorn_depleted'
		end
		if lenient_bignum(center.ability.extra.mult) <= lenient_bignum(0) then
			sign = ""
		end 
		return {
			key = key,
			vars = {
				number_format(center.ability.extra.mult),
				number_format(center.ability.extra.extra),
				sign,
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round 
			and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
			-- adding depleted functionality for popcorn
			if (card.ability.unik_depleted and card.ability.extra.mult - card.ability.extra.extra < card.ability.extra.depleted_threshold) or (not card.ability.unik_depleted and card.ability.extra.mult - card.ability.extra.extra <= 0) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = localize('k_eaten_ex'),
					colour = G.C.RED
				}
			else
				SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "extra",
					message_key = 'a_mult_minus',
					message_colour = G.C.MULT,
					operation = '-'
				})
								return {

				}
			end
		end
		if context.joker_main then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult
			}
		end
	end
}, true)
--Ramen
SMODS.Joker:take_ownership("j_ramen",{
	config = {
		extra = {Xmult = 2, extra = 0.01,depleted_threshold = 0},
	},
	loc_vars = function(self, info_queue, center)
		local key = 'j_ramen'
		if center.ability.unik_depleted then
			key = 'j_ramen_depleted'
		end
		return {
			key = key,
			vars = {
				number_format(center.ability.extra.Xmult),
				number_format(center.ability.extra.extra),
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.discard and not context.blueprint) then
			if (card.ability.unik_depleted and card.ability.extra.Xmult - card.ability.extra.extra < card.ability.extra.depleted_threshold) or (not card.ability.unik_depleted and card.ability.extra.Xmult - card.ability.extra.extra <= 1) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					card = card,
					message = localize('k_eaten_ex'),
					colour = G.C.RED
				}
			else
				 SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "Xmult",
					scalar_value = "extra",
					operation = "-",
					message_key = 'a_xmult_minus',
					message_colour = G.C.RED,
					delay = 0.2,
				})
								return {

				}
			end
		end
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult,
				colour = G.C.MULT,
			}
		end
	end
}, true)

--TURtuuuLE BEEEEANANNN!!!
SMODS.Joker:take_ownership("j_turtle_bean",{
	config = {
		extra = {h_size = 5, h_mod = 1,depleted_threshold = -5},
	},
	loc_vars = function(self, info_queue, center)
		local key = 'j_turtle_bean'
		local sign = "+"
		if center.ability.unik_depleted then
			key = 'j_turtle_bean_depleted'
		end
		if lenient_bignum(center.ability.extra.h_size) <= lenient_bignum(0) then
			sign = ""
		end 
		return {
			key = key,
			vars = {
				number_format(center.ability.extra.h_size),
				number_format(center.ability.extra.h_mod),
				sign,
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round 
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker then
			if (card.ability.unik_depleted and card.ability.extra.h_size - card.ability.extra.h_mod < card.ability.extra.depleted_threshold) or (not (card.ability.unik_depleted) and card.ability.extra.h_size - card.ability.extra.h_mod <= 0) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					card = card,
					message = localize('k_eaten_ex'),
					colour = G.C.FILTER
				}
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "h_size",
					scalar_value = "h_mod",
					message_key = 'a_handsize_minus',
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial - change
						G.hand:change_size(- change)
					end
				})
								return {

				}
			end
		end
	end
}, true)
--Lollipop
SMODS.Joker:take_ownership("j_mf_lollipop",{
	loc_vars = function(self, info_queue, center)
		local key = 'j_mf_lollipop'
		if center.ability.unik_depleted then
			key = 'j_mf_lollipop_depleted'
		end
		return {
		key = key,
		vars = { center.ability.x_mult, center.ability.extra,0 }
		}
	end,
	pools = { ["autocannibalism_food"] = true, ["Food"] = true },
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and not context.retrigger_joker then
		if (card.ability.x_mult - card.ability.extra <= 1.01 and not card.ability.unik_depleted) or (card.ability.x_mult - card.ability.extra <= 0 and card.ability.unik_depleted) then 
			G.E_MANAGER:add_event(Event({
			func = function()
				play_sound('tarot1')
				card.T.r = -0.2
				card:juice_up(0.3, 0.4)
				card.states.drag.is = true
				card.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
				func = function()
					G.jokers:remove_card(card)
					card:remove()
					card = nil
					return true; end})) 
				return true
			end
			})) 
			return {
			message = localize('k_eaten_ex'),
			colour = G.C.FILTER
			}
		else
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "x_mult",
				scalar_value = "extra",
				operation = "-",
				message_key = 'a_xmult_minus',
				message_colour = G.C.RED
			})
							return {

				}
		end
		elseif context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			return {
			message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
			Xmult_mod = card.ability.x_mult,
			}
		end
	end
}, true)
--Nachos
SMODS.Joker:take_ownership("j_paperback_nachos",{
	loc_vars = function(self, info_queue, card)
		local key = 'j_paperback_nachos'
		if card.ability.unik_depleted then
			key = 'j_paperback_nachos_depleted'
		end
		return {
		key = key,
		vars = {
			card.ability.extra.X_chips,
			card.ability.extra.reduction_amount,
			0,
		}
		}
	end,
	pools = { ["autocannibalism_food"] = true, ["Food"] = true },
	demicolon_compat = true,
	calculate = function(self, card, context)
		-- Gives the xChips during play
		if context.joker_main or context.forcetrigger then
		return {
			x_chips = card.ability.extra.X_chips
		}
		end
		if context.discard and not context.blueprint then
			-- Reduce the xChips value
			SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "X_chips",
				scalar_value = "reduction_amount",
				message_key = "a_xchips_minus",
				operation = "-",
				message_colour = G.C.CHIPS,
				delay = 0.2,
			})

			-- Destroy Nachos if the current value is <= 1
			if (card.ability.extra.X_chips <= 1 and not card.ability.unik_depleted) or (card.ability.extra.X_chips <= 0 and card.ability.unik_depleted) then
				PB_UTIL.destroy_joker(card)

				return {
				message = localize('k_eaten_ex'),
				colour = G.C.FILTER,
				card = card
				}
			-- else
			-- 	return {
			-- 	delay = 0.2,
			-- 	message = localize {
			-- 		type = 'variable',
			-- 		key = 'a_xchips_minus',
			-- 		vars = { card.ability.extra.reduction_amount }
			-- 	},
			-- 	colour = G.C.CHIPS,
			-- 	card = card
			-- 	}
			end
							return {

				}
		end
	end
}, true)
--Starfruit (again...)
--starfruit should suicide itself if force triggered, starts at a much more reasonable ^1.5 emult and is immutable. Oh and it can be autocannibal food
SMODS.Joker:take_ownership("j_cry_starfruit",{
	config = { emult = 1.0, emult_mod = 0.2, immutable = {base_emult = 1} },
	immutable = true,
	loc_vars = function(self, info_queue, center)
		local key = 'j_cry_starfruit'
		if center.ability.unik_depleted then
			key = 'j_cry_starfruit_depleted'
		end
		return {
			key = key,
			vars = {
				number_format(center.ability.emult + center.ability.immutable.base_emult),
				number_format(center.ability.emult_mod),
			},
		}
	end,
	pools = { ["Food"] = true, ["autocannibalism_food"] = true},
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				e_mult = lenient_bignum(card.ability.emult),
				colour = G.C.DARK_EDITION,
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "emult",
				scalar_value = "emult_mod",
				operation = "-",
				no_message = true,
				 force_full_val = true,
				 base = 1,
			})
			if (to_number(card.ability.emult) <= 0.00000001 and not card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			elseif (to_number(card.ability.emult + card.ability.immutable.base_emult) <= 0.00000001 and card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			else
				return {
					e_mult = lenient_bignum(card.ability.emult + card.ability.immutable.base_emult),
					colour = G.C.DARK_EDITION,
				}
			end
		end
		if context.reroll_shop then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "emult",
				scalar_value = "emult_mod",
				operation = "-",
				no_message = true,
				 force_full_val = true,
				 base = 1,
			})
			--floating point precision can kiss my ass istg
			if (to_number(card.ability.emult) <= 0.00000001 and not card.ability.unik_depleted) or (to_number(card.ability.emult + card.ability.immutable.base_emult) <= 0.00000001 and card.ability.unik_depleted) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.DARK_EDITION,
				}
			else
				return {
					message = "-^" .. number_format(card.ability.emult_mod) .. " Mult",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
}, true)

--Force incompatible eternal jokers to be unsellable anyways
local eternalOverride = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
	local ret = eternalOverride(card,trigger)
	if card.ability.eternal then return true end
	return ret
end