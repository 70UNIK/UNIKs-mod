--reggie, aquamarine, railroad, blossom, mirror maze

JokerDisplay.Definitions["j_unik_blossom"] = {
    rescore_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        local first_card = scoring_hand and JokerDisplay.calculate_leftmost_card(scoring_hand)
        local last_card = scoring_hand and JokerDisplay.calculate_rightmost_card(scoring_hand)
        local total = 0
        total = total + (first_card and playing_card == first_card and
            math.min(joker_card.ability.extra.left_rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0)
        total = total +  (last_card and playing_card == last_card and
            math.min(joker_card.ability.extra.right_rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0)
        return total
       
    end,
}
JokerDisplay.Definitions["j_unik_hall_of_mirrors"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE, retrigger_type = "mult" },
            { text = ")" },
        }

    },
    rescore_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return SMODS.has_enhancement(playing_card,'m_glass') and JokerDisplay.in_scoring(playing_card, scoring_hand) and
                math.min(joker_card.ability.extra.rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("k_glass")
    end
}

JokerDisplay.Definitions["j_unik_reggie"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.UNIK_UNIK, retrigger_type = "mult" },
            { text = ")" },
        }
    },
    rescore_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return SMODS.has_enhancement(playing_card,'m_unik_pink') and JokerDisplay.in_scoring(playing_card, scoring_hand) and
                math.min(joker_card.ability.extra.rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("k_unik_pink")
    end
}

JokerDisplay.Definitions["j_unik_railroad_crossing"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "railroad_suit0" },
            { text = ")" },
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "railroad_suit1" },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "railroad_suit2" },
        { text = ")" },
    },
    rescore_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return SMODS.is_suit('unik_Crosses') and JokerDisplay.in_scoring(playing_card, scoring_hand) and
                math.min(joker_card.ability.extra.rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)

        card.joker_display_values.railroad_suit0 = localize('unik_Crosses', 'suits_plural')
        card.joker_display_values.railroad_suit1 = localize(G.GAME.unik_saved_suits_railroad[1], 'suits_plural')
        card.joker_display_values.railroad_suit2 = localize(G.GAME.unik_saved_suits_railroad[2], 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children[1] and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = lighten(G.C.SUITS['unik_Crosses'], 0.35)
        end
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.unik_saved_suits_railroad[1]], 0.35)
        end
        if reminder_text and reminder_text.children[4] then
            reminder_text.children[4].config.colour = lighten(G.C.SUITS[G.GAME.unik_saved_suits_railroad[2]], 0.35)
        end
    end
}

--aquamarine: (cards) X (noughts), 1 in 2 NOT
JokerDisplay.Definitions["j_unik_aquamarine"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x ",                              scale = 0.35 },
        { ref_table = "card.joker_display_values", ref_value = "rescores", retrigger_type = "mult" },
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "aquamarine_suit" },
            { text = ")" },
        }
    },
	reminder_text = {
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ") ", scale = 0.3, colour = G.C.GREEN },
        { ref_table = "card.joker_display_values", ref_value = "not_", scale = 0.3, colour = G.C.RED },
	},
    rescore_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return SMODS.is_suit('unik_Noughts') and JokerDisplay.in_scoring(playing_card, scoring_hand) and 
        SMODS.pseudorandom_probability(joker_card, 'unik_aquamarine_resc2', joker_card.ability.extra.base_odds, joker_card.ability.extra.odds, 'unik_aquamarine_resc2') and
                math.min(joker_card.ability.extra.rescore,joker_card.ability.immutable.max_rescores) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit("unik_Noughts") then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.aquamarine_suit = localize('unik_Noughts', 'suits_plural')
        card.joker_display_values.count = count 
        card.joker_display_values.rescores = localize('k_unik_rescores')
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base_odds, card.ability.extra.odds, 'unik_aquamarine_resc')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        card.joker_display_values.not_ = localize('k_unik_not')
    end,
    style_function = function(card, text, reminder_text, extra)
        if extra and extra.children[1] and extra.children[1].children and extra.children[1].children[2] then
            extra.children[1].children[2].config.colour = lighten(G.C.SUITS['unik_Noughts'], 0.35)
        end
    end
}