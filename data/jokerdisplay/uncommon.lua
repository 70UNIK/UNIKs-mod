
--multesers (really tricky)

JokerDisplay.Definitions["j_unik_multesers"] = {
    text = {
        { text = "<=+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
            end
        end
        card.joker_display_values.mult = card.ability.extra.mult * count
    end
}

function autoIncrementValue(start,count,mod,cap,type,before)
    local amount = 0 and type == 'mult' or 1
    local increment = start
    for i = 1, count do
        if mod > 0 and (not cap or increment < cap) then
            if before then
                increment = increment + mod
            end
            if type == 'mult' then
                amount = amount + increment 
            else
                amount = amount * increment
            end
            if not before then
                increment = increment + mod
            end
            
        elseif mod < 0 and (not cap or increment > cap) then
            if before then
                increment = increment + mod
            end
            if type == 'mult' then
                amount = amount + increment 
            else
                amount = amount * increment
            end
            if not before then
                increment = increment + mod
            end
        end
    end
    return amount
end
JokerDisplay.Definitions["j_unik_chipzel"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
            },
            border_colour = G.C.CHIPS,
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = ")" },
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_enhancement(scoring_card,'m_bonus') then
                                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end

            end
        end
        card.joker_display_values.x_chips = autoIncrementValue(card.ability.extra.x_chips,count,card.ability.extra.x_chip_mod,nil,'exp',true)
        card.joker_display_values.localized_text = localize("k_bonus_cards")
    end
}
JokerDisplay.Definitions["j_unik_brownie"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
            end
        end
        card.joker_display_values.x_mult = autoIncrementValue(card.ability.extra.x_mult,count,-card.ability.extra.x_mult_mod,1,'exp',true)
    end,
}

JokerDisplay.Definitions["j_unik_base_camp"] = {
		extra = {
            {
				{ text = "+$", colour = G.C.GOLD },
				{ ref_table = "card.joker_display_values", ref_value = "dollars", colour = G.C.GOLD },
				{
					ref_table = "card.joker_display_values",
					ref_value = "localized_text",
					colour = G.C.UI.TEXT_INACTIVE,
					scale = 0.3,
				},
			},
            {
				{
					border_nodes = {
						{ ref_table = "card.joker_display_values", ref_value = "e_chips", retrigger_type = "exp" },
					},
					border_colour = G.C.DARK_EDITION,
				},
				{ text = " " },
				{
					border_nodes = {
						{ ref_table = "card.joker_display_values", ref_value = "e_mult", retrigger_type = "exp" },
					},
                    border_colour = G.C.DARK_EDITION,
				},
			},
			{
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" },
					},
					border_colour = G.C.CHIPS,
				},
				{ text = " " },
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
					},
				},
			},
            {
                { text = "+", colour = G.C.CHIPS },
                { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
                { text = " +", colour = G.C.MULT },
                { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT, retrigger_type = "mult" },
            },
		},
		calc_function = function(card)
			card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
            if G.GAME and not G.GAME.unik_base_camp_bonus then
                G.GAME.unik_base_camp_bonus = {
                    e_mult = 0,
                    e_chips = 0,
                    chips = 0,
                    mult = 0,
                    dollars = 0,
                    x_mult = 0,
                    x_chips = 0,
                }
            end
            for i,v in pairs(G.GAME.unik_base_camp_bonus) do
                if (i == 'e_mult' or i == 'e_chips') then
                    if v <= 0 then
                        card.joker_display_values[i] = ""
                    else
                        card.joker_display_values[i] = "^" .. 1 + v
                    end
                elseif (i == 'x_mult' or i == 'x_chips') then
                    card.joker_display_values[i] = 1 + v
                else
                    card.joker_display_values[i] = v
                end
                
            end
            
            
		end,
}

