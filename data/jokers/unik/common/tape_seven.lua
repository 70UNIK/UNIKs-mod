--Scoring Pink cards are no longer destroyed
SMODS.Joker {
	key = 'unik_numerical_reinforcement',
    atlas = 'placeholders',
    rarity = 1,
	pos = { x = 0, y = 0 },
    cost = 3,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_pink
    end,
	blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    enhancement_gate = 'm_unik_pink',
    
} 