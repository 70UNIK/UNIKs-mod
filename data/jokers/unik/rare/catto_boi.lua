SMODS.Atlas {
	key = "unik_catto_boi",
	path = "unik_catto_boi.png",
	px = 71,
	py = 95
}

local catto_boi = {
	normal = {
		'k_unik_catto_boi_normal1',
		'k_unik_catto_boi_normal2',
		'k_unik_catto_boi_normal3',
        'k_unik_catto_boi_normal4',
	},
    torture = {
        'k_unik_catto_boi_why1',
        'k_unik_catto_boi_why2',
    }
}

SMODS.Joker {
    key = "unik_catto_boi",
    atlas = "unik_catto_boi",
    rarity = 3,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 8,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = false,
    demicoloncompat = true,
    config = {extra = {x_mult = 1,x_mult_mod_good = 0.05, malice = 0.075},immutable = {x_mult_threshold = 1.0,dead = false}},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        return {
            vars = {center.ability.extra.x_mult_mod_good,localize("Diamonds","suits_singular"),
            tostring(center.ability.extra.malice),localize("Hearts","suits_singular"),localize("Spades","suits_singular"),center.ability.immutable.x_mult_threshold
            ,tostring(center.ability.extra.x_mult),localize(catto_boi[quoteset][math.random(#catto_boi[quoteset])] .. ""),
        colours = {G.C.SUITS["Diamonds"],G.C.SUITS["Hearts"],G.C.SUITS["Spades"]}}
        }
	end,
    pools = {["character"] = true },
    calculate = function(self, card, context)
        if ((context.joker_main or context.force_trigger) and to_big(card.ability.extra.x_mult) > to_big(1)) and not card.ability.immutable.dead then
			return {
				x_mult = card.ability.extra.x_mult,
			}
		end
        if (context.individual and context.cardarea == G.play) and not card.ability.immutable.dead and not context.blueprint then
            if context.other_card:is_suit('Diamonds') then
                
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_mod_good",
                    message_key = 'a_xmult',
                    message_colour = G.C.MULT,
                    force_full_val = true,
                    no_message = true,
                })
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { card.ability.extra.x_mult }
                    },
                    message_card = card,
                    colour = G.C.MULT,
                }
            end
            if context.other_card:is_suit('Spades') or context.other_card:is_suit('Hearts') then
                --80% chance to produce a normal message, 20% to produce a custom one
                if math.random() > 0.15 then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "malice",
                        operation = "-",
                        message_key = 'a_xmult_minus',
                        message_colour = G.C.RED,
                        delay = 0.5,
                    })
                    if card.ability.extra.x_mult < card.ability.immutable.x_mult_threshold then
                        G.E_MANAGER:add_event(Event({
                            trigger="immediate",
                            func = function()
                                --Dissolving
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    card:gore6_break()

                                
                                return true
                            end
                        }))
                        card.ability.immutable.dead = true
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_unik_catto_boi_die"),
                            colour = G.C.UNIK_VOID_COLOR,
                            card=card,
                        })
                    end
                    return {
                        
                    }
                else
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "malice",
                        operation = "-",
                        message_key = 'a_xmult_minus',
                        message_colour = G.C.RED,
                        delay = 0.5,
                        no_message = true,
                    })
                    local quoteset = 'torture'
                    if card.ability.extra.x_mult < card.ability.immutable.x_mult_threshold then
                        G.E_MANAGER:add_event(Event({
                            trigger="immediate",
                            func = function()
                                --Dissolving
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    card:gore6_break()
                                
                                return true
                            end
                        }))
                        card.ability.immutable.dead = true
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_unik_catto_boi_die"),
                            colour = G.C.UNIK_VOID_COLOR,
                            card=card,
                        })
                    else
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize(catto_boi[quoteset][math.random(#catto_boi[quoteset])] .. ""),
                            colour = G.C.UNIK_EYE_SEARING_RED,
                            card=card,
                        })
                    end
                    
                end
                
            end
            return {

			}
        end

    end,
}