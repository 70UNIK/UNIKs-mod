JokerDisplay.Definitions["j_unik_extra_credit_alice"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            },
            border_colour = G.C.MULT,
        }
    },
}

JokerDisplay.Definitions["j_unik_megatron"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            },
            border_colour = G.C.MULT,
        }
    },
    extra = {
        {
            {
            border_nodes = {
                { text = "(^", colour = G.C.UNIK_EYE_SEARING_RED },
                { ref_table = "card.ability.immutable", ref_value = "blind_size", colour = G.C.UNIK_EYE_SEARING_RED, retrigger_type = "exp" },
                { text = ")", colour = G.C.UNIK_EYE_SEARING_RED}
            },
            border_colour = G.C.UNIK_VOID_COLOR,
        }
        },
        
    },
    extra_config = { scale = 0.3 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "loc", colour = G.C.ORANGE},
        { text = ")" }
    },
        calc_function = function(card)
        card.joker_display_values.loc = localize('k_unik_probability_fail')
    end
}