--detrimentals:
--XCHIPS IS NOT VANILLAAA!!!!!!!!
JokerDisplay.Definitions["j_unik_xchips_hater"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
    },
    calc_function = function(card)
        local text = ""
        text = "(" .. card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit .. ")"
        card.joker_display_values.localized_text = text
    end
}

JokerDisplay.Definitions["j_unik_robert"] = {
    reminder_text = {
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ") ", scale = 0.3, colour = G.C.GREEN },
	},
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end,
}
JokerDisplay.Definitions["j_unik_happiness"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.joker_display_values",              ref_value = "cards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "min_cards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit",colour = G.C.UNIK_SHITTY_EDITION },
        { text = ")" },
    },
    calc_function = function(card)
        local hand = JokerDisplay.current_hand
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
        local cards = 0
        for i,v in pairs(scoring_hand) do
            if v.edition and v.edition.positive then
                cards = cards + 1
            end
        end
        card.joker_display_values.cards = cards
        card.joker_display_values.suit = localize("k_unik_positive")
    end,
}

JokerDisplay.Definitions["j_unik_decaying_tooth"] = {
    text = {
        { text = "-$" ,colour = G.C.GOLD},
        { ref_table = "card.joker_display_values",              ref_value = "money",colour = G.C.GOLD },
    },
    calc_function = function(card)
        local hand = JokerDisplay.current_hand
        card.joker_display_values.money = hand and #hand * card.ability.extra.cash_loss or 0
    end,
}

JokerDisplay.Definitions["j_unik_the_plant"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.ability.extra",              ref_value = "faceCards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "minFaceCards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit",colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize("k_face_cards")
    end,
}

JokerDisplay.Definitions["j_unik_goading_joker"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.ability.extra",              ref_value = "cards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "minCards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[card.ability.extra.suit], 0.35)
        end
    end,
}

JokerDisplay.Definitions["j_unik_broken_window"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.ability.extra",              ref_value = "cards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "minCards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[card.ability.extra.suit], 0.35)
        end
    end,
}

JokerDisplay.Definitions["j_unik_caveman_club"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.ability.extra",              ref_value = "cards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "minCards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[card.ability.extra.suit], 0.35)
        end
    end,
}

JokerDisplay.Definitions["j_unik_headless_joker"] = {
    text = {
        { text = "(" ,colour = G.C.UI.TEXT_INACTIVE},
        { ref_table = "card.ability.extra",              ref_value = "cards",colour = G.C.ORANGE },
        { text = "/",colour = G.C.ORANGE },
        { ref_table = "card.ability.extra", ref_value = "minCards",colour = G.C.ORANGE },
        { text = ")", colour = G.C.UI.TEXT_INACTIVE },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize(card.ability.extra.suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[card.ability.extra.suit], 0.35)
        end
    end,
}

JokerDisplay.Definitions["j_unik_vampiric_hammer"] = {
    reminder_text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "counter",
            retrigger_type = "mult",
            colour = G.C.FILTER,
        },	
    },
    calc_function = function(card)
        card.joker_display_values.counter = "(" .. card.ability.extra.enhanced_cards .. "/" .. card.ability.extra.min_enhanced_cards .. ")"
    end
}

JokerDisplay.Definitions["j_unik_monster_spawner"] = {
    text = {
        {
            border_nodes = {
                { ref_table = "card.joker_display_values", ref_value = "localized_text"},
            },
            border_colour = HEX("474931"),
        }
        
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. card.ability.extra.jokers_spawned .. "/" .. card.ability.extra.max_jokers .. ")"

    end
}

JokerDisplay.Definitions["j_unik_impounded"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "x_mult",
                    retrigger_type = "exp"
                },
            },
            border_colour = G.C.MULT,
        },
    },
    reminder_text = {
        { text = "(" },
        { text = "$",         colour = G.C.GOLD },
        { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
        { text = ")" },
    },
    reminder_text_config = { scale = 0.35 }
}
JokerDisplay.Definitions["j_unik_hook_n_discard"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
    },
    reminder_text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "stuff",
            colour = G.C.UI.TEXT_INACTIVE,
        },		
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. card.ability.extra.current_discards .. "/" .. card.ability.extra.min_discards .. ")"
        card.joker_display_values.stuff = "(2X " .. localize("k_unik_cards") ..")"
    end
}

JokerDisplay.Definitions["j_unik_handcuffs"] = {
    text = {
        { text = "(" },
        {
            ref_table = "card.ability.extra",
            ref_value = "min",
        },
        { text = " <= " },
        {
            ref_table = "card.joker_display_values",
            ref_value = "hand_size",
        },
        { text = " <= " },
        {
            ref_table = "card.ability.extra",
            ref_value = "max",
        },
        { text = ")" },
    },
    text_config = { colour = G.C.FILTER },
    calc_function = function(card)
        card.joker_display_values.hand_size = G.hand and G.hand.config.card_limit or "NIL"
    end
}

JokerDisplay.Definitions["j_unik_broken_scale"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
    },
    calc_function = function(card)
        local text = ""
        text = "(" .. card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit .. ")"
        card.joker_display_values.localized_text = text
    end
}

JokerDisplay.Definitions["j_unik_broken_scale"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
    },
    calc_function = function(card)
        local text = ""
        text = "(" .. card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit .. ")"
        card.joker_display_values.localized_text = text
    end
}

JokerDisplay.Definitions["j_unik_broken_arm"] = {
    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "level_down",
            retrigger_type = "mult",
            colour = G.C.RED,
        },
    },
    reminder_text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "level_ones",
            retrigger_type = "mult",
            colour = G.C.FILTER,
        },	
    },
    calc_function = function(card)
        local levelDown = ""
        local text, _, scoring_hand = JokerDisplay.evaluate_hand() --get poker hand
        if text ~= 'Unknown' and text ~= 'NULL' then
            if to_big(G.GAME.hands[text].level) > to_big(1) then
                levelDown = "-" .. card.ability.extra.decrease .. " " .. localize("k_level_prefix")
            end
        end
        card.joker_display_values.level_ones = "(" .. card.ability.extra.level1 .. "/" .. card.ability.extra.maxLevel1 .. ")"
        card.joker_display_values.level_down = levelDown
    end
}

JokerDisplay.Definitions["j_unik_border_wall"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
    },
    calc_function = function(card)
        local text = ""
        if not card.ability.cry_absolute or not G.GAME.blind.in_blind then
            text = "(" .. G.GAME.chips .. "/" .. G.GAME.blind.chips * card.ability.extra.exceeds .. ")"
        end
        card.joker_display_values.localized_text = text
    end
}