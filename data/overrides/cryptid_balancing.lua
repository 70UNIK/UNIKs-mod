--OIL LUMP
--Upcoming rework: multiplies values of jokers to the right by 1.15X. Values revert after 2 rounds, requiring you to "keep oiling" a joker if you want to keep its benefits.
SMODS.Joker:take_ownership("cry_oil_lamp", {
    immutable = true,
    rarity = 'cry_epic',
    config = { extra = { increase = 1.2, revert = 3 } },
	gameset_config = {
		modest = {disabled = true}
	},
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			key = "j_cry_oil_lamp_reworked",
			vars = { number_format(card.ability.extra.increase),number_format(card.ability.extra.revert) },
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							check = true
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase })
							local card6 = G.jokers.cards[i + 1]
							card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
							--How would it work?
							--{multiplier,rounds left}
							--{decrements by 1. If hits 0, then reverts values.}
							card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {card.ability.extra.increase,card.ability.extra.revert}

						end
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
			return {

			}
		end
	end,
}, true)

--TROFICAL SMOOTHER: multiples values of all owned jokers by 1.35X. Values of jokers revert after 4 rounds
SMODS.Joker:take_ownership("j_cry_tropical_smoothie", {
    config = { extra = {extra = 1.4, self_destruct = false, revert = 5}},
    loc_vars = function(self, info_queue, center)
		return { key = "j_cry_tropical_smoothie_reworked", vars = { number_format(center.ability.extra.extra),number_format(center.ability.extra.revert) } }
	end,
    gameset_config = {
		madness = { extra = {extra = 1.5, self_destruct = false, revert = 5} },
		modest = {disabled = true}
	},
    rarity = 'cry_epic',
    immutable = true,
    calculate = function(self, card, context)
        --too bad so sad
        if context.forcetrigger and not card.ability.extra.self_destruct then
            local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.manipulate(v, { value = card.ability.extra.extra })
						v.ability.cry_valuemanip_reset = v.ability.cry_valuemanip_reset or {}
						--How would it work?
						--{multiplier,rounds left}
						--{decrements by 1. If hits 0, then reverts values.}
						v.ability.cry_valuemanip_reset[#v.ability.cry_valuemanip_reset + 1] = {card.ability.extra.extra,card.ability.extra.revert - 1}
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
			return {

			}
        end
		if context.selling_self and not card.ability.extra.self_destruct and not context.repetition and not context.individual and not context.blueprint then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.manipulate(v, { value = card.ability.extra.extra })
						v.ability.cry_valuemanip_reset = v.ability.cry_valuemanip_reset or {}
						--How would it work?
						--{multiplier,rounds left}
						--{decrements by 1. If hits 0, then reverts values.}
						v.ability.cry_valuemanip_reset[#v.ability.cry_valuemanip_reset + 1] = {card.ability.extra.extra,card.ability.extra.revert - 1}
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

--JAWBUSTER:  1.5X values to adjacent jokers. (cannot be applied multiple times)
SMODS.Joker:take_ownership("j_cry_jawbreaker", {
    config = { extra = {increase = 1.6,self_destruct = false,revert = 5} },
    loc_vars = function(self, info_queue, center)
		return { key = "j_cry_jawbreaker_balanced", vars = { number_format(center.ability.extra.increase),number_format(center.ability.extra.revert) } }
	end,
    gameset_config = {
		madness = { extra = {increase = 2, self_destruct = false,revert = 5} },
		modest = {disabled = true}
	},
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
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) and not G.jokers.cards[i - 1].ability.jawbreakered then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
								local card6 = card2
								card6.ability.jawbreakered = true
								--jawbreakered would be a sticker that cannot be removed and just indicates that jawbreaker has already been used.
								-- card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
								-- --How would it work?
								-- --{multiplier,rounds left}
								-- --{decrements by 1. If hits 0, then reverts values.}
								-- card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {card.ability.extra.increase,card.ability.extra.revert - 1}
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) and not G.jokers.cards[i + 1].ability.jawbreakered then
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase })
							local card6 = G.jokers.cards[i + 1]
							card6.ability.jawbreakered = true
							-- card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
							-- --How would it work?
							-- --{multiplier,rounds left}
							-- --{decrements by 1. If hits 0, then reverts values.}
							-- card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {card.ability.extra.increase,card.ability.extra.revert - 1}
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
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) and not G.jokers.cards[i - 1].ability.jawbreakered then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
								local card6 = card2
								card6.ability.jawbreakered = true
								-- card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
								-- --How would it work?
								-- --{multiplier,rounds left}
								-- --{decrements by 1. If hits 0, then reverts values.}
								-- card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {card.ability.extra.increase,card.ability.extra.revert - 1}
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) and not G.jokers.cards[i + 1].ability.jawbreakered then
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = center.ability.extra.increase })
							local card6 = G.jokers.cards[i + 1]
							card6.ability.jawbreakered = true
							-- card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
							-- --How would it work?
							-- --{multiplier,rounds left}
							-- --{decrements by 1. If hits 0, then reverts values.}
							-- card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {card.ability.extra.increase,card.ability.extra.revert - 1}
						end
					end
				end
			end
            selfDestruction(card,"k_eaten_ex",G.C.FILTER)
			return {
				
			}
		end
	end,
}, true)


