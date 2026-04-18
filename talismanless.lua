--cryptlib copying emult/echips.
--TALISMANLESS AS WELL!

function UNIK.has_talisman()
	if (SMODS.Mods["cdataman"] or {}).can_load or next(SMODS.find_mod("cdataman")) then
		return true
	end
	if (SMODS.Mods["Amulet"] or {}).can_load then
		return true
	end
	if (SMODS.Mods and SMODS.Mods.Talisman) or (SMODS.Mods.Talisman and SMODS.Mods.Talisman.can_load) then
		return true
	end
	return false
end


local scie2 = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	local ret = scie2(effect, scored_card, key, amount, from_edition)
	if ret then
		return ret
	end
		if (key == "xlog_mult" or key == "xlogmult" or key == "xlog_mult_mod") and amount ~= 1 then
			if effect.card then
				juice_card(effect.card)
			end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult:modify(mult.current * math.log(math.max(amount,mult.current),amount) - mult.current)

			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = localize("k_mult") .. " Xlog_" .. amount .. "(" .. localize("k_mult") .. ")", colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "xlog_mult_mod" then
					if effect.emult_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.emult_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "xlog_mult", amount, percent)
					end
				end
			end
			return true
		end
		if (key == "xlog_chips" or key == "xlogchips" or key == "xlog_chips_mod") and amount ~= 1 then
			if effect.card then
				juice_card(effect.card)
			end
			local chips = SMODS.Scoring_Parameters["chips"]
			local log = math.log(math.max(amount,chips.current),amount)
			chips:modify(chips.current * math.log(math.max(amount,chips.current),amount) - chips.current)

			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = localize("k_chips") .. " Xlog_" .. amount .. "(" .. localize("k_chips") .. ")", colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "xlog_mult_mod" then
					if effect.emult_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.emult_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "xlog_chips", amount, percent)
					end
				end
			end
			return true
		end
		if (key == 'eq_mult' or key == 'Eqmult_mod') and not next(SMODS.find_mod("Spectrallib")) then 
			if effect.card then
				juice_card(effect.card)
			end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult:modify(amount - mult.current)
			
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = "=" .. amount .. " " .. localize("k_mult"), colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "eqchips_mod" then
					if effect.emult_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.emult_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "eq_mult", amount, percent)
					end
				end
			end
			return true
		end
		if (key == 'eq_chips' or key == 'Eqchips_mod') and not next(SMODS.find_mod("Spectrallib"))  then 
			if effect.card then
				juice_card(effect.card)
			end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips:modify(amount - chips.current)

			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = "=" .. amount .. " " .. localize("k_chips"), colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "eqchips_mod" then
					if effect.emult_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.emult_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "eq_chips", amount, percent)
					end
				end
			end
			return true
		end
end
for _, v in ipairs({
	"xlog_mult", "xlogmult", "xlog_mult_mod",
	"xlog_chips", "xlogchips", "xlog_chips_mod",
	'eq_mult', 'Eqmult_mod',
	'eq_chips',"Eqchips_mod",
}) do
	table.insert(SMODS.scoring_parameter_keys, v)
