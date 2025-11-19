SMODS.Joker {
    key = 'unik_beaver',
    atlas = 'unik_rare',
	pos = { x = 3, y = 2 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    config = { extra = {base = 60} },
    enhancement_gate = 'm_unik_timber',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_timber
        return { 
            vars = {center.ability.extra.base} 
        }
	end,
    pools = {},
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if SMODS.has_enhancement(context.other_card,'m_unik_timber') then
				return {
                    xlog_mult = card.ability.extra.base,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
                xlog_mult = card.ability.extra.base,
                card = card,
            }
		end
    end,
}