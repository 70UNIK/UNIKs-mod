-- --OIL LUMP
-- Now fixed:

-- Based on:
-- https://github.com/SpectralPack/Cryptid/tree/99df47a6f6c769ab7f1fdf81ebf3575f6bf2f1e3
SMODS.Joker:take_ownership("j_cry_oil_lamp", {
	immutable = true,
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
							if G.jokers.cards[i + 1].ability.value_manip2 then
								Cryptid.manipulate(G.jokers.cards[i + 1], { value = 1/G.jokers.cards[i + 1].ability.value_manip2})
							end
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase })
							G.jokers.cards[i + 1].ability.value_manip2 = card.ability.extra.increase
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
		end
	end,
}, true)

--TROFICAL SMOOTHER: multiples values of all owned jokers by 1.25X. Values of jokers revert after 5 rounds
SMODS.Joker:take_ownership("j_cry_tropical_smoothie", {
    immutable = true,
    calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger and not card.ability.drank_smoothie then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						if v.ability.value_manip2 then
							Cryptid.manipulate(v, { value = 1/v.ability.value_manip2 })
						end
						Cryptid.manipulate(v, { value = card.ability.extra })
						v.ability.value_manip2 = card.ability.extra
						check = true
					end
				end
			end
			if check and not context.forcetrigger then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
			if context.forcetrigger then
				selfDestruction(card,"k_drank_ex",G.C.FILTER)
				card.ability.drank_smoothie = true
				return {
					
				}
			end
		end
	end,
}, true)






--JAWBUSTER:  permanent 1.4X values to adjacent jokers. (cannot be applied multiple times)
SMODS.Joker:take_ownership("j_cry_jawbreaker", {
    config = { extra = {increase = 1.75,self_destruct = false,revert = 5} },
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
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							local card6 = G.jokers.cards[i - 1]
							if G.jokers.cards[i - 1].ability.value_manip2 then
								Cryptid.manipulate(G.jokers.cards[i - 1], {value = 1/G.jokers.cards[i - 1].ability.value_manip2})
							end
							Cryptid.manipulate(card6, { value = card.ability.extra.increase })
							card6.ability.value_manip2 = card.ability.extra.increase
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							local card6 = G.jokers.cards[i + 1]
							if G.jokers.cards[i + 1].ability.value_manip2 then
								Cryptid.manipulate(G.jokers.cards[i + 1], {value = 1/G.jokers.cards[i + 1].ability.value_manip2})
							end
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase })
							card6.ability.value_manip2 = card.ability.extra.increase
							
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
							local card6 = G.jokers.cards[i - 1]
							if card6.ability.value_manip2 then
								Cryptid.manipulate(card6, {value = 1/card6.ability.value_manip2})
							end
							Cryptid.manipulate(card6, { value = card.ability.extra.increase })
							card6.ability.value_manip2 = card.ability.extra.increase
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							local card6 = G.jokers.cards[i + 1]
							if card6.ability.value_manip2 then
								Cryptid.manipulate(card6, {value = 1/card6.ability.value_manip2})
							end
							Cryptid.manipulate(card6, { value = card.ability.extra.increase })
							card6.ability.value_manip2 = card.ability.extra.increase
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

-- --After a test run with gemini and primus on wormhole, I can conclude that it NEEDS a bit of a nerf, something like capping at X10.

SMODS.Joker:take_ownership("j_cry_gemino", {
	config = {extra = {multiplier = 1.5}},
	immutable = true,
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
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
			key = 'j_cry_gemini_reworked',
			vars = {card.ability.extra.multiplier,card.ability.extra.multiplier^7}
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			other_joker = G.jokers.cards[1]
			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
				if not other_joker.ability.cry_gemini_times or other_joker.ability.cry_gemini_times < 7 then
					card.ability.blueprint_compat = "compatible"
				else
					card.ability.blueprint_compat = "incompatible"
				end
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	calculate = function(self, card2, context)
		if (context.end_of_round and not context.repetition and not context.individual) or context.forcetrigger then
			local check = false
			local card = G.jokers.cards[1]
			card.ability.cry_gemini_times = card.ability.cry_gemini_times or 0
			if card.ability.cry_gemini_times < 7 then
				if not Card.no(G.jokers.cards[1], "immutable", true) then
					Cryptid.manipulate(G.jokers.cards[1], { value = card2.ability.extra.multiplier })
					check = true
				end
				card.ability.cry_gemini_times = card.ability.cry_gemini_times + 1
				if check then
					card_eval_status_text(
						context.blueprint_card or card2,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
					)
				end
			end
			return nil, true
		end
	end,
}, true)

