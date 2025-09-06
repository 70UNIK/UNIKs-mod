--earn $0 at end of round, increase by $3 per dollar card held at end of round
SMODS.Joker {
    key = 'unik_joker_dollar',
    atlas = 'uncommon',
	pos = { x = 7, y = 0 },
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			dollars = 0,
			dollar_mod = 3,
		},
	},
	pixel_size = { w = 52, h = 95 },
	enhancement_gate = "m_unik_dollar",
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_dollar
		return {
			vars = {
				number_format(center.ability.extra.dollars),
				number_format(center.ability.extra.dollar_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
            return {
				dollars = card.ability.extra.dollars,
				card = card
			}
        end
		if context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint then
			if SMODS.has_enhancement(context.other_card, "m_unik_dollar") then
				SMODS.scale_card(card, {
					ref_table =card.ability.extra,
					ref_value = "dollars",
					scalar_value = "dollar_mod",
					message_colour = G.C.GOLD,
				})
				return {

				}
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.dollars
        if bonus > 0 then
			return bonus
		end
	end,
	 draw = function(self, card, layer)
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        card.children.center:draw_shader(
            "voucher",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        )
    end,
}