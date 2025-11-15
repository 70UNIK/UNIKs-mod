SMODS.Atlas {
	key = "unik_yokana",
	path = "unik_yokana.png",
	px = 71,
	py = 95
}

local yokana_quotes = {
	alone = {
		'k_unik_yokana_1',
		'k_unik_yokana_2',
        'k_unik_yokana_3',
		'k_unik_yokana_4',
	},
	with_chelsea = {
		'k_unik_yokana_1',
		'k_unik_yokana_2',
        'k_unik_yokana_chelsea',
		'k_unik_yokana_4',
	},
	with_maya = {
		'k_unik_yokana_1',
		'k_unik_yokana_2',
        'k_unik_yokana_maya',
		'k_unik_yokana_4',
	},
	everyone = {
		'k_unik_yokana_1',
		'k_unik_yokana_2',
        'k_unik_yokana_family',
		'k_unik_yokana_4',
	},
}

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_yokana',
    atlas = 'unik_yokana',
    rarity = 3,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 8,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
	--1.25X chips nerf t
    config = { extra = {x_chips = 1.25,scoring = false} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'alone'
		if next(find_joker('j_unik_jsab_chelsea')) and next(find_joker('j_unik_jsab_maya')) then
			quoteset = 'everyone'
		elseif next(find_joker('j_unik_jsab_chelsea')) then
			quoteset = 'with_chelsea'
		elseif next(find_joker('j_unik_jsab_maya')) then
			quoteset = 'with_maya'
		end
		return { vars = {center.ability.extra.x_chips,localize(yokana_quotes[quoteset][math.random(#yokana_quotes[quoteset])] .. "")} }
	end,
	pronouns = "she_her",
    pools = {["unik_cube"] = true,["character"] = true },
	calculate = function(self, card, context)
		if context.before and not context.blueprint_card and not context.retrigger_joker  then
			card.ability.extra.scoring = true
		end
		if context.forcetrigger then
			return {
				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end
		if (context.post_trigger and card.ability.extra.scoring == true and context.other_card ~= card and not context.other_context.fixed_probability and not context.other_context.fix_probability and not context.other_context.mod_probability) then
			
			return {
				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end

		if context.after and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
	end
}