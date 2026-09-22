--all ancient rarity jokers
JokerDisplay.Definitions["j_unik_niko"] = {
    text = {
        { text = "(", colour = G.C.TEXT_INACTIVE },
        { ref_table = "card.joker_display_values", ref_value = "active_text" },
        { text = ")" , colour = G.C.TEXT_INACTIVE },
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text",retrigger_type = "mult", colour = G.C.UNIK_LIGHT_SUIT },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = G.GAME.current_round.hands_played == 0
        card.joker_display_values.active_text = localize("jdis_" ..
            (card.joker_display_values.is_active and "active" or "inactive"))
        card.joker_display_values.localized_text = "(" .. localize('k_light_suits') .. ")"
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children and text.children[2] then
            text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                G.C.UI.TEXT_INACTIVE
        end
        if text.children[1] then
                text.children[1].config.colour = G.C.UI.TEXT_INACTIVE
            end
            if text.children[3] then
                    text.children[3].config.colour = G.C.UI.TEXT_INACTIVE
                end
    end
}
JokerDisplay.Definitions["j_unik_sundae_cookie"] = {
    text = {
        { text = "(" , colour = G.C.TEXT_INACTIVE},
        { ref_table = "card.joker_display_values", ref_value = "active_text" },
        { text = ")", colour = G.C.TEXT_INACTIVE },
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text",retrigger_type = "mult", colour = G.C.UNIK_DARK_SUIT },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = ((G.GAME.current_round.hands_left == 1 and not next(G.play.cards)) or
        (G.GAME.current_round.hands_left == 0 and next(G.play.cards))) or
            next(find_joker("cry-panopticon")) or next(find_joker("j_paperback_the_world"))
        card.joker_display_values.active_text = localize("jdis_" ..
            (card.joker_display_values.is_active and "active" or "inactive"))
        card.joker_display_values.localized_text = "(" .. localize('k_dark_suits') .. ")"
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children and text.children[2] then
            text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                G.C.UI.TEXT_INACTIVE
        end
        if text.children[1] then
                text.children[1].config.colour = G.C.UI.TEXT_INACTIVE
            end
            if text.children[3] then
                    text.children[3].config.colour = G.C.UI.TEXT_INACTIVE
                end
    end
}
--TODO, redo niko and sundae to be based of last tile
JokerDisplay.Definitions["j_unik_unik"] = {
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.joker_display_values", ref_value = "Echips", retrigger_type = "exp" }
            },
            border_colour = SMODS.Gradients.unik_echips,
        }
    },
    calc_function = function(card)
        card.joker_display_values.Echips = card.ability.extra.Echips + 1
    end
}
JokerDisplay.Definitions["j_unik_white_lily_cookie"] = {
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.joker_display_values", ref_value = "Emult", retrigger_type = "exp" }
            },
            border_colour = SMODS.Gradients.unik_emult,
        }
    },
    calc_function = function(card)
        card.joker_display_values.Emult = card.ability.extra.Emult + 1
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

