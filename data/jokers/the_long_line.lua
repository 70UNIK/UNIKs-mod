-- after playing 80 hands, sell to get an exotic joker. EPIC
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_exotic",
			"set_cry_epic",
		},
    },
    key = 'unik_the_long_line',
    atlas = 'placeholders',
    rarity = 'cry_epic',
	pos = { x = 3, y = 0 },
    cost = 10,
    config = {extra = {hands = 0,juiced_up = false}},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.hands } }
    end,
    immutable = true,
    blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	load = function(self, card, card_table, other_card)
		--Do not spam the shake
        card.ability.extra.juiced_up = false
        if card.ability.extra.hands >= 80 and card.ability.extra.juiced_up == false then
            local eval = function(card)
                return not card.REMOVED
            end
            juice_card_until(card, eval, true)
            card.ability.juiced_up = true
        end
	end,
    calculate = function(self, card, context)
        if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint
			and not context.retrigger_joker
		then
            card.ability.extra.hands = card.ability.extra.hands + 1
            if card.ability.extra.hands < 80 then --Hardcoded, dont want misprint to mess with this
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = card.ability.extra.hands .. "/80",
						colour = G.C.CRY_EXOTIC,
					}),
				}
			elseif card.ability.extra.hands >= 80 and card.ability.extra.juiced_up == false then
                
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)
				card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_unik_active"),
                    colour = G.C.CRY_EXOTIC,
                })
                card.ability.juiced_up = true
                return true
            end
        end
        if context.selling_self and not context.blueprint and not context.retrigger_joker then
			if card.ability.extra.hands >= 80 then
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "unik_long_line")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:start_materialize()
				return nil, true
			else
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_nope_ex"), colour = G.C.BLACK }
				)
			end
		end
    end
}