--CHUD is literally 2 brainstorms in 1
SMODS.Joker:take_ownership("j_cry_chad",{
    rarity = 'cry_epic',
	cost = 16,
}, true)
--canfas is legendary and relies on unique rarities
SMODS.Joker:take_ownership("j_cry_canvas",{
    rarity = 4,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		local num_retriggers = 0
		local blacklistedRarities = {1}
		local max_retriggers = 5
		num_retriggers = num_retriggers + center:jokerRaritiesDir(false,true,blacklistedRarities)
		if Card.get_gameset(center) == "modest" then
			num_retriggers = math.min(2,num_retriggers)
			max_retriggers = 2
		end
		return { key = Cryptid.gameset_loc(self, { modest = "modest", mainline = "mainline" }),vars={num_retriggers,max_retriggers} }
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
					repetitions = Card.get_gameset(card) ~= "modest" and math.min(5,num_retriggers) or math.min(2, num_retriggers),
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
		info_queue[#info_queue + 1] = { key = "cry_hooked_balanced", set = "Other", vars = { "hooked Joker" ,4} }
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
			card1.ability.cry_hook_limit = 4
			card2.ability.cry_hook_limit = 4
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
					card.ability.cry_hook_limit = card.ability.cry_hook_limit or 4
						
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
			and not SMODS.is_eternal(G.jokers.cards[my_pos + 1])
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
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_chips",
				scalar_table = {
					sell_cost = sliced_card.sell_cost * 0.2,
				},
				scalar_value = "sell_cost",
				message_key = "a_xchips",
				message_colour = G.C.BLUE,
				force_full_val = true,
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
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_chips",
				scalar_table = {
					sell_cost = sliced_card.sell_cost * 0.2,
				},
				scalar_value = "sell_cost",
				message_key = "a_xchips",
				message_colour = G.C.BLUE,
				 force_full_val = true,
			})
			return {
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
			}
		end
	end,
},true)

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

--actually making astral bottle good
SMODS.Joker:take_ownership("j_cry_astral_bottle",{
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return{
			key = "j_cry_astral_in_a_bottle_but_not_cursed",vars = {}
		}
	end,
	calculate = function(self, card, context)
		if (context.selling_self and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].debuff and not G.jokers.cards[i].edition then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers >= 1 then
				local chosen_joker = pseudorandom_element(jokers, pseudoseed("astral_bottle"))
				chosen_joker:set_edition({ cry_astral = true })
				chosen_joker.ability.unik_limited_edition = true;
				chosen_joker.ability.limited_edition_tally = G.GAME.unik_limited_edition_rounds
				return nil, true
			else
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_no_other_jokers") })
			end
		end
	end,
}, true)

--Override perkeo, copy+paste and chambered to not work on Pointer. If pointer is somehow duped inside consumables. self destruct and create a SOUL in its place.

SMODS.Consumable:take_ownership("c_cry_pointer",{
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
		return{
			key = 'c_cry_pointer_no_dupe'
		}
	end,
	use = function(self, card, area, copier)
		-- dont copy point
		-- if not card.ability.cry_multiuse or to_big(card.ability.cry_multiuse) <= to_big(1) then
		-- 	G.GAME.CODE_DESTROY_CARD = copy_card(card)
		-- 	G.consumeables:emplace(G.GAME.CODE_DESTROY_CARD)
		-- else
		-- 	card.ability.cry_multiuse = card.ability.cry_multiuse + 1
		-- end
		G.GAME.USING_CODE = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.USING_POINTER = true
				G.FUNCS.overlay_menu({ definition = create_UIBox_your_collection() })
				return true
			end,
		}))
		G.GAME.POINTER_SUBMENU = nil
	end,
}, true)


--starfruit should suicide itself if force triggered, starts at a much more reasonable ^1.5 emult and is immutable. Oh and it can be autocannibal food
SMODS.Joker:take_ownership("j_cry_starfruit",{
	config = { emult = 0.5, emult_mod = 0.1, immutable = {base_emult = 1} },
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

SMODS.Joker:take_ownership("j_cry_magnet",{
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.money),
				number_format(center.ability.extra.multiplier - (Card.get_gameset(card) == "modest" and 1 or 0)),
				number_format(center.ability.extra.slots),
			},
		}
	end,
}, true)

