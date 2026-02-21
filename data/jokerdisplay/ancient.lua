--all ancient rarity jokers
JokerDisplay.Definitions["j_unik_niko"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "niko_card_suit" },
        { text = ")" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local suits = getDominantSuit('light')
        local suit = G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts"
        if suits and #suits == 1 then
            suit = suits[1]
        end
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit(suit) then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.x_mult ^ count
        card.joker_display_values.niko_card_suit = localize(suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suits = getDominantSuit('light')
            local suit = G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts"
            if suits and #suits == 1 then
                suit = suits[1]
            end
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
    end
}
JokerDisplay.Definitions["j_unik_sundae_cookie"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "sundae_card_suit" },
        { text = ")" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local suits = getDominantSuit('dark')
        local suit = G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades"
        if suits and #suits == 1 then
            suit = suits[1]
        end
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit(suit) then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.x_mult ^ count
        card.joker_display_values.sundae_card_suit = localize(suit, 'suits_plural')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            local suits = getDominantSuit('dark')
            local suit = G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades"
            if suits and #suits == 1 then
                suit = suits[1]
            end
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[suit], 0.35)
        end
    end
}
JokerDisplay.Definitions["j_unik_unik"] = {
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.joker_display_values", ref_value = "Echips", retrigger_type = "exp" }
            },
            border_colour = G.C.DARK_EDITION,
        }
    },
    calc_function = function(card)
        card.joker_display_values.Echips = card.ability.extra.Echips + card.ability.immutable.base_echips
    end
}
JokerDisplay.Definitions["j_unik_white_lily_cookie"] = {
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.joker_display_values", ref_value = "Emult", retrigger_type = "exp" }
            },
            border_colour = G.C.DARK_EDITION,
        }
    },
    calc_function = function(card)
        card.joker_display_values.Emult = card.ability.extra.Emult + card.ability.immutable.base_emult
    end
}
JokerDisplay.Definitions["j_unik_moonlight_cookie"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            },
            border_colour = G.C.MULT,
        }
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            if text and text ~= 'NULL' and G.GAME.hands[text] then
                 card.joker_display_values.x_mult = G.GAME.hands[text].mult
            end
        else
            card.joker_display_values.x_mult = 1
        end
    end,
}

