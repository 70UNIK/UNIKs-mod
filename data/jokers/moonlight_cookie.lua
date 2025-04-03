SMODS.Atlas {
	key = "unik_moonlight",
	path = "unik_moonlight_cookie.png",
	px = 71,
	py = 95
}
--from maxie
local moonlight_quotes = {
	normal = {
		'k_unik_moonlight_normal1',
		'k_unik_moonlight_normal2',
		'k_unik_moonlight_normal3',
	},
	drama = {
		'k_unik_moonlight_scared1',
	},
	gods = {
		'k_unik_moonlight_godsmarble1',
		'k_unik_moonlight_godsmarble2',
		'k_unik_moonlight_godsmarble3',
	}
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
	drama = { x = 1, y = 0 }, --WIP: Remains the same
	godsmarbling = {x = 1, y = 0 }, --may remove once a seperate "godsmarbling" sprite function is made (Scared but exclusively when godsmarble is present)
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	fusable = true,
	-- did some fine tuning using desmos; Assuming Stellar mortis (MASSIVE anti synergy with her) eats 3 planets vs her keeping 3 planets, ^1.3 makes them even for that number of planets. 
	-- Moonlight is harder to scale vs stellar due to consumeable limit, but with the right setup, she can exceed it (Perkeo anyone?)
    config = { extra = { Emult = 1.3,consumeSlot = 1} },
	gameset_config = {
		modest = { extra = { Emult = 1.2} },
		madness = { extra = { Emult = 1.3,consumeSlot = 1} },
	},
	loc_vars = function(self, info_queue, center)
		--normal quotes only if not Jen
		local quoteset = 'normal'
		if (SMODS.Mods["jen"] or {}).can_load then
			quoteset = Jen.dramatic and 'drama' or Jen.gods() and 'gods' or 'normal'
		end
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest",madness = "madness"  }), 
			vars = {center.ability.extra.Emult , center.ability.extra.consumeSlot,
			localize(moonlight_quotes[quoteset][math.random(#moonlight_quotes[quoteset])] .. "")
		} 
		}
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
	set_ability = function(self, card, initial, delay_sprites)
	end,
	
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
		if context.other_consumeable then
			print(context.other_consumeable.ability.atlas)
			print(context.other_consumeable.atlas)
		end
		
        if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' or 
		(context.other_consumeable and context.other_consumeable.ability.set == 'jen_omegaconsumable')
		then
			local valid = false
			--jen exclusive, check if omega consumable is a planet/black hole
			if (SMODS.Mods["jen"] or {}).can_load and context.other_consumeable.ability.set == 'jen_omegaconsumable' then
				if 
				context.other_consumeable.config.center.key == 'c_jen_pluto_omega' or
				context.other_consumeable.config.center.key == 'c_jen_mercury_omega' or
				context.other_consumeable.config.center.key == 'c_jen_uranus_omega' or
				context.other_consumeable.config.center.key == 'c_jen_venus_omega' or
				context.other_consumeable.config.center.key == 'c_jen_saturn_omega' or
				context.other_consumeable.config.center.key == 'c_jen_jupiter_omega' or
				context.other_consumeable.config.center.key == 'c_jen_earth_omega' or
				context.other_consumeable.config.center.key == 'c_jen_mars_omega' or
				context.other_consumeable.config.center.key == 'c_jen_neptune_omega' or
				context.other_consumeable.config.center.key == 'c_jen_planet_x_omega' or
				context.other_consumeable.config.center.key == 'c_jen_ceres_omega' or
				context.other_consumeable.config.center.key == 'c_jen_eris_omega' or
				context.other_consumeable.config.center.key == 'c_jen_black_hole_omega'
				then
					valid = true
				end

			end
			
			--automatically ignore hand type if its modest
			if Card.get_gameset(card) ~= "modest" and context.other_consumeable.ability.set ~= 'jen_omegaconsumable' then
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
					--hmm maybe this could work?
					if context.other_consumeable.ability.qty and context.other_consumeable.ability.qty > 1 then
						for i = 1, context.other_consumeable.ability.qty-1 do
							SMODS.calculate_effect({
								message = localize({
									type = "variable",
									key = "a_powmult",
									vars = {
										number_format(card.ability.extra.Emult),
									},
								}),
								Emult_mod = card.ability.extra.Emult,
								colour = G.C.DARK_EDITION,
							}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
						end
					end
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
					}
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

					}

				end

			end
        end
    end,

}