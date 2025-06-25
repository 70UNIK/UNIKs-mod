--OIL LUMP
SMODS.Joker:take_ownership("cry_oil_lamp", {
    immutable = true,
    rarity = 'cry_epic',
    config = { extra = { increase = 1.075 } },
	--you can have your fun in madness (to an extent)
	gameset_config = {
		madness = { extra = { increase = 1.2 }, immutable = false },
		modest = {disabled = true}
	},
}, true)

--TROFICAL SMOOTHER
SMODS.Joker:take_ownership("j_cry_tropical_smoothie", {
    config = { extra = {extra = 1.25, self_destruct = false}},
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.extra) } }
	end,
    gameset_config = {
		madness = { extra = {extra = 1.5, self_destruct = false}, immutable = false },
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
    config = { extra = {increase = 1.5,self_destruct = false} },
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.increase) } }
	end,
    gameset_config = {
		madness = { extra = {increase = 2, self_destruct = false} },
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
		return { key = Cryptid.gameset_loc(self, { modest = "balanced" }),vars={num_retriggers} }
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
--Googol play card is much rarer and has a 1xe100 chance of self destructing to avoid rig abuse
SMODS.Joker:take_ownership("j_cry_googol_play",{
	config = {
		extra = {
			Xmult = 17,
			odds = 8,
		},
	},
}, true)
--WAAAAAAHHHH
SMODS.Joker:take_ownership("j_cry_waluigi",{
	config = { extra = { Xmult = 2 } },
}, true)


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

--Nerfing pirate dagger to exactly the same as xmult
SMODS.Joker:take_ownership("j_cry_pirate_dagger",{
calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
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
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
			}
		end
	end,
},true)

--All non exotic emulters (except happy house and night) should be immutable. Cry about it, otherwise it becomes too OP.
SMODS.Joker:take_ownership("j_cry_universe",{
    config = { extra = { emult = 1.1 } },
    gameset_config = {
		madness = { extra = { emult = 1.2 }, immutable = false },
	},
    immutable = true,
}, true)
SMODS.Joker:take_ownership("j_cry_jtron",{
    immutable = true,
    gameset_config = {
		madness = {immutable = false },
	},
}, true)

--reduce values of stardust to x1.5 (especially since its a fucking common)
SMODS.Joker:take_ownership("j_cry_stardust",{
    config = { extra = { xmult = 1.5 } },
    gameset_config = {
		madness = {extra = { xmult = 2 } },
	},
}, true)

--eflame should be x0.1 or x0.12
SMODS.Joker:take_ownership("j_cry_eternalflame",{
	config = {
		extra = {
			extra = 0.1,
			x_mult = 1,
		},
	},
}, true)

--garden of forking paths must be uncommon
SMODS.Joker:take_ownership("j_cry_gardenfork",{
	rarity = 2,
}, true)

--fuck the filler
SMODS.Joker:take_ownership("j_cry_filler",{
    gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = { disabled = false },
		experimental = { disabled = false },
	},
}, true)

--fuck astralbottle. outside of experimental or madness, its a CURSED joker.
SMODS.Joker:take_ownership("j_cry_astral_bottle",{
    gameset_config = {
		modest = { center = { rarity = 'cry_cursed'}},
		mainline = { center = { rarity = 'cry_cursed'}},
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
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.emult),
					},
				}),
				Emult_mod = lenient_bignum(card.ability.emult),
				colour = G.C.DARK_EDITION,
			}
		end
		if context.force_trigger then
			card.ability.emult = card.ability.emult - card.ability.emult_mod
			if (to_number(card.ability.emult) <= 1.00000001 and not card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			elseif (to_number(card.ability.emult) <= 0.00000001 and card.ability.unik_depleted) then
				selfDestruction(card,'k_eaten_ex',G.C.DARK_EDITION)
			else
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = {
							number_format(card.ability.emult),
						},
					}),
					Emult_mod = lenient_bignum(card.ability.emult),
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