--Notebook: Caps at 6 slots.
SMODS.Joker:take_ownership("j_cry_notebook",{
	config = {
		extra = {
			add = 1,
			odds = 7,
			jollies = 4,
			check = true,
			active = "Active",
			inactive = "",
		},
		immutable = {
			slots = 0,
			max_slots = 6,
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		local num, denom =
			SMODS.get_probability_vars(card, 1, card and card.ability.extra.odds or self.config.extra.odds)
		return {
			key = "j_cry_notebook_balanced",
			vars = {
				num,
				denom,
				number_format(card.ability.immutable.slots),
				number_format(card.ability.extra.active),
				number_format(card.ability.extra.jollies),
				number_format(card.ability.extra.add),
				number_format(card.ability.immutable.max_slots),
			},
		}
	end,
}, true)

SMODS.Edition:take_ownership("e_cry_astral",{
	no_pointer = true,
	no_code = true,
}, true)

SMODS.Edition:take_ownership("e_negative",{
	no_pointer = true,
	no_code = true,
}, true)

SMODS.Edition:take_ownership("e_cry_glass",{
	config = { x_mult = 3, prob = 1, odds = 8, trigger = nil },
	loc_vars = function(self, info_queue, card)
		local prob = 1
		local odds = 8
		local new_numerator, new_denominator = SMODS.get_probability_vars(self, self.config.prob,self.config.odds, 'cry_fragile_destroy')
		return {
			key = 'e_cry_fragile_fixed',
			vars = {
				new_numerator,
				new_denominator,
				card and card.edition and card.edition.x_mult or self.config.x_mult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.edition and context.cardarea == G.jokers and card.config.trigger then
			return { x_mult = card and card.edition and card.edition.x_mult or self.config.x_mult }
		end

		if
			context.cardarea == G.jokers
			and context.post_trigger 
			and not context.other_context.fixed_probability and not context.other_context.fix_probability and not context.other_context.mod_probability
			and context.other_card == card --animation-wise this looks weird sometimes
		then
			if
				not SMODS.is_eternal(card)
				and SMODS.pseudorandom_probability(self, pseudoseed('cry_fragile_destroy'), self.config.prob,self.config.odds, 'cry_fragile_destroy') 
			then
				card.ability.unik_destroyed_mid_scoring = true
				-- this event call might need to be pushed later to make more sense
				G.E_MANAGER:add_event(Event({
				func = function()
					card.states.drag.is = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							card.ability.no_score = true
							card.debuff = true
							G.jokers:remove_card(card)
							card:shatter()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			end
		end
		if context.main_scoring and context.cardarea == G.play then
			if
				not SMODS.is_eternal(card)
				and SMODS.pseudorandom_probability(self, pseudoseed('cry_fragile_destroy'), self.config.prob,self.config.odds, 'cry_fragile_destroy') 
			then
				card.config.will_shatter = true
			end
			return { x_mult = self.config.x_mult }
		end

		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end

		if context.destroy_card and context.destroy_card == card and card.config.will_shatter then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.states.drag.is = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:shatter()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return { remove = true }
		end
	end,
}, true)
--M stack, because I created a broken run with this, I have to amend it to have increasing sell reqs, like 2 retriggers outclasses Exposed, 3 outclasses mask and NSNM and 4 is insane. 6 is beyond so its capped at such.

SMODS.Joker:take_ownership("j_cry_mstack",{
	config = {
		extra = {
			sell = 0,
			sell_req = 3,
			retriggers = 1,
			check = false,
		},
		immutable = {
			req_increase = 1.75,
			max_retriggers = 6,
		},
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			key = 'j_cry_mstack_balanced',
			vars = {
				number_format(math.min(center.ability.extra.retriggers, center.ability.immutable.max_retriggers)),
				number_format(center.ability.extra.sell_req),
				number_format(center.ability.extra.sell),
				number_format(center.ability.immutable.req_increase),
				number_format(center.ability.immutable.max_retriggers),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.extra.retriggers, card.ability.immutable.max_retriggers)
					),
					card = card,
				}
			end
		end

		if
			context.selling_card
			and context.card:is_jolly()
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.extra.check = true
			if to_big(card.ability.extra.sell) + 1 >= to_big(card.ability.extra.sell_req) then
				if not context.blueprint or context.retrigger_joker then
					card.ability.extra.retriggers = lenient_bignum(to_big(card.ability.extra.retriggers) + 1)
					card.ability.extra.sell_req = math.ceil(card.ability.extra.sell_req * card.ability.immutable.req_increase)
				end
				card.ability.extra.sell = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.FILTER,
					}),
				}
			else
				card.ability.extra.sell = card.ability.extra.sell + 1
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = number_format(card.ability.extra.sell) .. "/" .. number_format(
							card.ability.extra.sell_req
						),
						colour = G.C.FILTER,
					}),
				}
			end
		end
	end,
}, true)