JokerDisplay.Definitions["j_unik_malicious_face"] = {
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "loyalty_text" },
            { text = ")" },
        },
    calc_function = function(card)
        if G.GAME.blind and G.GAME.blind.in_blind and G.GAME.blind.boss then
            card.joker_display_values.is_active = true
        else
            card.joker_display_values.is_active = false
        end
        
        card.joker_display_values.loyalty_text = localize(card.joker_display_values.is_active and 'k_active_ex' or 'k_inactive_ex')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.ORANGE or
                G.C.UI.TEXT_INACTIVE
        end
    end
}
JokerDisplay.Definitions["j_unik_borg_cube"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "held",
                    retrigger_type = "exp"
                },
            },
            border_colour = G.C.MULT,
        },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
        { text = "x" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.DARK_EDITION },
        { text = ")" },
    },
    calc_function = function(card)
        local count = 0
        local held = 0
        if G.jokers then
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card ~= card and joker_card.edition and joker_card.edition.unik_steel then
                    count = count + 1
                end
            end
        end
        if G.hand then
            for i,v in pairs(G.hand.cards) do
                if v.edition and v.edition.unik_steel then
                    count = count+1
                    held = held + 1
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.held = card.ability.extra.xmult^held
        card.joker_display_values.localized_text = localize("k_unik_steel")
    end,
    mod_function = function(card, mod_joker)
        return { x_mult = (card.edition and card.edition.unik_steel and mod_joker.ability.extra.xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
    end
}
JokerDisplay.Definitions["j_unik_pink_salt"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.UNIK_SUMMIT },
    extra = {
        {
            { text = "(" ,colour = G.C.GREEN},
            { ref_table = "card.joker_display_values", ref_value = "odds" ,colour = G.C.GREEN},
            { text = ") " ,colour = G.C.GREEN},
            { ref_table = "card.joker_display_values", ref_value = "not_", scale = 0.3, colour = G.C.RED },
        }
    },
    extra_config = {scale = 0.3 },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit('unik_Crosses') then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base_odds, card.ability.extra.odds, 'unik_pink_salt_summit')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        card.joker_display_values.not_ = localize('k_unik_not')
    end
}

