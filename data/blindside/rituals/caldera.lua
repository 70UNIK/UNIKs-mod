--create two summit cards, but 2 selected blinds lose bonuses based on summit cards generated.

SMODS.Consumable {
    key = 'unik_blindside_caldera',
    set = 'bld_obj_ritual',
    atlas = 'unik_blindside_consumables',
	pos = { x = 2, y = 1 },
    config = {
        extra = {
            cards = 2,
            blinds = 2,
            mult = 2,
            chips = 15,
        },
    },
    use = function(self, card, area)
        for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ set = 'unik_summit' })
                    card:juice_up(0.3, 0.5)
                end
            return true end }))
        end
        local cards = UNIK.get_sorted_by_position(G.hand)
        for key, highlighted in pairs(cards) do
            G.E_MANAGER:add_event(Event({
                func = (function()
                
                        highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] or 0
                                highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] - card.ability.extra.chips
                    G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            func = function()
                                card:juice_up(0.3, 0.5)
                                play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                                return true
                            end
                        }))
                        card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = "a_chips",
                                vars = { number_format(highlighted.ability["perma_bonus"]) },
                            }),
                            colour = G.C.CHIPS,
                            card=highlighted,
                            delay = 0.5,
                        })
                           highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] or 0
                            highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] - card.ability.extra.chips
                    G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            func = function()
                                card:juice_up(0.3, 0.5)
                                play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                                return true
                            end
                        }))
                        card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = "a_chips",
                                vars = { number_format(highlighted.ability["perma_h_chips"]) },
                            }),
                            colour = G.C.CHIPS,
                            card=highlighted,
                            delay = 0.5,
                        })
                        highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] or 0
                        highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] - card.ability.extra.mult
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            func = function()
                                card:juice_up(0.3, 0.5)
                                play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                                return true
                            end
                        }))
                        card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = "a_mult",
                                vars = { number_format(highlighted.ability["perma_mult"]) },
                            }),
                            colour = G.C.MULT,
                            card=highlighted,
                            delay = 0.5,
                        })
                        highlighted.ability["perma_h_mult"] = highlighted.ability["perma_h_mult"] or 0
                        highlighted.ability["perma_h_mult"] = highlighted.ability["perma_h_mult"] - card.ability.extra.mult
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            func = function()
                                card:juice_up(0.3, 0.5)
                                play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                                return true
                            end
                        }))
                        card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = "a_mult",
                                vars = { number_format(highlighted.ability["perma_h_mult"]) },
                            }),
                            colour = G.C.MULT,
                            card=highlighted,
                            delay = 0.5,
                        })


                    return true
                end)
            }))
            delay(0.1)
        end
        delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards,card.ability.extra.blinds,card.ability.extra.mult,card.ability.extra.chips
            }
        }
    end,
    can_use = function(self, card)
        if G.hand and G.hand.highlighted and #G.hand.highlighted == math.floor(card.ability.extra.blinds) then
                    return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or
            (card.area == G.consumeables)
        end
        return false
    end
}