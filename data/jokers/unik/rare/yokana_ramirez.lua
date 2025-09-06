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
		return { vars = {center.ability.extra.x_chips} }
	end,
	pools = {["unik_cube"] = true },
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
			if not Talisman or not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			
			return {
				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end

		if context.final_scoring_step and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
		if context.after and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
	end
}