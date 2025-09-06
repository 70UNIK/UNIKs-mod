SMODS.Joker {
    key = 'unik_euclid',
    atlas = 'unik_uncommon',
	pos = { x = 4, y = 2 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicolon_compat = true,
    config = {
		extra = { chips = 59 },
	},
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.chips} }
	end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) then
            if (
                context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 5 or 
                context.other_card:get_id() == 7 or 
                context.other_card:get_id() == 14) then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
		end
        if context.force_trigger then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
	end,
}