--Speculo:
--create negative niko copies of up to 3 random unique jokers.
SMODS.Joker:take_ownership("j_cry_speculo",{
	config = {
		extra = {
			jokers = 3,
		},
	},
	immutable = true,
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		if not center.ability.niko then
			info_queue[#info_queue + 1] = { set = "Other", key = "unik_niko" }
		end
		return {
			key = 'j_cry_speculo_balanced',
			vars = {
				center.ability.extra.jokers;
			}
		}
	end,
	calculate = function(self, card, context)
		if context.ending_shop or context.forcetrigger then
			for z = 1, card.ability.extra.jokers do
				local eligibleJokers = {}
				for i = 1, #G.jokers.cards do
					if not G.jokers.cards[i].ability.spawned_from_speculo and G.jokers.cards[i].ability.name ~= card.ability.name and G.jokers.cards[i].ability.set == "Joker" then
						eligibleJokers[#eligibleJokers + 1] = G.jokers.cards[i]
					end
				end
				if #eligibleJokers > 0 then
					G.E_MANAGER:add_event(Event({
						func = function()
							local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed("cry_speculo")), nil)
							card:set_edition({ negative = true }, true)
							card:add_to_deck()
							card.ability.unik_niko = true
							card.ability.spawned_from_speculo = true
							G.jokers:emplace(card)
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
					
				end
			end
			return
		end
	end,
}, true)
--Ace auilibrium: jokers are not negative  and require room.
SMODS.Joker:take_ownership("j_cry_equilib",{
	loc_vars = function(self, info_queue, center)
		local joker_generated = "???"
		if G.GAME.aequilibriumkey and G.GAME.aequilibriumkey > 1 then
			joker_generated = localize({
				type = "name_text",
				set = "Joker",
				key = G.P_CENTER_POOLS["Joker"][math.floor(G.GAME.aequilibriumkey or 1) - 1].key,
			})
		end
		return { key = 'j_cry_equilib_balanced',vars = { math.floor(math.min(25, center.ability.extra.jokers)), joker_generated } }
	end,
	--lready there but crash fix
	calculate = function(self, card, context)
		if
			(context.cardarea == G.jokers and context.before and not context.retrigger_joker) or context.forcetrigger
		then
			for i = 1, math.floor(math.min(25, card.ability.extra.jokers)) do
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
					local newcard = create_card("Joker", G.jokers, nil, nil, nil, nil, nil)
					newcard:add_to_deck()
					G.jokers:emplace(newcard)
					G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				end
			end
			G.GAME.joker_buffer = 0
			return nil, true
		end
	end,
}, true)

--Google play card, yes otherwise X10 mult is OK, but thing is, it outclasses HUGE. So it should be X4 Mult with a chance of X100.


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

--Fix cryptid's exponents by only allowing values - 1 to be manipulated.

SMODS.Joker:take_ownership("j_cry_universe",{
    config = { extra = { emult = 0.1 }, immutable = {base_emult = 1.0} },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return { vars = { number_format(center.ability.extra.emult + center.ability.immutable.base_emult) } }
	end,
calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.cry_astral == true
			and card ~= context.other_joker
		then
			if Talisman and not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				e_mult = lenient_bignum(card.ability.extra.emult + card.ability.immutable.base_emult),
				colour = G.C.DARK_EDITION,
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.cry_astral == true then
				return {
					e_mult = lenient_bignum(card.ability.extra.emult + card.ability.immutable.base_emult),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.cry_astral == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					e_mult = lenient_bignum(card.ability.extra.emult + card.ability.immutable.base_emult),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				e_mult = lenient_bignum(card.ability.extra.emult + card.ability.immutable.base_emult),
				colour = G.C.DARK_EDITION,
				card = card,
			}
		end
	end,
}, true)


SMODS.Joker:take_ownership("j_cry_mprime",{
	config = {
		extra = {
			mult = 0.05,
			bonus = 0.04,
		},
		immutable = {
			base_emult = 1.0
		}
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(center.ability.extra.mult + center.ability.immutable.base_emult),
				number_format(center.ability.extra.bonus),
			},
		}
	end,
	calculate = function(self, card, context)
		-- if context.selling_card and (context.card:is_jolly()) then
		-- 	if not context.blueprint then
		-- 		card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.mult) + card.ability.extra.bonus)
		-- 	end
		-- 	if not context.retrigger_joker then
		-- 		card_eval_status_text(
		-- 			card,
		-- 			"extra",
		-- 			nil,
		-- 			nil,
		-- 			nil,
		-- 			{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
		-- 		)
		-- 	end
		if context.selling_card and (context.card:is_jolly()) then
			if not context.blueprint then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "bonus",
					scaling_message = {
						message = localize("cry_m_ex"),
						colour = G.C.DARK_EDITION,
					},
				})
								return {

				}
			end
		elseif
			context.end_of_round
			and not context.individual
			and not context.repetition
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
			and not context.retrigger_joker
		then
			local mjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + mjoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if mjoker > 0 then
						local card = create_card("M", G.jokers, nil, nil, nil, nil, nil, "mprime")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
		elseif context.other_joker then
			if
				context.other_joker
				and (
					context.other_joker:is_jolly() or Cryptid.safe_get(context.other_joker.config.center, "pools", "M")
				)
			then
				if Talisman and not Talisman.config_file.disable_anims then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end,
					}))
				end
				return {
					e_mult = lenient_bignum(card.ability.extra.mult + card.ability.immutable.base_emult),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			-- card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.mult) + card.ability.extra.bonus)
			local mjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + mjoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if mjoker > 0 then
						local card = create_card("M", G.jokers, nil, nil, nil, nil, nil, "mprime")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			return {
				e_mult = lenient_bignum(card.ability.extra.mult + card.ability.immutable.base_emult),
			}
		end
	end,
}, true)


