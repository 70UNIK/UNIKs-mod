--Various overrides for mainline balance purpose. Mainline should be still powerful, but not too gamebreaking outside of exotics (Within reason)
--Oil lamp: Immutable & instead adds +0.2x values
--Tropical smoothie: Immutable and instead adds +0.5x values
--Jawbreaker: Immutable and instead adds +1x values
--unregistered hypercam should be rare (put some blueprints and chads and you have almanac levels of scoring)

--OIL LUMP
SMODS.Joker:take_ownership("cry_oil_lamp", {
    immutable = true,
    rarity = 'cry_epic',
    config = { extra = { increase = 1.1 } },
    -- calculate = function(self, card, context)
	-- 	if
	-- 		(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
	-- 		or context.forcetrigger
	-- 	then
	-- 		local check = false
	-- 		for i = 1, #G.jokers.cards do
	-- 			if G.jokers.cards[i] == card then
	-- 				if i < #G.jokers.cards then
	-- 					if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
	-- 						check = true
	-- 						Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(cards)
	-- 							-- Cryptid.misprintize(
	-- 							-- 	cards,
	-- 							-- 	{ min = card.ability.extra.increase, max = card.ability.extra.increase },
	-- 							-- 	nil,
	-- 							-- 	true
	-- 							-- )
    --                             --LOL DEAL WITH ADDITION
    --                             Cryptid.misprintize(cards, { min = card.ability.extra.increase, max = card.ability.extra.increase}, nil, true, "+")
	-- 						end)
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 		if check then
	-- 			card_eval_status_text(
	-- 				card,
	-- 				"extra",
	-- 				nil,
	-- 				nil,
	-- 				nil,
	-- 				{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
	-- 			)
	-- 		end
	-- 	end
	-- end,

}, true)

--TROFICAL SMOOTHER
SMODS.Joker:take_ownership("j_cry_tropical_smoothie", {
    config = { extra = {extra = 1.3, self_destruct = false}},
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.extra) } }
	end,
    rarity = 'cry_epic',
    immutable = true,
    calculate = function(self, card, context)
        --too bad so sad
        if context.forcetrigger and not card.ability.extra.self_destruct then
            local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.with_deck_effects(v, function(cards)
                            Cryptid.misprintize(cards, { min = card.ability.extra.extra, max = card.ability.extra.extra }, nil, true)
						end)
						check = true
					end
				end
			end
            --dont try to repeat this! Oil lamp exists for a reason.
			if check then
                card.ability.extra.self_destruct = true
				-- card_eval_status_text(
				-- 	card,
				-- 	"extra",
				-- 	nil,
				-- 	nil,
				-- 	nil,
				-- 	{ message = localize(), colour = G.C.GREEN }
				-- )
                selfDestruction(card,"k_upgrade_ex",G.C.GREEN)
			end
        end
		if context.selling_self and not card.ability.extra.self_destruct and not context.repetition and not context.individual and not context.blueprint then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.with_deck_effects(v, function(cards)
                            Cryptid.misprintize(cards, { min = card.ability.extra.extra, max = card.ability.extra.extra }, nil, true)
						end)
						check = true
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end
	end,
}, true)

--JAWBUSTER
SMODS.Joker:take_ownership("j_cry_jawbreaker", {
    config = { extra = {increase = 1.6,self_destruct = false} },
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.increase) } }
	end,
    immutable = true,
    calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and G.GAME.blind.boss
			and not context.blueprint_card
			and not context.retrigger_joker
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
				end
			end
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
            card.ability.extra.self_destruct = true
			return {
				message = localize("k_eaten_ex"),
				colour = G.C.FILTER,
			}
		end
		if context.forcetrigger and not card.ability.extra.self_destruct then
            card.ability.extra.self_destruct = true
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(card)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
				end
			end
            selfDestruction(card,"k_eaten_ex",G.C.FILTER)
		end
	end,
}, true)

--register hypercom
SMODS.Joker:take_ownership("j_mf_unregisteredhypercam",{
    rarity = 3
}, true)

