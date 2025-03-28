SMODS.Atlas {
	key = "unik_yokana",
	path = "unik_yokana.png",
	px = 71,
	py = 95
}
--Used to trigger on any chips, Xchips and Echips trigger, but since that does not work out with blueprint
--She should instead trigger 1.5x chips based on cards played and jokers triggered
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_yokana',
    atlas = 'unik_yokana',
    rarity = 'cry_epic',
	dependencies = {
		items = {
			"set_cry_epic",
		},
	},
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {x_chips = 1.35,family_x_bonus = 1.3,scoring = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips, center.ability.extra.family_x_bonus} }
	end,
	gameset_config = {
		modest = { extra = {x_chips = 1.2,family_x_bonus = 1.3,scoring = false} },
	},
	pools = {["unik_cube"] = true },
	calculate = function(self, card, context)
		if context.before and not context.blueprint_card and not context.retrigger_joker  then
			card.ability.extra.scoring = true
		end
		if context.individual and context.cardarea == G.play and not context.cardarea == G.hand then
			if not Talisman.config_file.disable_anims and valid == true then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
                message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = card.ability.extra.x_chips,
				colour = G.C.CHIPS,

			}
		end
		if context.post_trigger and card.ability.extra.scoring == true and context.other_card ~= card then
			if not Talisman.config_file.disable_anims and valid == true then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
                message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = card.ability.extra.x_chips,
				colour = G.C.CHIPS,

			}
		end
		--during consumeables stage, disable scoring (moonlight cookie, observatory)
		if context.other_consumeable and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
		if context.final_scoring_step and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
		if context.after and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end
    end,
}