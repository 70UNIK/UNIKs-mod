--literally flesh panopicon
SMODS.Joker {
    key = 'earthmover',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 6,
    immutable = true,
    eternal_compat = false,
	demicoloncompat = true,
    config = { extra = { exponent = 1.1 } },
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_unik_gateway" }
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		return { vars = { center.ability.extra.exponent } }
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced and not context.retrigger_joker and not context.repetition then
			local eval = function(card)
				return not card.REMOVED and not G.RESET_JIGGLES
			end
			juice_card_until(card, eval, true)
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips ^ card.ability.extra.exponent
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound("timpani")
							delay(0.4)
							return true
						end,
					}))
					card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("cry_good_luck_ex") })
					return true
				end,
			}))
		end
		if
			((context.end_of_round
			and not context.individual
			and not context.repetition
            and not context.retrigger_joker
			and not context.blueprint
			and G.GAME.blind.boss)
			or context.force_trigger)
			and not card.gone
		then
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					local card = create_card(
						nil,
						G.consumeables,
						nil,
						nil,
						nil,
						nil,
						"c_unik_gateway",
						"earthmoverunik"
					)
					card:set_edition({ negative = true }, true)
					card:add_to_deck()
					G.consumeables:emplace(card)
					return true
				end,
			}))
			if not SMODS.is_eternal(card) then
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
			end
			card.gone = true
		end
	end,
}