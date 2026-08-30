--Scoring Pink cards are no longer destroyed
SMODS.Joker {
	key = 'unik_numerical_reinforcement',
    atlas = 'unik_normal_jokers',
    rarity = 1,
	pos = { x = 7, y = 6 },
    cost = 4,
    config = { extra = { chips = 37} },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_pink
        return {
            vars = {center.ability.extra.chips}
        }
    end,
	blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    enhancement_gate = 'm_unik_pink',
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card,'m_unik_pink') then
                return {
                    chips = card.ability.extra.chips
                }
			end
		end
        
	end
} 