--CHUD is literally 2 brainstorms in 1
SMODS.Joker:take_ownership("j_cry_chad",{
    rarity = 'cry_epic'
}, true)
--canfas
SMODS.Joker:take_ownership("j_cry_canvas",{
    rarity = 4
}, true)
SMODS.Joker:take_ownership("j_cry_demicolon",{
    rarity = 4
}, true)
--Loopy fix
SMODS.Joker:take_ownership("j_cry_loopy",{
    calculate = function(self, card, context)
		if
			context.selling_card
			and context.card:is_jolly()
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.extra.retrigger = math.min((card.ability.extra.retrigger + 1), card.ability.immutable.limit)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.GREEN,
				}),
			}
		end
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and context.other_card ~= self
			and card.ability.extra.retrigger ~= 0
		then
			return {
				message = localize("k_again_ex"),
				colour = G.C.GREEN,
				repetitions = math.min(card.ability.extra.retrigger, card.ability.immutable.limit),
				card = card,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.retrigger = 0
			 return {
				message = localize("k_reset"),
				card = card,
				colour = G.C.FILTER,
            }
		end
	end,
}, true)
--small m becomes X6
SMODS.Joker:take_ownership("j_cry_m",{
    config = {
		extra = {
			extra = 6,
			x_mult = 1,
		},
	},
}, true)
--Googol play card is much rarer and has a 1xe100 chance of self destructing to avoid rig abuse
SMODS.Joker:take_ownership("j_cry_googol_play",{
	config = {
		extra = {
			Xmult = 1e100,
			odds = 16,
			oddsDestruction = 1e100,
		},
	},
	gameset_config = {
		modest = { extra = { Xmult = 9, odds = 8, oddsDestruction = 1e100 } },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
				number_format(card.ability.extra.Xmult),
				math.min(cry_prob(card.ability.cry_prob, card.ability.extra.oddsDestruction, card.ability.cry_rigged) or 1,1),
				card.ability.extra.oddsDestruction,
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.joker_main
			and pseudorandom("cry_googol_play")
				< cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged) / card.ability.extra.odds
		then
			if pseudorandom("no_rigging_free_emult_your_way_out_muthafucker")
				< math.min(cry_prob(card.ability.cry_prob, card.ability.extra.oddsDestruction, card.ability.cry_rigged) or 1,1) / card.ability.extra.oddsDestruction then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						selfDestruction_noMessage(card,false)
						return true
					end,
				}))
					
			end
			
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					selfDestruction_noMessage(card,false)
					return true
				end,
			}))
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
}, true)
--WAAAAAAHHHH
SMODS.Joker:take_ownership("j_cry_waluigi",{
	config = { extra = { Xmult = 2 } },
}, true)

--Properly making depleted jokers work
--Clicked cookie
SMODS.Joker:take_ownership("j_cry_clicked_cookie",{
	config = {
		extra = {
			chips = 200,
			chip_mod = 1,
			depleted_threshold = -200,
		},
	},
	pools = { ["autocannibalism_food"] = true },
	loc_vars = function(self, info_queue, center)
		local key = 'j_cry_clicked_cookie'
		local sign = "+"
		if center.ability.unik_depleted then
			key = 'j_cry_clicked_cookie_depleted'
		end
		if lenient_bignum(center.ability.extra.chips) <= lenient_bignum(0) then
			sign = ""
		end 
		return {
			key = key,
			vars = {
				sign,
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.chip_mod),
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			local sign = "+"
			if lenient_bignum(card.ability.extra.chips) <= lenient_bignum(0) then
				sign = ""
			end 
			return {
				card = card,
				chip_mod = lenient_bignum(card.ability.extra.chips),
				message = sign .. number_format(card.ability.extra.chips),
				colour = G.C.CHIPS,
			}
		end
		if context.cry_press then
			if (not card.ability.unik_depleted and to_big(card.ability.extra.chips) - to_big(card.ability.extra.chip_mod) <= to_big(0))
				or (card.ability.unik_depleted and to_big(card.ability.extra.chips) - to_big(card.ability.extra.chip_mod) <= to_big(card.ability.extra.depleted_threshold))
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
				card.ability.extra.chips =
					lenient_bignum(to_big(card.ability.extra.chips) - card.ability.extra.chip_mod)
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = "-" .. number_format(card.ability.extra.chip_mod), colour = G.C.CHIPS }
				)
			end
		end
	end,
}, true)
--Ice cream
SMODS.Joker:take_ownership("j_ice_cream",{
	config = {
		extra = {chips = 100, chip_mod = 5,depleted_threshold = -100}
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
				number_format(center.ability.extra.chip_mod),
				sign,
				number_format(center.ability.extra.depleted_threshold),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			if (card.ability.unik_depleted and card.ability.extra.chips - card.ability.extra.chip_mod < card.ability.extra.depleted_threshold) or (not card.ability.unik_depleted and card.ability.extra.chips - card.ability.extra.chip_mod <= 0) then
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
				card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_mod
				return {
					message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_mod}},
					colour = G.C.CHIPS
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
				card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.extra
				return {
					message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.extra}},
					colour = G.C.MULT
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
					colour = G.C.FILTER
				}
			else
				card.ability.extra.Xmult = card.ability.extra.Xmult -  card.ability.extra.extra
				return {
					delay = 0.2,
					card = card,
					message = localize{type='variable',key='a_xmult_minus',vars={ card.ability.extra.extra}},
					colour = G.C.RED
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
				card.ability.extra.h_size = card.ability.extra.h_size - card.ability.extra.h_mod
				G.hand:change_size(- card.ability.extra.h_mod)
				return {
					message = localize{type='variable',key='a_handsize_minus',vars={card.ability.extra.h_mod}},
					colour = G.C.FILTER
				}
			end
		end
	end
}, true)
--TODO: lolipop, nachos

--Cube pools

--ban hook, its too overpowered for mainline
SMODS.Consumable:take_ownership("c_cry_hook",{
	gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = { disabled = false },
		experimental = { disabled = false },
	},
	}, true)

--Nerf membership cards, its way to powerful as its unconditional essentially
SMODS.Joker:take_ownership("j_cry_membershipcardtwo",{
	config = {
		extra = { chips = 1 },
		immutable = { chips_mod = 8 },
	},
	gameset_config = {
		modest = {
			cost = 20,
			center = { rarity = 4 },
			immutable = { chips_mod = 16 },
		},
	},
}, true)
--essentially a free X31 mult. OP, but eventually becomes a handicap into endless
SMODS.Joker:take_ownership("j_cry_membershipcard",{
	config = { extra = { Xmult_mod = 0.001 } },
}, true)




