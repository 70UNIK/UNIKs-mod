--6 in 7 chance to NOT gain +1 joker slot after skipping a booster pack. (rare)
SMODS.Joker{ --Yellow Card
    key = "invisible_card",
    config = {
        extra = {
            prob = 5,
            odds = 7,
            increase = 1,
        },
        immutable = {
			slots = 0,
			max_slots = 6,
		},
    },
    pos = {
        x = 3,
        y = 0,
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    atlas = 'unik_rare',
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds, 'unik_invisible_card')
        return {vars = {
            new_numerator, new_denominator,
            math.floor(card.ability.extra.increase),
            card.ability.immutable.slots,
            card.ability.immutable.max_slots,
        }}
    end,
    gameset_config = {
		modest = { extra = {
            prob = 6,
            odds = 7,
            increase = 1,
        },
        immutable = {
			slots = 0,
			max_slots = 5,
		}, },
	},

    calculate = function(self, card, context)
        if context.skipping_booster then
            if not SMODS.pseudorandom_probability(card, 'unik_invisible_card', card.ability.extra.prob, card.ability.extra.odds, 'unik_invisible_card') then
                
                card.ability.immutable.slots = math.min(lenient_bignum(card.ability.immutable.slots + math.floor(card.ability.extra.increase)),card.ability.immutable.max_slots)
                if card.ability.immutable.slots >= card.ability.immutable.max_slots then
                    card.ability.extra.increase = 0
                end
                G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + math.floor(card.ability.extra.increase))
                return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.DARK_EDITION,
					}),
				}
            end
        end
        if context.forcetrigger then
            card.ability.immutable.slots = math.min(lenient_bignum(card.ability.immutable.slots + math.floor(card.ability.extra.increase)),card.ability.immutable.max_slots)
            if card.ability.immutable.slots >= card.ability.immutable.max_slots then
                card.ability.extra.increase = 0
            end
            G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + math.floor(card.ability.extra.increase))
            return {
                
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + to_big(card.ability.immutable.slots))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit - to_big(card.ability.immutable.slots))
	end,
    draw = function(self, card, layer)
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        card.children.center:draw_shader(
            "negative_shine",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        )
    end,
}
