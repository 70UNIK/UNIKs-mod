--last tile
JokerDisplay.Definitions["j_unik_last_tile"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        
        if ((G.GAME.current_round.hands_left == 1 and not next(G.play.cards)) or
        (G.GAME.current_round.hands_left == 0 and next(G.play.cards))) or
            next(find_joker("cry-panopticon")) or next(find_joker("j_paperback_the_world")) then
            card.joker_display_values.is_active = true
            else
                card.joker_display_values.is_active = false
            end
        card.joker_display_values.active = card.joker_display_values.is_active and
            localize("k_active") or localize("k_inactive_ex")
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.DARK_EDITION or
                G.C.UI.TEXT_INACTIVE
        end
    end
}
JokerDisplay.Definitions["j_unik_ghost_trap"] = {
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
        { ref_table = "card.ability.extra",              ref_value = "limit" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.limit
    end,
    style_function = function(card, text, reminder_text, extra)
        local children = reminder_text and reminder_text.children
        if not children then return end

        local colour = (card.ability.extra.limit == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
        for i = 2, 4 do
            local child = children[i]
            if child then child.config.colour = colour end
        end
    end,
}

JokerDisplay.Definitions["j_unik_invisible_card"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.immutable", ref_value = "slots", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.DARK_EDITION },
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
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds, 'unik_invisible_card')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        card.joker_display_values.not_ = localize('k_unik_not')
    end
}

JokerDisplay.Definitions["j_unik_coupon_codes"] = {
    text = {
        { text = "(", colour =  G.C.UI.TEXT_INACTIVE },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.ORANGE  },
        { text = ")", colour =  G.C.UI.TEXT_INACTIVE },
    },
    calc_function = function(card)
        card.joker_display_values.active = 
            (card.ability.extra.purchased_cards .. "/" .. card.ability.extra.requirement)
    end,
}

JokerDisplay.Definitions["j_unik_foundation"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = card.ability.extra.hands >= card.ability.extra.threshold
        card.joker_display_values.active = card.joker_display_values.is_active and
            localize("k_active") or
            (card.ability.extra.hands .. "/" .. card.ability.extra.threshold)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.UNIK_ANCIENT or
                G.C.UI.TEXT_INACTIVE
        end
    end
}


JokerDisplay.Definitions["j_unik_antijoker"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = card.ability.extra.anti_rounds >= card.ability.extra.total_rounds
        card.joker_display_values.active = card.joker_display_values.is_active and
            localize("k_active") or
            (card.ability.extra.anti_rounds .. "/" .. card.ability.extra.total_rounds)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.DARK_EDITION or
                G.C.UI.TEXT_INACTIVE
        end
    end
}

JokerDisplay.Definitions["j_unik_kouign_amann_cookie"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
            },
        },
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text",retrigger_type = "mult", colour = G.C.ORANGE },
    },
    calc_function = function(card)
        local count = 0
        local hand = JokerDisplay.current_hand
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
        local existingSuits = {}
        local xmult = card.ability.extra.x_mult
         for i,v in pairs(scoring_hand) do
            if not SMODS.has_any_suit(v) then
                for j=1,#UNIK.light_suits do
                    if v:is_suit(UNIK.light_suits[j]) and not existingSuits[UNIK.light_suits[j]] then
                        xmult = xmult + card.ability.extra.x_mult_mod
                        existingSuits[UNIK.light_suits[j]] = true;
                        break
                    end
                end
            end
        end
        --then wilds
        for i,v in pairs(scoring_hand) do
            if SMODS.has_any_suit(v) then
                for j=1,#UNIK.light_suits do
                    if v:is_suit(UNIK.light_suits[j]) and not existingSuits[UNIK.light_suits[j]] then
                        xmult = xmult + card.ability.extra.x_mult_mod
                        existingSuits[UNIK.light_suits[j]] = true;
                        break
                    end
                end
            end
        end
        if text ~= "Unknown" then
            for _, scoring_card in pairs(scoring_hand) do
                if  UNIK.is_suit_type(scoring_card,'light') then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = xmult ^ count
        card.joker_display_values.localized_text = localize('k_light_suits')
    end,
}

JokerDisplay.Definitions["j_unik_earthmover"] = {
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
JokerDisplay.Definitions["j_unik_tic_tac"] = {
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


JokerDisplay.Definitions["j_unik_lone_despot"] = {
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.joker_display_values", ref_value = "e_mult", retrigger_type = "exp" },
            },
            border_colour = G.C.DARK_EDITION,
        },
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text",retrigger_type = "mult", colour = G.C.ORANGE },
    },
    calc_function = function(card)
        local count = 0
        local hand = JokerDisplay.current_hand
        if #hand == 1 then
            if hand[1]:get_id() == 13 then
                count = 1
            end
        end
        card.joker_display_values.e_mult = (card.ability.immutable.base_emult+ card.ability.extra.Emult) ^ count
        card.joker_display_values.localized_text = localize('k_single_king')
    end,
}

