---25 - 100 chips,
---5 - 20 mult,
---$1 - $4 per card scored.
SMODS.Atlas({ 
	key = "unik_fuzzy", 
	path = "unik_fuzzy.png", 
	px = 71,
	py = 95,})

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_fuzzy',
    atlas = 'unik_fuzzy',
    pos = { x = 0,y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { min_mult = -5,max_mult = 15,min_chips = -35,max_chips = 75, min_dollars = -2, max_dollars = 3}},
    cost = 5,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.min_mult,center.ability.extra.max_mult,center.ability.extra.min_chips,center.ability.extra.max_chips,center.ability.extra.min_dollars,center.ability.extra.max_dollars} }
	end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or context.force_trigger then
            return {
                mult = pseudorandom("unik_fuzzy_mult_j", card.ability.extra.min_mult, card.ability.extra.max_mult ) ,
				chips = pseudorandom("unik_fuzzy_chips_j", card.ability.extra.min_chips, card.ability.extra.max_chips),
                dollars = pseudorandom("unik_fuzzy_dollars_j", card.ability.extra.min_dollars, card.ability.extra.max_dollars),
            }
        end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_artesian")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}