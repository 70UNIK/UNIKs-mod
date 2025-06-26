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
	-- drama = {
	-- 	'k_unik_moonlight_scared1',
	-- },
	-- gods = {
	-- 	'k_unik_moonlight_godsmarble1',
	-- 	'k_unik_moonlight_godsmarble2',
	-- 	'k_unik_moonlight_godsmarble3',
	-- }
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
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
	fusable = true,
    config = { extra = { Emult = 1.2,odds = 5} },
	gameset_config = {
		modest = { extra = { Emult = 1.07,odds = 999999} },
	},
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest"  }), 
			vars = {center.ability.extra.Emult, center and cry_prob(2 or center.ability.cry_prob*2,center.ability.extra.odds,center.ability.cry_rigged) or 2, 
			center.ability.extra.odds,
			localize(moonlight_quotes[quoteset][math.random(#moonlight_quotes[quoteset])] .. "")
		} 
		}
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
	set_ability = function(self, card, initial, delay_sprites)
	end,
    calculate = function(self, card, context)

		if (context.unik_blinds_refresh) and Card.get_gameset(card) ~= "modest" then
			print("try")
			--What if you decide to stack non negative consumeables (I prefer NOT to do that, but its a possibility. It should decrement the value and create one)
			if G.consumeables.cards[1] then
				--Get valid cards
				local validCards = {}
				for i,v in pairs(G.consumeables.cards) do
					if v.ability.set == 'Planet'
					 and not v.edition then
						validCards[#validCards + 1] = v
					end
				end
				if #validCards > 0 then
					local card2 = pseudorandom_element(validCards, pseudoseed('moonlight_negative'), nil)
					--If incantation, automatically split 1 negative from a big pile
					if (SMODS.Mods["incantation"] or {}).can_load then
						if card2.getQty then
							local amount = card2:getQty()
							if amount > 1 then
								local newCard = card2:split(1)
								newCard:set_edition('e_negative', true)
								newCard:try_merge()
								card:juice_up(0.5, 0.5)
							else
								card2:set_edition('e_negative', true)
								card2:try_merge()
								card:juice_up(0.5, 0.5)
							end
						else
							card2:set_edition('e_negative', true)
							card2:try_merge()
							card:juice_up(0.5, 0.5)
						end
					else
						card2:set_edition('e_negative', true)
						card:juice_up(0.5, 0.5)
					end
				end
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0,
                func = function()
			if G.consumeables.cards[1] then
				--Get valid cards
				local validCards = {}
				if #validCards > 0 then
					local card2 = pseudorandom_element(validCards, pseudoseed('moonlight_negative'), nil)
					--If incantation, automatically split 1 negative from a big pile
					if (SMODS.Mods["incantation"] or {}).can_load then
						if card2.getQty then
							local amount = card2:getQty()
							if amount > 1 then
								local newCard = card2:split(1)
								newCard:set_edition('e_negative', true)
								newCard:try_merge()
								card:juice_up(0.5, 0.5)
							else
								card2:set_edition('e_negative', true)
								card2:try_merge()
								card:juice_up(0.5, 0.5)
							end
						else
							card2:set_edition('e_negative', true)
							card2:try_merge()
							card:juice_up(0.5, 0.5)
						end
					else
						card2:set_edition('e_negative', true)
						card:juice_up(0.5, 0.5)
					end
				end
			end
			        return true
                end,
            }))
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

					--print(context.other_consumeable.ability.hand_type)
					valid = true
				end
			end
			--for loop if it has hand_types for compatibility with 3 planet cards
			if context.other_consumeable.ability.hand_types and valid == false then
				if context.other_consumeable.ability.hand_types then
					for i = 1,#context.other_consumeable.ability.hand_types do
						if context.other_consumeable.ability.hand_types[i] == context.scoring_name then
							valid = true
							--print(context.other_consumeable.ability.hand_types[i])
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
				if
				G.HUD_blind
				and G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_1")
				then
					G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_1"):juice_up(0.3, 0)
				end
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
--So how she will work:
--^Emult (multiplied by number of planets and triggers, which... is painful. Have to build this on my own)
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_moonlight_cookie"] = {
		text = {
			{
				border_nodes = {
					{ text = "^" },
					{ ref_table = "card.joker_display_values", ref_value = "Emult", retrigger_type = "exp" },
				},
				border_colour = G.C.DARK_EDITION,
			},
		},
		reminder_text = {
			{
				ref_table = "card.joker_display_values",
				ref_value = "localized_text_poker_hand",
				colour = G.C.FILTER,
				scale = 0.3,
			},		
			{
				ref_table = "card.joker_display_values",
				ref_value = "localized_text",
				colour = G.C.SECONDARY_SET.Planet,
			},
		},
		-- extra = {
        --     {
        --         {
        --             ref_table = "card.joker_display_values",
        --             ref_value = "odds",
        --             colour = G.C.GREEN,
        --             scale = 0.3,
        --         },		
		-- 	},
		-- },
		calc_function = function(card)
			local Emult = 1
			local odds = ""
			local text, _, scoring_hand = JokerDisplay.evaluate_hand() --get poker hand
			if Card.get_gameset(card) ~= "modest" or (text ~= 'Unknown' and text ~= 'NULL' and Card.get_gameset(card) == "modest") then
				--Iterate through each consumeable, checking for poker hand type (if modest)
				for i,v in pairs(G.consumeables.cards) do
					local valid = false
					if v.ability.set == "Planet" and not v.debuff then
						--Indiscriminate if not modest
						if Card.get_gameset(card) ~= "modest" then
							valid = true
						end
						--Otherwise check poker hand type
						--check if its the right planet
						if v.ability.hand_type and valid == false then
							--print(v.ability.hand_type .. text)
							if v.ability.hand_type == text then
								--print(context.other_consumeable.ability.hand_type)
								valid = true
							end
						end
						--for loop if it has hand_types for compatibility with 3 planet cards
						if v.ability.hand_types and valid == false then
							if v.ability.hand_types then
								for i = 1,#v.ability.hand_types do
									--print(v.ability.hand_types[i] .. text)
									if v.ability.hand_types[i] == text then
										valid = true
										--print(context.other_consumeable.ability.hand_types[i])
										break
									end
								end
							end
						end
						if valid then
							if (SMODS.Mods["incantation"] or {}).can_load then
								if v.ability.qty and v.ability.qty > 1 then
									Emult = (Emult * card.ability.extra.Emult)^v.ability.qty
								else
									Emult = (Emult * card.ability.extra.Emult)
								end				
							else
								Emult = (Emult * card.ability.extra.Emult)
							end
							
						end
					end			
				end
			end
			card.joker_display_values.Emult = Emult
			card.joker_display_values.localized_text = "(" .. localize("k_planet") .. ")"
			-- if Card.get_gameset(card) ~= "modest" then
            --     odds = localize { type = 'variable', key = "jdis_odds", vars = { cry_prob(2 or card.ability.cry_prob * 2,card.ability.extra.odds,card.ability.cry_rigged) or 2, card.ability.extra.odds } }
            -- end
			-- card.joker_display_values.odds = odds
			--Only display poker hand if in modest
			if text ~= 'Unknown' and text ~= 'NULL' and Card.get_gameset(card) == "modest" then
				card.joker_display_values.localized_text_poker_hand = text .. ' '
			else
				card.joker_display_values.localized_text_poker_hand = " "
			end
			
		end,
	}
end