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
			mult:modify((to_big(mult.current) * to_big(math.log(to_big(math.max(amount,mult.current)),to_big(amount)))) - to_big(mult.current))
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
			chips:modify((to_big(chips.current) * to_big(math.log(to_big(math.max(amount,chips.current)),to_big(amount)))) - to_big(chips.current))
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
end
for _, v in ipairs({
	"xlog_mult", "xlogmult", "xlog_mult_mod",
	"xlog_chips", "xlogchips", "xlog_chips_mod",
}) do
	table.insert(SMODS.scoring_parameter_keys, v)
end
if SMODS and SMODS.Mods and not UNIK.has_talisman() and not (SMODS.Mods["cdataman"] or {}).can_load and not (SMODS.Mods["Cryptlib"] or {}).can_load then
	local smods_xchips = false
	for _, v in pairs(SMODS.scoring_parameter_keys) do
		if v == "x_chips" then
			smods_xchips = true
			break
		end
	end
	SMODS.Sound({
		key = "emult",
		path = "ExponentialMult.wav",
	})
	SMODS.Sound({
		key = "echips",
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