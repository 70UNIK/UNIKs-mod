--context.cardarea = G.play and context.individual
--CURRENTLY BROKEN
SMODS.Atlas {
	key = "unik_maya",
	path = "unik_maya.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_maya',
    atlas = 'unik_maya',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    rarity = 3,
	cost = 8,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    pools = {["unik_cube"] = true },
    config = { extra = {x_chips_scored = 0.04, family_x_bonus = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips_scored, center.ability.extra.x_chips_held, center.ability.extra.family_x_bonus} }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
                context.other_card.ability["perma_x_chips"] = context.other_card.ability["perma_x_chips"] or 0
                
                context.other_card.ability["perma_x_chips"] = context.other_card.ability["perma_x_chips"] + card.ability.extra.x_chips_scored
                return {
                    extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                    colour = G.C.CHIPS,
                    card = card
                }

		end
    end,
}