--CELESIAL OF CHAOS: Moonlight's horrifically mutated form.
SMODS.Joker {
	key = 'unik_celesial_of_chaos',
    atlas = 'placeholders',
    rarity = "jen_transcendent",
	pos = { x = 1, y = 1 },
	-- -- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	-- soul_pos = { x = 1, y = 0 },
    cost = 1e3,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    dangerous = true, --especially with incantation.
	-- did some fine tuning using desmos; Assuming Stellar mortis (MASSIVE anti synergy with her) eats 3 planets vs her keeping 3 planets, ^1.3 makes them even for that number of planets. 
	-- Moonlight is harder to scale vs stellar due to consumeable limit, but with the right setup, she can exceed it (Perkeo anyone?)
    config = { extra = { EEEmult = 1.06,consumeSlot = 6} },
	loc_vars = function(self, info_queue, center)
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest",madness = "madness"  }), 
			vars = {center.ability.extra.Emult , center.ability.extra.consumeSlot} 
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
        if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' and context.consumeable.ability.set == 'jen_omegaconsumable'
		then

			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_consumeable:juice_up(1, 1)
						return true
					end,
				}))
			end
			if context.other_consumeable.debuff then
				card_eval_status_text(card, "debuff", nil, nil, nil, nil)
				--return true
			else
				--if using incantation, she should exponent over and over for x quantity.
				
				if (SMODS.Mods["incantation"] or {}).can_load then
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
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up(1.0, 1.0)
                            G.ROOM.jiggle = G.ROOM.jiggle + 6
                            return true
                        end,
                    }))
                
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

