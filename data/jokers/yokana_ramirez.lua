SMODS.Atlas {
	key = "unik_yokana",
	path = "unik_yokana.png",
	px = 71,
	py = 95
}
--Used to trigger on any chips, Xchips and Echips trigger, but since that does not work out with blueprint
--She should instead trigger 1.6x chips per scored card (less than caramel, which is 1.75x mult per card scored, less than tribolet, but more than ancient joker)
--x1.35 chips for every joker triggered instead. She can become OP, but you need to build her up. By comparison, waluigi is 1.4 (changed to 1.5)
--
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
	soul_pos = { x = 1, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
	--1.25X chips nerf t
    config = { extra = {x_chips = 1.3,family_x_bonus = 1.3,scoring = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips, center.ability.extra.family_x_bonus} }
	end,
	gameset_config = {
		modest = { extra = {x_chips = 1.15,family_x_bonus = 1.3,scoring = false} },
	},
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
		-- if (context.individual and context.cardarea == G.play) then
		-- 	-- if not Talisman.config_file.disable_anims then
		-- 	-- 	G.E_MANAGER:add_event(Event({
		-- 	-- 		func = function()
		-- 	-- 			context.other_card:juice_up(0.5, 0.5)
		-- 	-- 			return true
		-- 	-- 		end,
		-- 	-- 	}))
		-- 	-- end
		-- 	return {
		-- 		x_chips = card.ability.extra.x_chips,
		-- 		colour = G.C.CHIPS,

		-- 	}
		-- end
		if (context.post_trigger and card.ability.extra.scoring == true and context.other_card ~= card) then
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

--Hybrid of cards played AND baseball card like functionality
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_jsab_yokana"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{ ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" },
				},
				border_colour = G.C.CHIPS,
			},
		},
		calc_function = function(card)
			local count = 0
			local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
			local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
			if text ~= "Unknown" then
				for _, scoring_card in pairs(scoring_hand) do
					count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
				end
			end
			card.joker_display_values.x_chips = card.ability.extra.x_chips ^ count
		end,
		mod_function = function(card, mod_joker)
			return { x_chips = mod_joker.ability.extra.x_chips }
		end,
	}
end