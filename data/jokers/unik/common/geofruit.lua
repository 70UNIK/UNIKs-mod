--Scored cards give +36 Chips, destroyed after scoring 20 cards
SMODS.Joker {
	key = 'unik_geofruit',
    atlas = 'unik_normal_jokers',
    rarity = 1,
	pos = { x = 2, y = 4 },
    cost = 5,
    config = { extra = { chips = 36,cards = 20} },
    attributes = { 'chips','food' },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.chips,center.ability.extra.cards}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.destroyed = false
    end,
    pools = { ["Food"] = true},
	blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not card.ability.extra.destroyed then
                if card.ability.extra.cards > 0 then
                    card.ability.extra.cards = card.ability.extra.cards - 1
                    return {
                        chips = card.ability.extra.chips,
                        func = function ()
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = card.ability.extra.cards .. "",
                                colour = G.C.CHIPS,
                                card=card,
                            })
                        end
                    }
                else
                    card.ability.extra.destroyed = true
                    selfDestruction(card,'k_eaten_ex',G.C.CHIPS)
                end
            end
            
		end
        
	end,
} 