--CHUD is literally 2 brainstorms in 1
SMODS.Joker:take_ownership("j_cry_chad",{
    rarity = 'cry_epic',
	cost = 14,
}, true)
--canfas is legendary and relies on unique rarities
SMODS.Joker:take_ownership("j_cry_canvas",{
    rarity = 4,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		local num_retriggers = 0
		local blacklistedRarities = {1}
		num_retriggers = num_retriggers + center:jokerRaritiesDir(false,true,blacklistedRarities)
		if Card.get_gameset(center) == "modest" then
			num_retriggers = math.min(2,num_retriggers)
		end
		return { key = Cryptid.gameset_loc(self, { modest = "modest", mainline = "mainline" }),vars={num_retriggers} }
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker then
			local num_retriggers = 0
			local blacklistedRarities = {1}
			num_retriggers = num_retriggers + card:jokerRaritiesDir(false,true,blacklistedRarities)
			-- for i = 1, #G.jokers.cards do
			-- 	if
			-- 		card.T.x + card.T.w / 2 < G.jokers.cards[i].T.x + G.jokers.cards[i].T.w / 2
			-- 		and G.jokers.cards[i].config.center.rarity ~= 1
			-- 		and (G.jokers.cards[i].config.center.rarity ~= "cry_candy" or Card.get_gameset(card) ~= "modest")
			-- 	then
			-- 		num_retriggers = num_retriggers + 1
			-- 	end
			-- end
			if
				card.T
				and context.other_card.T
				and (card.T.x + card.T.w / 2 > context.other_card.T.x + context.other_card.T.w / 2)
			then
				return {
					message = localize("k_again_ex"),
					repetitions = Card.get_gameset(card) ~= "modest" and num_retriggers or math.min(2, num_retriggers),
					card = card,
				}
			end
		end
	end,
}, true)