SMODS.Joker:take_ownership("j_cry_exponentia",{
	config = { extra = { Emult = 0, Emult_mod = 0.03 }, immutable = {base_emult = 1.0}},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Emult_mod),
				number_format(center.ability.extra.Emult + center.ability.immutable.base_emult),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) then
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
		if context.forcetrigger then
			-- card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
	end,
}, true)

SMODS.Joker:take_ownership("j_cry_primus",{
	config = {
		extra = {
			Emult = 0,
			Emult_mod = 0.11,
		},
		immutable = {
			base_emult = 1.0
		},
	},
	calculate = function(self, card, context)
		local check = true
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_hand then
				for k, v in ipairs(context.full_hand) do
					if
						v:get_id() == 4
						or v:get_id() == 6
						or v:get_id() == 8
						or v:get_id() == 9
						or v:get_id() == 10
						or v:get_id() == 11
						or v:get_id() == 12
						or v:get_id() == 13
					then
						check = false
					end
				end
			end
			if check then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "Emult",
					scalar_value = "Emult_mod",
					base = 1, --additional flag to support emult/echips that have an immutable base of 1.
					message_colour = G.C.DARK_EDITION,
					 force_full_val = true,
				})
				card.children.floating_sprite:set_sprite_pos({ x = 8, y = 6 })
								return {

				}
			end
		end
		if context.joker_main and (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) then
			card.children.floating_sprite:set_sprite_pos({ x = 8, y = 6 })
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
		if context.end_of_round then
			card.children.floating_sprite:set_sprite_pos({ x = 2, y = 4 })
		end
		if context.forcetrigger then
			return {
				Emult_mod = lenient_bignum(card.ability.extra.Emult),
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Emult_mod),
				number_format(center.ability.extra.Emult + center.ability.immutable.base_emult),
			},
		}
	end,
}, true)


