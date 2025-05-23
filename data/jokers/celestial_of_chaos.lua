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
    cost = 5000,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	no_doe = true,
	immutable = true,
	unique = true,
	debuff_immune = true,
    config = { extra = { operator = -1, hypermult = 1.1, operatorIncrease = 1, triggersRequired = 30, triggers = 0,operatorIncreaseReqs = 1.4} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return { 
			vars = {"{"..center.ability.extra.operator.."}", center.ability.extra.hypermult,center.ability.extra.operatorIncrease,center.ability.extra.triggersRequired,center.ability.extra.operatorIncreaseReqs,
			localize(celestial_quotes[quoteset][math.random(#celestial_quotes[quoteset])] .. "")
		},
		}
	end,
    calculate = function(self, card, context)
		if context.after then
			G.E_MANAGER:add_event(Event({
                trigger='after',
                delay=0.2,
                func = function()
                    card.ability.extra.operator = -1
					card.ability.extra.triggers = 0
					card.ability.extra.triggersRequired = 35
                        return true
                    end
                }))
		end
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
					if context.other_consumeable.ability.qty then
						for i = 1, context.other_consumeable.ability.qty do

							-- SMODS.calculate_effect({
							-- 	message = localize({
							-- 		type = "variable",
							-- 		key = "a_hyper_three_mult",
							-- 		vars = {
							-- 			number_format(card.ability.extra.EEEmult),
							-- 		},
							-- 	}),
							-- 	EEEmult_mod = card.ability.extra.EEEmult,
							-- 	colour = G.C.UNIK_VOID_COLOR,
							-- }, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
							DynamicOperator(card,context)
							card.ability.extra.triggers = card.ability.extra.triggers + 1
							if card.ability.extra.triggers >= card.ability.extra.triggersRequired then
								card.ability.extra.triggers = 0
								card.ability.extra.operator = card.ability.extra.operator + 1
								card.ability.extra.triggersRequired = (card.ability.extra.triggersRequired*card.ability.extra.operatorIncreaseReqs)
							end
						end
					else
						DynamicOperator(card,context)
						card.ability.extra.triggers = card.ability.extra.triggers + 1
						if card.ability.extra.triggers >= card.ability.extra.triggersRequired then
							card.ability.extra.triggers = 0
							card.ability.extra.operator = card.ability.extra.operator + 1
							card.ability.extra.triggersRequired = (card.ability.extra.triggersRequired*card.ability.extra.operatorIncreaseReqs)
						end
					end
                    return {

					}--For joker retriggers, etc...
				-- end
				else
					DynamicOperator(card,context)
					-- return {
					-- 	message = localize({
					-- 		type = "variable",
					-- 		key = "a_hyper_three_mult",
					-- 		vars = {
					-- 			number_format(card.ability.extra.EEEmult),
					-- 		},
					-- 	}),
					-- 	EEEmult_mod = card.ability.extra.EEEmult,
					-- 	colour = G.C.UNIK_VOID_COLOR,

					-- }
					card.ability.extra.triggers = card.ability.extra.triggers + 1
					if card.ability.extra.triggers >= card.ability.extra.triggersRequired then
						card.ability.extra.triggers = 0
						card.ability.extra.operator = card.ability.extra.operator + 1
						card.ability.extra.triggersRequired = (card.ability.extra.triggersRequired*card.ability.extra.operatorIncreaseReqs)
					end
					return {

					}--For joker retriggers, etc...
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
function DynamicOperator(card,context)
	if card.ability.extra.operator < 0 then
		SMODS.calculate_effect({
			mult = card.ability.extra.hypermult,
			colour = G.C.MULT,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 0 then
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_xmult",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			Xmult_mod = card.ability.extra.hypermult,
			colour = G.C.MULT,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 1 then
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_powmult",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			Emult_mod = card.ability.extra.hypermult,
			colour = G.C.DARK_EDITION,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 2 then
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_EEchips",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			EEmult_mod = card.ability.extra.hypermult,
			colour = G.C.DARK_EDITION,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 3 then
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_hyper_three_mult",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			EEEmult_mod = card.ability.extra.hypermult,
			colour = G.C.UNIK_VOID_COLOR,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 4 then
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_hyper_four_mult",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			hypermult_mod = {card.ability.extra.operator,card.ability.extra.hypermult},
			colour = G.C.UNIK_VOID_COLOR,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	elseif card.ability.extra.operator == 5 then
			SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_hyper_five_mult",
				vars = {
					number_format(card.ability.extra.hypermult),
				},
			}),
			hypermult_mod = {card.ability.extra.operator,card.ability.extra.hypermult},
			colour = G.C.jen_RGB,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))	
	else
		SMODS.calculate_effect({
			message = localize({
				type = "variable",
				key = "a_hyper_hyper_mult",
				vars = {
					"{"..number_format(card.ability.extra.operator).."}",
					number_format(card.ability.extra.hypermult),
				},
			}),
			hypermult_mod = {card.ability.extra.operator,card.ability.extra.hypermult},
			colour = G.C.jen_RGB,
		}, (card or context.blueprint_card or context.retrigger_joker or context.repetition))
	end

	
end