JokerDisplay.Definitions["j_unik_711"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" },
            },
            border_colour = G.C.CHIPS,
        },
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text",retrigger_type = "mult", colour = G.C.ORANGE },
    },
    calc_function = function(card)
        local count = 0
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
        if text ~= "Unknown" then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == 14 or scoring_card:get_id() == 7) then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_chips = card.ability.extra.x_chips ^ count
        card.joker_display_values.localized_text = "(7," .. localize("Ace", "ranks") .. ")"
    end,
}
JokerDisplay.Definitions["j_unik_poppy"] = {
    text = {
        {text = "(", colour = G.C.UI.TEXT_INACTIVE},
        {ref_table = "card.joker_display_values", ref_value = "calc",retrigger_type = "mult", colour = G.C.ORANGE },
        {text = " "},
        {ref_table = "card.joker_display_values", ref_value = "localize",retrigger_type = "mult", colour = G.C.ORANGE },
        {text = ")" , colour = G.C.UI.TEXT_INACTIVE},
    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        local retriggers = 0
        retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
        retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
        if held_in_hand then return 0 end
        local first_card = scoring_hand and JokerDisplay.calculate_rightmost_card(scoring_hand)
        return first_card and playing_card == first_card and
            retriggers * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end,
    calc_function = function(card)
        local retriggers = 0
        retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
        retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
        card.joker_display_values.calc = retriggers
        card.joker_display_values.localize = localize('k_retriggers')
    end
}
JokerDisplay.Definitions["j_unik_beaver"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "x_mult",
                    retrigger_type = "exp"
                },
            },
            border_colour = G.C.MULT,
        },
    },
    extra = {
        {
            {ref_table = "card.joker_display_values", ref_value = "count",retrigger_type = "mult" },
            {text = "X "},
            {
                border_nodes = {
                    { text = "Xlog_" },
                    {
                        ref_table = "card.joker_display_values",
                        ref_value = "base",
                        retrigger_type = "mult"
                    },
                    { text = "(Mult)" },
                },
                border_colour = G.C.MULT,
            },
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE, retrigger_type = "mult" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("k_timber_cards")
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.has_enhancement(playing_card,'m_unik_timber') then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.x_mult ^ count
        card.joker_display_values.count = count
        card.joker_display_values.base = card.ability.extra.base
    end
}
JokerDisplay.Definitions["j_unik_jsab_yokana"] = {
    mod_function = function(card, mod_joker)
        if card and card ~= mod_joker then
            return { x_chips = mod_joker.ability.extra.x_chips }
        end
        return {}
    end,
}

JokerDisplay.Definitions["j_unik_jsab_chelsea"] = {
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

JokerDisplay.Definitions["j_unik_copycat"] = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local rightmost_joker_key = G.jokers
            and G.jokers.cards[#G.jokers.cards]
            and G.jokers.cards[#G.jokers.cards] ~= card
            and G.jokers.cards[#G.jokers.cards].config.center.key
        card.joker_display_values.localized_text = rightmost_joker_key
                and localize({ type = "name_text", key = rightmost_joker_key, set = "Joker" })
            or ""
    end,
    retrigger_joker_function = function(card, retrigger_joker)
        return card ~= retrigger_joker and G.jokers.cards[#G.jokers.cards] == card and 1
            or 0
    end,
}

JokerDisplay.Definitions["j_unik_compounding_interest"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local amount =  math.max(math.floor(math.min(G.GAME.dollars*card.ability.extra.x_dollars,card.ability.immutable.cap)),0)
        card.joker_display_values.money = amount
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
JokerDisplay.Definitions["j_unik_pibby"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions["j_unik_catto_boi"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions["j_unik_epic_blind_sauce"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions["j_unik_the_dynasty"] = {
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
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local x_mult = 1
        local _, poker_hands, _ = JokerDisplay.evaluate_hand()
        if poker_hands[card.ability.extra.type] and next(poker_hands[card.ability.extra.type]) then
            x_mult = card.ability.extra.Xmult
        end
        card.joker_display_values.x_mult = x_mult
        card.joker_display_values.localized_text = localize(card.ability.extra.type, 'poker_hands')
    end
}