function Card:jokerRaritiesDir(left,right,blacklistedrarities)
    if G.jokers and G.jokers.cards then
        local rarities = {}
		local index = -1
		for i=1, #G.jokers.cards do 
			if G.jokers.cards[i] == self then
				index = i
				break
			end
		end
		for i=1, #G.jokers.cards do
			local card = G.jokers.cards[i]
			local valid = true
			if i ~= index then
				if i < index and not left then
					valid = false
				end
				if i > index and not right then
					valid = false
				end
			else
				valid = false
			end
			if blacklistedrarities then
				for j = 1, #blacklistedrarities do
					if blacklistedrarities[j] == card.config.center.rarity then
						valid = false
					end
				end
			end
			for j = 1, #rarities do
				if rarities[j] == card.config.center.rarity then
					valid = false
				end
			end
			if valid then
				rarities[#rarities+1] = card.config.center.rarity
			end
		end
        return #rarities
    end
	return 0 
end

SMODS.Joker:take_ownership("j_cry_demicolon",{
    rarity = 4,
	cost = 20,
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
SMODS.Joker:take_ownership("j_cry_m",{
    config = {
		extra = {
			extra = 10,
			x_mult = 1,
		},
	},
}, true)
--Googol play card is X17.
-- SMODS.Joker:take_ownership("j_cry_googol_play",{
-- 	config = {
-- 		extra = {
-- 			Xmult = 17,
-- 			odds = 8,
-- 		},
-- 	},
-- }, true)
--WAAAAAAHHHH
-- SMODS.Joker:take_ownership("j_cry_waluigi",{
-- 	config = { extra = { Xmult = 1.8 } },
-- }, true)

--Nostalgic invisible Joker now STRIPS editions in mainline/modest, otherwise you can infinidupe negative jokers (I believe thats what roffle did)
SMODS.Joker:take_ownership("j_cry_oldinvisible",{
	loc_vars = function(self, info_queue, center)
		--copied from book of vengence
		local main_end

		if G.jokers and Card.get_gameset(card) ~= "madness" then
			for _, v in ipairs(G.jokers.cards) do
				if v.edition and v.edition.negative then
				main_end = {}
				localize {
					type = 'other',
					key = 'remove_negative',
					nodes = main_end
				}
				break
				end
			end
		end
		return { vars = { center.ability.extra },main_end = main_end and main_end[1] }
	end,
	calculate = function(self, card, context)

		if
			(
				context.selling_card
				and context.card.ability.set == "Joker"
				and not context.blueprint
				and not context.retrigger_joker
			) or context.forcetrigger
		then
			if card.ability.extra >= 3 then
				card.ability.extra = 0
				local eligibleJokers = {}
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].ability.name ~= card.ability.name and G.jokers.cards[i] ~= context.card then
						eligibleJokers[#eligibleJokers + 1] = G.jokers.cards[i]
					end
				end
				if #eligibleJokers > 0 then
					G.E_MANAGER:add_event(Event({
						func = function()
							local card2 = pseudorandom_element(eligibleJokers, pseudoseed("cry_oldinvis"))
							local strip_edition = card2.edition and card2.edition.negative
							local card3 = nil
							if Card.get_gameset(card3) == "madness" then
								card3 = copy_card(card2, nil, nil, nil, nil)
							else
								card3 = copy_card(card2, nil, nil, nil, strip_edition)
							end
							
							card3:add_to_deck()
							G.jokers:emplace(card3)
							return true
						end,
					}))
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_duplicated_ex") }
					)
					return nil, true
				else
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_no_other_jokers") }
					)
				end
				return
			else
				card.ability.extra = card.ability.extra + 1
				if card.ability.extra == 3 then
					local eval = function(card)
						return (card.ability.extra == 3)
					end
					juice_card_until(card, eval, true)
				end
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = card.ability.extra .. "/4",
						colour = G.C.FILTER,
					}),
				}
			end
		end
	end,
}, true)
--Nostalgic google play card will always copy 1 card in mainline and WILL strip edition in modest. Besides, its a much more controllable version of invisible Joker and an instantly usable version of Book of Vengence!
-- SMODS.Joker:take_ownership("j_cry_altgoogol",{
-- 	config = { copies = 1 },
-- 	gameset_config = {
-- 		modest = {
-- 			cost = 15,
-- 			copies = 1,
-- 		},
-- 		mainline = { copies = 1 },
-- 		madness = {
-- 			center = { blueprint_compat = true },
-- 			copies = 2,
-- 		},
-- 	},
-- 	loc_vars = function(self, info_queue, center)
-- 		--copied from book of vengence
-- 		local main_end

-- 		if G.jokers and Card.get_gameset(card) == "modest" then
-- 			for _, v in ipairs(G.jokers.cards) do
-- 				if v.edition and v.edition.negative then
-- 				main_end = {}
-- 				localize {
-- 					type = 'other',
-- 					key = 'remove_negative',
-- 					nodes = main_end
-- 				}
-- 				break
-- 				end
-- 			end
-- 		end
-- 		return { vars = { center.ability.copies } ,main_end = main_end and main_end[1]}
-- 	end,
-- }, true)

SMODS.Joker:take_ownership("j_cry_maximized",{
	loc_vars = function (self,info_queue,center)
		return {
			key = "j_cry_maximized_alt"
		}
	end,
}, true)

--Cotton candy only makes the joker on the right negative
SMODS.Joker:take_ownership("j_cry_cotton_candy",{
	loc_vars = function (self,info_queue,center)
		return {
			key = Cryptid.gameset_loc(self, {modest = "balanced", mainline = "balanced" })
		}
	end,
	calculate = function(self, card, context)
		if
			(context.selling_self and not context.retrigger_joker and not context.blueprint_card)
			or context.forcetrigger
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 and Card.get_gameset(card) == "madness" then
						G.jokers.cards[i - 1]:set_edition({ negative = true })
					end
					if i < #G.jokers.cards then
						G.jokers.cards[i + 1]:set_edition({ negative = true })
					end
				end
			end
			if context.forcetrigger then
				selfDestruction(card,"k_eaten_ex",G.C.FILTER)
				return {

				}
			end
			
		end
	end,
}, true)