JokerDisplay.Definitions["j_unik_mountain_dew"] = {
     reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",              ref_value = "triggers" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.triggers
    end,
    style_function = function(card, text, reminder_text, extra)
        local children = reminder_text and reminder_text.children
        if not children then return end

        local colour = (card.ability.extra.triggers == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
        for i = 2, 4 do
            local child = children[i]
            if child then child.config.colour = colour end
        end
    end,
}

JokerDisplay.Definitions["j_unik_road_sign"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.UNIK_SUMMIT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text_ace",      colour = G.C.ORANGE },
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text_straight", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local is_superposition = false
        local _, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        if poker_hands["Straight"] and next(poker_hands["Straight"]) then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and scoring_card:get_id() == 10 then
                    is_superposition = true
                end
            end
        end
        card.joker_display_values.count = is_superposition and 1 or 0
        card.joker_display_values.localized_text_straight = localize('Straight', "poker_hands")
        card.joker_display_values.localized_text_ace = '10'
    end
}

JokerDisplay.Definitions["j_unik_tax_haven"] = {
    text = {
        { text = "-$" },
        { ref_table = "card.ability.extra", ref_value = "cash_loss", retrigger_type = "mult" }
    },
    reminder_text = {
        { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE, retrigger_type = "mult" },
        { text = ")" }
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("k_unik_sticker_remove")
    end
}

JokerDisplay.Definitions["j_unik_rainbow_river"] = {
     reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",              ref_value = "triggers" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.triggers
    end,
    style_function = function(card, text, reminder_text, extra)
        local children = reminder_text and reminder_text.children
        if not children then return end

        local colour = (card.ability.extra.triggers == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
        for i = 2, 4 do
            local child = children[i]
            if child then child.config.colour = colour end
        end
    end,
}

JokerDisplay.Definitions["j_unik_stamp_spam"] = {
     reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",              ref_value = "triggers" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.triggers
    end,
    style_function = function(card, text, reminder_text, extra)
        local children = reminder_text and reminder_text.children
        if not children then return end

        local colour = (card.ability.extra.triggers == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
        for i = 2, 4 do
            local child = children[i]
            if child then child.config.colour = colour end
        end
    end,
}


JokerDisplay.Definitions["j_unik_preservatives"] = {
     reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",              ref_value = "jokers" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.jokers
    end,
    style_function = function(card, text, reminder_text, extra)
        local children = reminder_text and reminder_text.children
        if not children then return end

        local colour = (card.ability.extra.jokers == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
        for i = 2, 4 do
            local child = children[i]
            if child then child.config.colour = colour end
        end
    end,
}

JokerDisplay.Definitions["j_unik_cobblestone"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
            },
            border_colour = G.C.CHIPS,
        }
    },
    reminder_text = {
        { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE, retrigger_type = "mult" },
        { text = ")" }
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_no_rank(scoring_card) and SMODS.has_no_suit(scoring_card) then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_chips = card.ability.extra.x_chips ^ count
        card.joker_display_values.localized_text = localize("k_unik_rankless_suitless")
    end,
}
JokerDisplay.Definitions["j_unik_D16"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions["j_unik_fat_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        card.joker_display_values.mult = math.max(0,(#G.playing_cards - math.ceil(G.GAME.starting_deck_size/2)) * card.ability.extra.card)
    end
}
JokerDisplay.Definitions["j_unik_euclid"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and scoring_card:get_id() == 2 or scoring_card:get_id() == 3 or scoring_card:get_id() == 5
                    or scoring_card:get_id() == 7 or scoring_card:get_id() == 14 then
                    mult = mult +
                        card.ability.extra.chips *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.chips = mult
        card.joker_display_values.localized_text = "(" .. localize("Ace", "ranks") .. ",2,3,5,7)"
    end
}

JokerDisplay.Definitions["j_unik_pink_guard"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
}
JokerDisplay.Definitions["j_unik_uniku"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.UNIK_UNIK, retrigger_type = "mult" },
            { text = ")" },
        }

    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return playing_card:get_id() == 7 and JokerDisplay.in_scoring(playing_card, scoring_hand) and
            joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        card.joker_display_values.localized_text = "7"
    end
}
JokerDisplay.Definitions["j_unik_vessel_kiln"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "x_chips",
                    retrigger_type = "exp"
                },
            },
            border_colour = G.C.CHIPS,
        },
    },
}
JokerDisplay.Definitions["j_unik_cube_joker"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "x_chips",
                    retrigger_type = "exp"
                },
            },
            border_colour = G.C.CHIPS,
        },
    },
}
JokerDisplay.Definitions["j_unik_no_standing_zone"] = {
    text = {
        {
            border_nodes = {
                { text = "X" ,scale = 0.6},
                {
                    ref_table = "card.ability.extra",
                    ref_value = "x_mult",
                    retrigger_type = "exp",
                    scale = 0.6,
                },
            },
            border_colour = G.C.MULT,
        },
    },
    reminder_text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "warning",
            colour = G.C.RED,
        },		
    },
    calc_function = function(card)
        local warning = ""
        if card.ability.extra.x_mult < (1 + card.ability.extra.x_mult_mod*15) and card.ability.extra.x_mult > (1 + card.ability.extra.x_mult_mod*7.5) then
            if math.ceil(card.ability.extra.x_mult*10) % 2 == 0 then
                warning = localize('k_unik_hurry_up')
            end
        elseif card.ability.extra.x_mult <= (1 + card.ability.extra.x_mult_mod*7.5) then
            if math.ceil(card.ability.extra.x_mult*20) % 2 == 0 then
                warning = localize('k_unik_hurry_up2')
            end
        end
        card.joker_display_values.warning = warning
    end
}
JokerDisplay.Definitions["j_unik_recycler"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions["j_unik_riif_roof"] = {
    --literally copied from baseball card
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
        { text = "x" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.BLUE },
        { text = ")" },
    },
    calc_function = function(card)
        local count = 0
        if G.jokers then
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card.config.center.rarity and joker_card.config.center.rarity == 1 then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = localize("k_common")
    end,
    mod_function = function(card, mod_joker)
        return { x_mult = (card.config.center.rarity == 1 and mod_joker.ability.extra.Xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
    end
}