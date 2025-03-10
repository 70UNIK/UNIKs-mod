SMODS.Atlas {
	key = "unik_yokana",
	path = "unik_yokana.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_yokana',
    atlas = 'unik_yokana',
    rarity = 'cry_epic',
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {x_chips = 1.5,family_x_bonus = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips, center.ability.extra.family_x_bonus} }
	end,
}