--Nostalgic candy only provides +2 hand size.
SMODS.Joker:take_ownership("j_cry_oldcandy",{
	gameset_config = {
		modest = { extra = { hand_size = 1 } },
		mainline = { extra = {hand_size = 2}},
	},
}, true)

--Crustulum makes 30 rerolls fwee and has no chip bonus.
SMODS.Joker:take_ownership("j_cry_crustulum",{
	config = {
		extra = {
			chips = 0,
			chip_mod = 4,
			free_rerolls = 30,
		},
	},
	immutable = true,
	gameset_config = {
		modest = { extra = { free_rerolls = 16} ,center = { demicolon_compat = false, blueprint_compat = false}},
		mainline = { extra = {free_rerolls = 30},center = { demicolon_compat = false, blueprint_compat = false}},
	},
	loc_vars = function (self,info_queue,center)
		if Card.get_gameset(center) == "madness" then
			return {
				vars = {
					number_format(center.ability.extra.chips),
					number_format(center.ability.extra.chip_mod),
				},
			}
		else
			return {
				key = Cryptid.gameset_loc(self, {modest = "modest",mainline= "mainline" }),
				vars = {center.ability.extra.free_rerolls}
			}
		end
		
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint and Card.get_gameset(card) == "madness" then
			card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.chip_mod)
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				colour = G.C.CHIPS,
			})
			return nil, true
		end
		if context.joker_main and to_big(card.ability.extra.chips) > to_big(0) and Card.get_gameset(card) == "madness" then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
		if context.forcetrigger and Card.get_gameset(card) == "madness" then
			card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.chip_mod)
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		--This makes the reroll immediately after obtaining free because the game doesn't do that for some reason
		if Card.get_gameset(card) == "madness" then
			G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
			calculate_reroll_cost(true,true)
		else
			SMODS.change_free_rerolls(card.ability.extra.free_rerolls)
            calculate_reroll_cost(true,nil)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if Card.get_gameset(card) == "madness" then
			calculate_reroll_cost(true,true)
		else
			SMODS.change_free_rerolls(-card.ability.extra.free_rerolls)
            calculate_reroll_cost(true,nil)
		end
	end,
}, true)

function calculate_reroll_cost(skip_increment,madness)
	if not G.GAME.current_round.free_rerolls or G.GAME.current_round.free_rerolls < 0 then
		G.GAME.current_round.free_rerolls = 0
	end
	if (madness and next(find_joker("cry-crustulum"))) or G.GAME.current_round.free_rerolls > 0 then
		G.GAME.current_round.reroll_cost = 0
		return
	end
	if next(find_joker("cry-candybuttons")) then
		G.GAME.current_round.reroll_cost = 1
		return
	end
	if G.GAME.used_vouchers.v_cry_rerollexchange then
		G.GAME.current_round.reroll_cost = 2
		return
	end
	G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase or 0
	if not skip_increment then
		G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase
			+ (G.GAME.modifiers.cry_reroll_scaling or 1)
	end
	G.GAME.current_round.reroll_cost = (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost)
		+ G.GAME.current_round.reroll_cost_increase
end

--Tier 3 reroll voucher rework:
--Rerolls increase price by $1 every 3 rerolls.

