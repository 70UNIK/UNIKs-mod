--Owned jokers and consumables appear X16 the usual rate (excluding clone man). Stacks additively 
--showman on steroids
SMODS.Joker {
    key = 'unik_cloneman',
    atlas = 'unik_epic',
    rarity = 'cry_epic', --Abstract cards make this rare now.
	pos = { x = 2, y = 0 },
    cost = 12,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    --Not immutable hopefully
    config = { extra = { 
        multiplier = 7},
        immutable = { max_multiplier = 100 },
    },
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_multiplier, center.ability.extra.multiplier) } }
	end,
}