SMODS.Joker:take_ownership("j_cry_stella_mortis",{
	config = {
		extra = {
			Emult = 0,
			Emult_mod = 0.2,
		},
		immutable = {
			base_emult = 1.0,
		}
	},
	calculate = function(self, card, context)
		if (context.ending_shop and not context.blueprint) or context.forcetrigger then
			local destructable_planet = {}
			local quota = 1
			for i = 1, #G.consumeables.cards do
				if
					G.consumeables.cards[i].ability.set == "Planet"
					and not G.consumeables.cards[i].getting_sliced
					and not SMODS.is_eternal(G.consumeables.cards[i])
				then
					destructable_planet[#destructable_planet + 1] = G.consumeables.cards[i]
				end
			end
			local planet_to_destroy = #destructable_planet > 0
					and pseudorandom_element(destructable_planet, pseudoseed("stella_mortis"))
				or nil

			if planet_to_destroy then
				if Incantation then
					quota = planet_to_destroy:getEvalQty()
				end
				if Overflow then
					quaota = planet_to_destroy.ability.immutable and planet_to_destroy.ability.immutable.overflow_amount
				end
				planet_to_destroy.getting_sliced = true
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "Emult",
					scalar_value = "Emult_mod",
				    base = 1, --additional flag to support emult/echips that have an immutable base of 1.
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = card.ability.immutable.base_emult + initial + change * quota
					end,
					message_key = "a_powmult",
					 force_full_val = true,
				})
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						planet_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				planet_to_destroy.dissolve = 0 --timing issues related to crossmod stuff
				return nil, true
			end
		end
		if (context.joker_main and (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1))) or context.forcetrigger then
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Emult_mod),
				number_format(center.ability.extra.Emult + center.ability.immutable.base_emult),
			},
		}
	end,
}, true)

SMODS.Joker:take_ownership("j_cry_facile",{
	config = {
		extra = {
			Emult = 2,
			check = 10,
		},
		immutable = {
			check2 = 0,
			base_emult = 1,
		},
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Emult + center.ability.immutable.base_emult),
				number_format(center.ability.extra.check),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual then
			if context.cardarea == G.play then
				card.ability.immutable.check2 = lenient_bignum(card.ability.immutable.check2 + 1)
			end
		end
		if context.joker_main and (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) then
			if to_big(card.ability.immutable.check2) <= to_big(card.ability.extra.check) then
				card.ability.immutable.check2 = 0
				return {
					e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
				}
			else
				card.ability.immutable.check2 = 0
			end
		end
		if context.forcetrigger then
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
	end,
}, true) 

SMODS.Joker:take_ownership("j_cry_formidiulosus",{
	config = {
		extra = {
			Emult_mod = 0.01,
			Emult = 0,
		},
		immutable = {
			num_candies = 3,
			base_emult = 1,
		},
	},
	update = function(self, card, front)
		card.ability.extra.Emult = lenient_bignum(
			card.ability.immutable.base_emult + (card.ability.extra.Emult_mod * #Cryptid.advanced_find_joker(nil, "cry_candy", nil, nil, true))
		)
	end,
calculate = function(self, card, context)
		if
			(context.buying_card or context.cry_creating_card)
			and context.card.ability.set == "Joker"
			and context.card.config.center.rarity == "cry_cursed"
			and not context.blueprint
			and not (context.card == card)
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.card:start_dissolve()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_nope_ex"),
						colour = G.C.BLACK,
					})
					return true
				end,
			}))
		end
		if context.ending_shop then
			for i = 1, card.ability.immutable.num_candies do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_trick_candy")
				card:set_edition({ negative = true }, true)
				card:add_to_deck()
				G.jokers:emplace(card)
			end
		end
		if context.cardarea == G.jokers and (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) and context.joker_main then
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
		if context.forcetrigger then
			for i = 1, card.ability.immutable.num_candies do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_trick_candy")
				card:set_edition({ negative = true }, true)
				card:add_to_deck()
				G.jokers:emplace(card)
			end
			return {
				e_mult = lenient_bignum(card.ability.extra.Emult + card.ability.immutable.base_emult),
			}
		end
	end,
}, true) 


Cryptid.misprintize_value_blacklist["cry_valuemanip_reset"] = false
Cryptid.misprintize_value_blacklist["cry_valuemanip2"] = false
Cryptid.misprintize_value_blacklist["cry_gemini_times"] = false