--Compounding interest should increase by 1%.
--multiply fix
SMODS.Consumable:take_ownership("c_cry_multiply",{
use = function(self, card, area, copier)
	local cards = Cryptid.get_highlighted_cards({ G.jokers }, card, 1, 1, function(card)
		return not Card.no(card, "immutable", true)
	end)
	-- if cards[1] and not cards[1].config.cry_multiply then
	-- 	cards[1].config.cry_multiply = 1
	-- end
	-- cards[1].config.cry_multiply = cards[1].config.cry_multiply * 2
	Cryptid.manipulate(cards[1], { value = 2 })
	local card6 = cards[1]
	card6.ability.cry_valuemanip_reset = card6.ability.cry_valuemanip_reset or {}
	--How would it work?
	--{multiplier,rounds left}
	--{decrements by 1. If hits 0, then reverts values.}
	card6.ability.cry_valuemanip_reset[#card6.ability.cry_valuemanip_reset + 1] = {2,0}

end,
}, true)





--ban hook, its too overpowered for mainline cause you can hook something like oil lamp to yokana and it will transform into a fucking menace.
--hook rework: after 4 forcetriggers (on that joker), remove hook. 
SMODS.Consumable:take_ownership("c_cry_hook",{
	gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = false },
		madness = { disabled = false },
		experimental = { disabled = false },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "cry_hooked_balanced", set = "Other", vars = { "hooked Joker" ,5} }
	end,
	use = function(self, card, area, copier)
		local jokers = Cryptid.get_highlighted_cards({ G.jokers }, card, 2, 2)
		local card1 = jokers[1]
		local card2 = jokers[2]
		if card1 and card2 then
			if card1.ability.cry_hooked then
				for _, v in ipairs(G.jokers.cards) do
					if v.sort_id == card1.ability.cry_hook_id then
						v.ability.cry_hooked = false
					end
				end
			end
			if card2.ability.cry_hooked then
				for _, v in ipairs(G.jokers.cards) do
					if v.sort_id == card2.ability.cry_hook_id then
						v.ability.cry_hooked = false
					end
				end
			end
			card1.ability.cry_hooked = true
			card2.ability.cry_hooked = true
			card1.ability.cry_hook_limit = 5
			card2.ability.cry_hook_limit = 5
			card1.ability.cry_hook_id = card2.sort_id
			card2.ability.cry_hook_id = card1.sort_id
		end
	end,
	}, true)

SMODS.Sticker:take_ownership("cry_hooked", {
	loc_vars = function(self, info_queue, card)
		local var
		local limit
		if not card or not card.ability.cry_hook_id then
			var = "[" .. localize("k_joker") .. "]"
		else
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].sort_id == card.ability.cry_hook_id then
					var = localize({ type = "name_text", set = "Joker", key = G.jokers.cards[i].config.center_key })
				end
			end
			var = var or ("[no joker found - " .. (card.ability.cry_hook_id or "nil") .. "]")
		end
		limit = card.ability.cry_hook_limit or "[nope]"
		return { key = 'cry_hooked_balanced', vars = { var or "hooked Joker", limit } }
	end,
	calculate = function(self, card, context)
		if
			context.other_card == card
			and context.post_trigger
			and not context.forcetrigger
			and not context.other_context.forcetrigger
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].sort_id == card.ability.cry_hook_id then
					local results = Cryptid.forcetrigger(G.jokers.cards[i], context)
					card.ability.cry_hook_limit = card.ability.cry_hook_limit or 5
						
					card.ability.cry_hook_limit = card.ability.cry_hook_limit - 1

					if G.jokers and card.ability.cry_hook_limit <= 0 then
						for g,w in pairs(G.jokers.cards) do
							if
								(w.ability.cry_hook_id == card.sort_id)
								or (w.sort_id == card.ability.cry_hook_id)
							then
								w.ability.cry_hooked = false
								w.ability.cry_hook_id = nil
							end
						end
						card.ability.cry_hooked = nil
						card.ability.cry_hooked = nil
					end
					if results and results.jokers then
						
						return results.jokers
					end
				end
			end
		end
	end,
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

--Nerfing pirate dagger to exactly the same as xmult
SMODS.Joker:take_ownership("j_cry_pirate_dagger",{
	loc_vars = function (self,info_queue,center)
		return {key = "j_cry_pirate_dagger_balanced",vars = { number_format(center.ability.extra.x_chips) }}
	end,
calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				x_chips = lenient_bignum(card.ability.extra.x_chips),
			}
		end
		local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if
			context.setting_blind
			and not (context.blueprint_card or self).getting_sliced
			and my_pos
			and G.jokers.cards[my_pos + 1]
			and not G.jokers.cards[my_pos + 1].ability.eternal
			and not G.jokers.cards[my_pos + 1].getting_sliced
		then
			local sliced_card = G.jokers.cards[my_pos + 1]
			sliced_card.getting_sliced = true
			if sliced_card.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card.ability.extra.x_chips =
						lenient_bignum(to_big(card.ability.extra.x_chips) + sliced_card.sell_cost * 0.2)
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = {
						number_format(
							lenient_bignum(to_big(card.ability.extra.x_chips) + 0.2 * sliced_card.sell_cost)
						),
					},
				}),
				colour = G.C.CHIPS,
				no_juice = true,
			})
			return nil, true
		end
		if context.forcetrigger and my_pos and G.jokers.cards[my_pos + 1] then
			local sliced_card = G.jokers.cards[my_pos + 1]
			sliced_card.getting_sliced = true
			if sliced_card.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card.ability.extra.x_chips =
						lenient_bignum(to_big(card.ability.extra.x_chips) + sliced_card.sell_cost * 0.2)
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				x_chips = lenient_bignum(card.ability.extra.x_chips),
			}
		end
	end,
},true)

