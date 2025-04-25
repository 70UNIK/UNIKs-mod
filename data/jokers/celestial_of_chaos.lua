--CELESIAL OF CHAOS: Moonlight's horrifically mutated form.
local celestial_quotes = {
	normal = {
		'k_unik_celestial_of_chaos1',
		'k_unik_celestial_of_chaos2',
		'k_unik_celestial_of_chaos3',
	},

}
SMODS.Joker {
	dependencies = {
        mods = {
            "jen", 
          }
    },
	gameset_config = {
		modest = {disabled = true},
		mainline = {disabled = not (SMODS.Mods["jen"] or {}).can_load}, 
		madness = {disabled = not (SMODS.Mods["jen"] or {}).can_load} --will never load without omega consumeables 
	},
	key = 'unik_celestial_of_chaos',
    atlas = 'placeholders',
    rarity = "jen_transcendent",
	pos = { x = 1, y = 1 },
	-- -- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	-- soul_pos = { x = 1, y = 0 },
    cost = 1e3,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	no_doe = true,
	-- did some fine tuning using desmos; Assuming Stellar mortis (MASSIVE anti synergy with her) eats 3 planets vs her keeping 3 planets, ^1.3 makes them even for that number of planets. 
	-- Moonlight is harder to scale vs stellar due to consumeable limit, but with the right setup, she can exceed it (Perkeo anyone?)
    config = { extra = { EEEmult = 1.3,consumeSlot = 6} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return { 
			vars = {center.ability.extra.EEEmult , center.ability.extra.consumeSlot,
			localize(celestial_quotes[quoteset][math.random(#celestial_quotes[quoteset])] .. "")
		},
		}
	end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumeSlot
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumeSlot
	end,
    calculate = function(self, card, context)
		--Known issue: does not work with retriggers.
        if context.other_consumeable and context.other_consumeable.ability.set == 'jen_omegaconsumable'
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
			if not Talisman.config_file.disable_anims and valid == true then
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						context.other_consumeable:juice_up(1, 1)
						return true
					end,
				}))
			end
			if context.other_consumeable.debuff then
				card_eval_status_text(card, "debuff", nil, nil, nil, nil)
				--return true
			elseif valid == true then
				--if using incantation, she should exponent over and over for x quantity.
				
				if (SMODS.Mods["incantation"] or {}).can_load then
					if context.other_consumeable.ability.qty and context.other_consumeable.ability.qty > 1 then
						for i = 1, context.other_consumeable.ability.qty-1 do
							SMODS.calculate_effect({
								message = localize({
									type = "variable",
									key = "a_hyper_three_mult",
									vars = {
										number_format(card.ability.extra.EEEmult),
									},
								}),
								EEEmult_mod = card.ability.extra.EEEmult,
								colour = G.C.UNIK_VOID_COLOR,
							}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
						end
					end
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_hyper_three_mult",
                            vars = {
                                number_format(card.ability.extra.EEEmult),
                            },
                        }),
                        EEEmult_mod = card.ability.extra.EEEmult,
                        colour = G.C.UNIK_VOID_COLOR,
						
                    }
				-- end
				else
                
					return {
						message = localize({
							type = "variable",
							key = "a_hyper_three_mult",
							vars = {
								number_format(card.ability.extra.EEEmult),
							},
						}),
						EEEmult_mod = card.ability.extra.EEEmult,
						colour = G.C.UNIK_VOID_COLOR,

					}

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

