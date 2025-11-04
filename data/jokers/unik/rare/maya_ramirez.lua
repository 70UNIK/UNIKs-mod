--context.cardarea = G.play and context.individual
--CURRENTLY BROKEN

SMODS.Atlas {
	key = "unik_maya",
	path = "unik_maya.png",
	px = 71,
	py = 95
}
local maya_quotes = {
	alone = {
		'k_unik_maya_normal1',
		'k_unik_maya_normal2',
        'k_unik_maya_normal3',
		'k_unik_maya_normal4',
	},
	with_chelsea = {
		'k_unik_maya_normal1',
		'k_unik_maya_normal2',
        'k_unik_maya_normal4',
		'k_unik_maya_chelsea',
	},
	with_yokana = {
		'k_unik_maya_normal1',
		'k_unik_maya_normal2',
        'k_unik_maya_normal4',
		'k_unik_maya_yokana',
	},
	everyone = {
		'k_unik_maya_normal1',
		'k_unik_maya_normal2',
        'k_unik_maya_normal4',
		'k_unik_maya_family',
	},
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
    config = { extra = {x_chips_scored = 0.05} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'alone'
		if next(find_joker('j_unik_jsab_chelsea')) and next(find_joker('j_unik_jsab_yokana')) then
			quoteset = 'everyone'
		elseif next(find_joker('j_unik_jsab_chelsea')) then
			quoteset = 'with_chelsea'
		elseif next(find_joker('j_unik_jsab_yokana')) then
			quoteset = 'with_yokana'
		end
		return { vars = {center.ability.extra.x_chips_scored,localize(maya_quotes[quoteset][math.random(#maya_quotes[quoteset])] .. "")} }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
			for k, v in ipairs(context.scoring_hand) do
				v.ability["perma_x_chips"] = v.ability["perma_x_chips"] or 0
				v.ability["perma_x_chips"] = v.ability["perma_x_chips"] + card.ability.extra.x_chips_scored
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end,
				}))
				-- card_eval_status_text(v, "extra", nil, nil, nil, {
				-- 	message = localize('k_upgrade_ex'),
				-- 	colour = G.C.CHIPS,
				-- 	card=v,
				-- 	delay = 0.5,
				-- })
			end
			return {
				extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
				colour = G.C.CHIPS,
			}

		end
    end,
}