--All non exotic emulters (except happy house and night) should be immutable. Cry about it, otherwise it becomes too OP with value manip.
SMODS.Joker:take_ownership("j_cry_universe",{
    config = { extra = { emult = 1.1 } },
    gameset_config = {
		madness = { extra = { emult = 1.2 }, immutable = false },
	},
    immutable = true,
}, true)

--reduce values of stardust to x1.5 (especially since its a fucking common)
SMODS.Joker:take_ownership("j_cry_stardust",{
    config = { extra = { xmult = 1.5 } },
    gameset_config = {
		madness = {extra = { xmult = 2 } },
	},
}, true)

-- --eflame should be x0.1 or x0.12
-- SMODS.Joker:take_ownership("j_cry_eternalflame",{
-- 	config = {
-- 		extra = {
-- 			extra = 0.1,
-- 			x_mult = 1,
-- 		},
-- 	},
-- }, true)

--garden of forking paths must be uncommon, its pretty bad for a rare.
SMODS.Joker:take_ownership("j_cry_gardenfork",{
	rarity = 2,
}, true)

--fuck the filler
SMODS.Joker:take_ownership("j_cry_filler",{
    gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = { disabled = true },
		experimental = { disabled = true },
	},
}, true)

--fuck astralbottle. outside of experimental or madness, its a CURSED joker.
SMODS.Joker:take_ownership("j_cry_astral_bottle",{
    gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = {center = {  rarity = 2} },
		experimental = {center = {  rarity = 2 }},
	},
}, true)

--Override perkeo, copy+paste and chambered to not work on Pointer. If pointer is somehow duped inside consumables. self destruct and create a SOUL in its place.

SMODS.Consumable:take_ownership("c_cry_pointer",{
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
		return{
			key = Cryptid.gameset_loc(self, {modest = "no_dupe", mainline = "no_dupe"}), 
		}
	end,
}, true)

--starfruit should suicide itself if force triggered, starts at a much more reasonable ^1.5 emult and is immutable. Oh and it can be autocannibal food
SMODS.Joker:take_ownership("j_cry_starfruit",{
	config = { emult = 1.5, emult_mod = 0.1 },
	immutable = true,
	loc_vars = function(self, info_queue, center)
		local key = 'j_cry_starfruit'
		if center.ability.unik_depleted then
			key = 'j_cry_starfruit_depleted'
		end
		return {
			key = key,
			vars = {
				number_format(center.ability.emult),
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
			card.ability.emult = card.ability.emult - card.ability.emult_mod
			if (to_number(card.ability.emult) <= 1.00000001 and not card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			elseif (to_number(card.ability.emult) <= 0.00000001 and card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			else
				return {
					e_mult = lenient_bignum(card.ability.emult),
					colour = G.C.DARK_EDITION,
				}
			end
		end
		if context.reroll_shop then
			card.ability.emult = card.ability.emult - card.ability.emult_mod
			--floating point precision can kiss my ass istg
			if (to_number(card.ability.emult) <= 1.00000001 and not card.ability.unik_depleted) or (to_number(card.ability.emult) <= 0.00000001 and card.ability.unik_depleted) then
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

function Card:getLeftmostJokerType(rarity,edition)
	if rarity then
		if type(rarity) == "table" then
			for i,v in pairs(rarity) do
				for j,w in pairs(G.jokers.cards) do
					if w.config.center.rarity == v then
						if w == self then
							return true
						else
							return false
						end
					end
				end
			end
		else
			for j,w in pairs(G.jokers.cards) do
				if w.config.center.rarity == rarity then
					if w == self then
						return true
					else
						return false
					end
				end
			end
		end
		
	end
	if edition then
		if type(edition) == "table" then
			for i,v in pairs(edition) do
				for j,w in pairs(G.jokers.cards) do
					if Cryptid.safe_get(w, "edition", v) then
						if w == self then
							return true
						else
							return false
						end
					end
				end
			end
		else
			for j,w in pairs(G.jokers.cards) do
				if Cryptid.safe_get(w, "edition", edition) then
					if w == self then
						return true
					else
						return false
					end
				end
			end
		end
	end
	return false
end

Cryptid.misprintize_value_blacklist["cry_valuemanip_reset"] = false