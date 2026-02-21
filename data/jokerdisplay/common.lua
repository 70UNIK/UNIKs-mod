JokerDisplay.Definitions["j_unik_1_5_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER,scale = 0.3},
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local hand = JokerDisplay.current_hand
        card.joker_display_values.mult = hand and #hand > 0 and #hand >= card.ability.immutable.hand_size and
            card.ability.extra.mult + card.ability.extra.mult_mod * (#hand - card.ability.immutable.hand_size) or 0
        card.joker_display_values.localized_text = (hand and #hand > 0 and #hand >= card.ability.immutable.hand_size and "(" .. #hand .. ' ' .. localize('k_unik_cards') .. ")") or ''
    end
}
JokerDisplay.Definitions["j_unik_gt710"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text",scale = 0.3 },
    },
    calc_function = function(card)
        local ten_count = 0
        local seven_count = 0
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
        if text ~= "Unknown" then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() then
                    if scoring_card:get_id() == 10 then
                        ten_count = ten_count + 1
                    elseif scoring_card:get_id() == 7 then
                        seven_count = seven_count + 1
                    end
                end
            end
        end
        card.joker_display_values.dollars = ten_count > 0 and seven_count > 0 and card.ability.extra.money or 0
        card.joker_display_values.localized_text = "(10 + 7)"
    end,
}
JokerDisplay.Definitions["j_unik_noon"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.x_mult = G.GAME and G.GAME.current_round.hands_played ~= 0 and G.GAME.current_round.hands_left > 0 and card.ability.extra.x_mult or 1
    end
}
JokerDisplay.Definitions["j_unik_up_n_go"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.ability.immutable",              ref_value = "rounds" },
            { text = "/" },
            { ref_table = "card.joker_display_values", ref_value = "start_count" },
            { text = ")" },
        },
        calc_function = function(card)
            card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.immutable.rounds
        end,
        style_function = function(card, text, reminder_text, extra)
            local children = reminder_text and reminder_text.children
            if not children then return end

            local colour = (card.ability.immutable.rounds == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
            for i = 2, 4 do
                local child = children[i]
                if child then child.config.colour = colour end
            end
        end,
}
JokerDisplay.Definitions["j_unik_golden_glove"] = {
    text = {
        { text = "$" , colour = G.C.GOLD},
        { ref_table = "card.ability.extra", ref_value = "cash", retrigger_type = "mult", colour = G.C.GOLD }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values",ref_value = "typer", colour = G.C.CHIPS },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.typer = localize('k_unik_hands_lost')
    end,
}
JokerDisplay.Definitions["j_unik_instant_gratification"] = {
    text = {
        { text = "$" , colour = G.C.GOLD},
        { ref_table = "card.ability.extra", ref_value = "cash", retrigger_type = "mult", colour = G.C.GOLD }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values",ref_value = "typer", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.typer = localize('k_unik_discards_lost')
    end,
}
JokerDisplay.Definitions["j_unik_landfill"] = {
    text = {
        { text = "+" , colour = G.C.CHIPS},
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS }
    },
}
JokerDisplay.Definitions["j_unik_skipping_stones"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE, retrigger_type = "mult" },
            { text = ")" },
        }

    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return SMODS.has_no_suit(playing_card) and SMODS.has_no_rank(playing_card) and JokerDisplay.in_scoring(playing_card, scoring_hand) and
            math.min(joker_card.ability.extra.retriggers,joker_card.ability.immutable.max_retriggers) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("k_unik_rankless_suitless")
    end
}
JokerDisplay.Definitions["j_unik_welfare_payment"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local amount = math.floor(math.max(G.GAME.interest_cap - G.GAME.dollars,0) / card.ability.extra.dollar_mod)
        if G.GAME.modifiers.no_interest then
            amount = 0
        end
        card.joker_display_values.money = amount
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
JokerDisplay.Definitions["j_unik_lucky_seven"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
        { ref_table = "card.joker_display_values", ref_value = "moneyMin", retrigger_type = "mult" , colour = G.C.GOLD },
        { text = " $" , colour = G.C.GOLD},
        { ref_table = "card.joker_display_values", ref_value = "moneyMax", retrigger_type = "mult" , colour = G.C.GOLD },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
     extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local mult = 0
        local moneyMax = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, card.ability.extra.odds2, card.ability.extra.odds_money, 'unik_lucky_seven_cash')
        if new_numerator2 < new_denominator2 then
            card.joker_display_values.moneyMin = " $" .. 0 .. " -"
        else
            card.joker_display_values.moneyMin = ""
        end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { new_numerator2, new_denominator2  } }
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() == 7 then
                    mult = mult +
                        card.ability.extra.mult *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    moneyMax = moneyMax + card.ability.extra.p_dollars *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.moneyMax = moneyMax
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = "(7)"
    end
}
JokerDisplay.Definitions["j_unik_violent_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        {
            ref_table = "card.joker_display_values",
            ref_value = "localized_text",
        },
        { text = ")" },
    },
    calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit(card.ability.extra.suit) then
                    mult = mult +
                        card.ability.extra.mult *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        local suit_node = reminder_text and reminder_text.children and reminder_text.children[2]
        if suit_node then suit_node.config.colour = lighten(G.C.SUITS["unik_Crosses"], 0.35) end
    end
}
JokerDisplay.Definitions["j_unik_treacherous_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        {
            ref_table = "card.joker_display_values",
            ref_value = "localized_text",
        },
        { text = ")" },
    },
    calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit(card.ability.extra.suit) then
                    mult = mult +
                        card.ability.extra.mult *
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        local suit_node = reminder_text and reminder_text.children and reminder_text.children[2]
        if suit_node then suit_node.config.colour = lighten(G.C.SUITS["unik_Noughts"], 0.35) end
    end
}
JokerDisplay.Definitions["j_unik_zealous_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local mult = 0
        local _, poker_hands, _ = JokerDisplay.evaluate_hand()
        if poker_hands[card.ability.extra.type] and next(poker_hands[card.ability.extra.type]) then
            mult = card.ability.extra.t_mult
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = localize(card.ability.extra.type, 'poker_hands')
    end
}
JokerDisplay.Definitions["j_unik_lurid_joker"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local chips = 0
        local _, poker_hands, _ = JokerDisplay.evaluate_hand()
        if poker_hands[card.ability.extra.type] and next(poker_hands[card.ability.extra.type]) then
            chips = card.ability.extra.t_chips
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = localize(card.ability.extra.type, 'poker_hands')
    end
}