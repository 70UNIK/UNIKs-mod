--context.cardarea = G.play and context.individual
--CURRENTLY BROKEN
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_maya',
    atlas = 'placeholders',
    rarity = 'cry_epic',
    dependencies = {
		items = {
			"set_cry_epic",
		},
	},
	pos = { x = 3, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    pools = {["unik_cube"] = true },
    config = { extra = {x_chips_scored = 0.5, x_chips_held = 0.1, family_x_bonus = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips_scored, center.ability.extra.x_chips_held, center.ability.extra.family_x_bonus} }
	end,
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
            context.other_card.ability.xchips = context.other_card.ability.xchips or 1
            context.other_card.ability.xchips = context.other_card.ability.xchips + card.ability.extra.x_chips_scored
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                colour = G.C.CHIPS,
                card = card
            }

		end
        if context.cardarea == G.hand and context.individual and not context.end_of_round then
            if not context.other_card:is_face(true) then
                if context.other_card.debuff then
                    card_eval_status_text(context.other_card, "debuff", nil, nil, nil, nil)
                else
                    context.other_card.ability.xchips = context.other_card.ability.xchips or 1
                    context.other_card.ability.xchips = context.other_card.ability.xchips + card.ability.extra.x_chips_held
                    return {
                        extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                        colour = G.C.CHIPS,
                        card = context.other_card
                    }
                end
            end
        end
    end,
}