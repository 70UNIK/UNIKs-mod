SMODS.Joker {
    key = 'unik_landfill',
    atlas = 'unik_common',
	pos = { x = 2, y = 2 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    immutable = true,
    demicoloncompat = true,
    config = { extra = {chips = 0, chip_mod = 3, bad_chip_mod = 2}},
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {center.ability.extra.chip_mod,-center.ability.extra.bad_chip_mod,math.max(center.ability.extra.chips,0)},
        }
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            cards = 0
			for k, v in ipairs(context.scoring_hand) do
				v.landfill_incompat = true
			end
			for k, v in ipairs(context.full_hand) do
				if not v.landfill_incompat then
					cards = cards + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end,
					}))
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v.landfill_incompat = nil
			end
            if cards > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_mod",
					message_key = "a_chips",
					message_colour = G.C.CHIPS,
                    force_full_val = true,
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + scaling * cards
					end,
				})
                card.ability.extra.chips = math.max(card.ability.extra.chips,0)
				return {
                    
                }
			end
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "bad_chip_mod",
                message_key = 'a_chips_minus',
                message_colour = G.C.CHIPS,
                operation = '-',
            })
            card.ability.extra.chips = math.max(card.ability.extra.chips,0)
            return {

            }
        end
        if context.joker_main or context.force_trigger then
            card.ability.extra.chips = math.max(card.ability.extra.chips,0)
            return {
                chips = math.max(card.ability.extra.chips,0)
            }
        end
    end,
}