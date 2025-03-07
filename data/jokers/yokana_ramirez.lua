SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_yokana',
    atlas = 'placeholders',
    rarity = 'cry_epic',
	pos = { x = 3, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {x_chips = 1.4,family_x_bonus = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips, center.ability.extra.family_x_bonus} }
	end,
}