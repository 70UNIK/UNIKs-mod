--2 in 5 chance blinds in hand do not gain either X0.2 Chips, X0.2 Mult or $1, create a landslide tag
SMODS.Consumable {
    key = 'unik_blindside_erosion',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    can_use = function (self, card)
        if #G.hand.cards > 0 then
            return true
        end
        return false
    end,
    config = {extra = {base = 2, odds = 5,x_chips = 0.25, x_mult = 0.25, money = 1}},
    use = function(self, card, area)
        for key, highlighted in pairs(G.hand.cards) do
            if true then
                if pseudorandom(pseudoseed('unik_erosion_2')) > 0.66 then
                     G.E_MANAGER:add_event(Event({
                        trigger = 'before',

                        func = function()
                            highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] or 0
                            highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] + card.ability.extra.x_chips
                            card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                                    message = localize({
                                        type = "variable",
                                        key = "a_xchips",
                                        vars = { number_format(1+highlighted.ability["perma_x_chips"]) },
                                    }),
                                    colour = G.C.CHIPS,
                                    card=highlighted,
                                })
                            return true
                        end
                    }))
                   
                elseif pseudorandom(pseudoseed('unik_erosion_2')) > 0.33 then
           
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after', 
                            func = function()
                            highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] or 0
                            highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] + card.ability.extra.x_mult
                            card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                                message = localize({
                                    type = "variable",
                                    key = "a_xmult",
                                    vars = { number_format(1+highlighted.ability["perma_x_mult"]) },
                                }),
                                colour = G.C.MULT,
                                card=highlighted,
                            })
                            return true 
                            end 
                        }))
                else
                     G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                                highlighted.ability["perma_p_dollars"] = highlighted.ability["perma_p_dollars"] or 0
                                highlighted.ability["perma_p_dollars"] = highlighted.ability["perma_p_dollars"] + card.ability.extra.money
                                
                           card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                                    message = '$' .. highlighted.ability["perma_p_dollars"],
                                    colour = G.C.GOLD,
                                    card=highlighted,
                                })
                            return true
                        end
                    }))
                end
            end
        end
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_landslide'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_landslide']
        --local n,d = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,"unik_erosion")
        return {
            vars = {
                1,2,
                card.ability.extra.x_mult,card.ability.extra.x_chips,card.ability.extra.money
            }
        }
    end,
}