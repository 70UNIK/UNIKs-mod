SMODS.Atlas {
	key = "unik_moonlight",
	path = "unik_moonlight_cookie.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	key = 'unik_moonlight_cookie',
    atlas = 'unik_moonlight',
    rarity = "cry_exotic",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	-- did some fine tuning using desmos; Assuming Stellar mortis (MASSIVE anti synergy with her) eats 3 planets vs her keeping 3 planets, ^1.3 makes them even for that number of planets. 
	-- Moonlight is harder to scale vs stellar due to consumeable limit, but with the right setup, she can exceed it (Perkeo anyone?)
    config = { extra = { Emult = 1.3} },
	gameset_config = {
		modest = { extra = { Emult = 1.2} },
		madness = { extra = { Emult = 1.3,consumeSlot = 1} },
	},
	loc_vars = function(self, info_queue, center)
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest",madness = "madness"  }), 
			vars = {center.ability.extra.Emult , center.ability.extra.consumeSlot} 
		}
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    add_to_deck = function(self, card, from_debuff)
		-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
		-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
		if Card.get_gameset(card) == "madness" then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumeSlot
		end
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		-- Adds - instead of +, so they get subtracted when this card is removed.
		if Card.get_gameset(card) == "madness" then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumeSlot
		end
	end,
    calculate = function(self, card, context)
		--Known issue: does not work with retriggers.
        if context.other_consumeable and context.other_consumeable.ability.set == 'Planet'
		then
			local valid = false
			--automatically ignore hand type if its modest
			if Card.get_gameset(card) ~= "modest" then
				valid = true
			end
			--check if its the right planet
			if context.other_consumeable.ability.hand_type and valid == false then
				if context.other_consumeable.ability.hand_type == context.scoring_name then

					print(context.other_consumeable.ability.hand_type)
					valid = true
				end
			end
			--for loop if it has hand_types for compatibility with 3 planet cards
			if context.other_consumeable.ability.hand_types and valid == false then
				if context.other_consumeable.ability.hand_types then
					for i = 1,#context.other_consumeable.ability.hand_types do
						if context.other_consumeable.ability.hand_types[i] == context.scoring_name then
							valid = true
							print(context.other_consumeable.ability.hand_types[i])
							break
						end
					end
				end
			end
			if not Talisman.config_file.disable_anims and valid == true then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_consumeable:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			if context.other_consumeable.debuff and valid == true then
				card_eval_status_text(card, "debuff", nil, nil, nil, nil)
				--return true
			elseif valid == true then
				--if using incantation, she should exponent over and over for x quantity.
				
				if (SMODS.Mods["incantation"] or {}).can_load then
					-- if not Talisman.config_file.disable_anims then
					-- 	for i = 1,(context.other_consumeable.ability.qty or 1) do
					-- 		SMODS.calculate_effect({
					-- 			message = localize({
					-- 				type = "variable",
					-- 				key = "a_powmult",
					-- 				vars = { number_format(to_big(card.ability.extra.Emult)) },
					-- 			}),
					-- 			Emult_mod = card.ability.extra.Emult,
					-- 			colour = G.C.DARK_EDITION,
					-- 			card = context.other_consumeable,
					-- 		}, context.blueprint_card or context.retrigger_joker or card)
					-- 	end
					-- else
					-- 	SMODS.calculate_effect({
					-- 		message = localize({
					-- 			type = "variable",
					-- 			key = "a_powmult",
					-- 			vars = { number_format(to_big(card.ability.extra.Emult)) },
					-- 		}),
					-- 		Emult_mod = card.ability.extra.Emult^(context.other_consumeable.ability.qty or 1),
					-- 		colour = G.C.DARK_EDITION,
					-- 		card = context.other_consumeable,
					-- 	}, context.blueprint_card or context.retrigger_joker or card)
						return {
							message = localize({
								type = "variable",
								key = "a_powmult",
								vars = {
									number_format(card.ability.extra.Emult),
								},
							}),
							Emult_mod = card.ability.extra.Emult^(context.other_consumeable.ability.qty or 1),
							colour = G.C.DARK_EDITION,
							card = context.other_consumeable
						}
				-- end
				else
					return {
						message = localize({
							type = "variable",
							key = "a_powmult",
							vars = {
								number_format(card.ability.extra.Emult),
							},
						}),
						Emult_mod = card.ability.extra.Emult,
						colour = G.C.DARK_EDITION,
						card = context.other_consumeable
					}
					-- SMODS.calculate_effect({
					-- 	message = localize({
					-- 		type = "variable",
					-- 		key = "a_powmult",
					-- 		vars = { number_format(to_big(card.ability.extra.Emult)) },
					-- 	}),
					-- 	Emult_mod = card.ability.extra.Emult,
					-- 	colour = G.C.DARK_EDITION,
					-- 	card = context.other_consumeable,
					-- }, context.blueprint_card or card)
				end

			end
        end
    end,
    -- cry_credits = {
	-- 	idea = { "70UNIK" },
	-- 	art = { "70UNIK (originally from Devsisters)" },
	-- 	code = { "70UNIK (partially from Cryptid)" },
	-- },
}