end
SMODS.Sound({
	key = "emult",
	path = "ExponentialMult.wav",
})
SMODS.Sound({
	key = "echip",
	path = "ExponentialChips.wav",
})
SMODS.Sound({
	key = "xchip",
	path = "MultiplicativeChips.wav",
})
SMODS.Sound({
	key = "eemult",
	path = "TetrationalMult.wav",
})
if SMODS and SMODS.Mods and not UNIK.has_talisman() and not (SMODS.Mods["cdataman"] or {}).can_load and not next(SMODS.find_mod("Cryptlib")) then
	local smods_xchips = false
	for _, v in pairs(SMODS.scoring_parameter_keys) do
		if v == "x_chips" then
			smods_xchips = true
			break
		end
	end

	local scie = SMODS.calculate_individual_effect
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local ret = scie(effect, scored_card, key, amount, from_edition)
		if ret then
			return ret
		end
		if (key == "e_chips" or key == "echips" or key == "Echip_mod") and amount ~= 1 then
			if effect.card then
				juice_card(effect.card)
			end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips:modify((chips.current ^ amount) - chips.current)
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = "^" .. amount, colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "Echip_mod" then
					if effect.echip_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.echip_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "e_chips", amount, percent)
					end
				end
			end
			return true
		end
		if (key == "e_mult" or key == "emult" or key == "Emult_mod") and amount ~= 1 then
			if effect.card then
				juice_card(effect.card)
			end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult:modify((mult.current ^ amount) - mult.current)
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(
						scored_card,
						"jokers",
						nil,
						percent,
						nil,
						{ message = "^" .. amount .. " " .. localize("k_mult"), colour = G.C.EDITION, edition = true }
					)
				elseif key ~= "Emult_mod" then
					if effect.emult_message then
						card_eval_status_text(
							scored_card or effect.card or effect.focus,
							"extra",
							nil,
							percent,
							nil,
							effect.emult_message
						)
					else
						card_eval_status_text(scored_card or effect.card or effect.focus, "e_mult", amount, percent)
					end
				end
			end
			return true
		end
	end
	for _, v in ipairs({
		"e_mult", "emult", "Emult_mod",
		"e_chips", "echips", "Echip_mod",

	}) do
		table.insert(SMODS.scoring_parameter_keys, v)
	end
	if not smods_xchips then
		for _, v in ipairs({ "x_chips", "xchips", "Xchip_mod" }) do
			table.insert(SMODS.scoring_parameter_keys, v)
		end
	end
	to_big = to_big or function(x) return x end
	to_number = to_number or function(x) return x end
	lenient_bignum = lenient_bignum or function(x) return x end
	
	--exponent blind size replacement, can only do exponents.
	
end

function portable_exp(initial,exponent,value)
	if (not UNIK.has_talisman()) or to_big(exponent) <= to_big(1) then
		if exponent == 0 then
			return initial*value
		end
		if exponent == -1 then
			return initial+value
		end
		return initial^value
	else
		local bigNum = to_big(initial)
		--print(bigNum .. " " .. exponent .. " " .. value)
		--print (bigNum:arrow(to_big(exponent),to_big(value)))
		return bigNum:arrow(to_big(exponent),to_big(value))
	end
end

--Returns Chips, Mult
function UNIK.calculate_balance_exp(chips, mult, exp)
	if not exp then exp = 1 end
	local newExp = math.max(0,math.min(1,exp))
	local remainder = (chips + mult)/2
	local greater = {operation = 'chips', variable = chips}
	local lesser = {operation = 'mult', variable = mult}
	if chips < mult then
		greater = {operation = 'mult', variable = mult}
		lesser = {operation = 'chips', variable = chips}
	end
	--print(greater)
	--print(lesser)

	local difference = (greater.variable - remainder)^newExp
	greater.variable = greater.variable - difference
	lesser.variable = lesser.variable + difference

	--	print(greater)
	--print(lesser)
	local combinedTable = {greater = nil,lesser = nil}
	combinedTable.greater = greater
	combinedTable.lesser = lesser
	local returnTable = {chips = nil, mult = nil}
	for i,v in pairs(combinedTable) do
		--print(v)
		returnTable[v.operation] = v.variable
	end
	--print(returnTable)
	return returnTable
end

function UNIK.balance_exp(exp,card,nomessage)
	local table = UNIK.calculate_balance_exp(hand_chips, mult, exp)
	local new_chips = table.chips
	local new_mult = table.mult
	hand_chips = mod_chips(new_chips)
	mult = mod_mult(new_mult)

	update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })

	-- Cosmetic effects
	G.E_MANAGER:add_event(Event({
		func = (function()
		-- Play sounds and change the color of the scoring values
		play_sound('gong', 0.94, 0.3)
		play_sound('gong', 0.94 * 1.5, 0.2)
		play_sound('tarot1', 1.5)
		ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
		ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })

		-- If a card was passed, show the balanced message on it
		if not nomessage then
			if card then
				SMODS.calculate_effect({
				message = localize('k_balanced'),
				colour = { 0.8, 0.45, 0.85, 1 },
				instant = true
				}, card)
			else
				local text = localize('k_balanced')
				attention_text({
					scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
				})
			end
		end
		

		-- Return the colors to normal
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			blockable = false,
			blocking = false,
			delay = 4.3,
			func = (function()
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
			ease_colour(G.C.UI_MULT, G.C.RED, 2)
			return true
			end)
		}))

		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			blockable = false,
			blocking = false,
			no_delete = true,
			delay = 6.3,
			func = (function()
			G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] =
				G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
			G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] =
				G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
			return true
			end)
		}))
		return true
		end)
	}))

	delay(0.6)
end