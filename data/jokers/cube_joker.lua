SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_cube_joker',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 3, y = 0 },

    cost = 6,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.09} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod, center.ability.extra.max_size} }
	end,
	gameset_config = {
		modest = {extra = {x_chips = 1.0, x_chips_mod = 0.05} },
	},
	pools = {["unik_cube"] = true },
	pixel_size = { w = 71, h = 71 },
    calculate = function(self, card, context)
		if context.forcetrigger then
			return {

				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end
		if ((context.joker_main) and (to_big(card.ability.extra.x_chips) > to_big(1))) then
			return {

				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end
        if (context.before and context.cardarea == G.jokers and #context.full_hand == 4 and not context.blueprint) then
			SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "x_chips",
				scalar_value = "x_chips_mod",
				scaling_message = {
					message = localize({
						type = "variable",
						key = "a_xchips",
						vars = { card.ability.extra.x_chips },
					}),
					colour = G.C.CHIPS,
				},
				message_colour = G.C.CHIPS,
			})
		end
    end,
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_cube_joker"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{
						ref_table = "card.ability.extra",
						ref_value = "x_chips",
						retrigger_type = "exp"
					},
				},
				border_colour = G.C.CHIPS,
			},
		},
	}
end

-- Pool used by "squares/cubes"
--Unik is not part of this to maintain rarity.
SMODS.ObjectType({
	key = "unik_cube",
	default = "j_square",
	cards = {
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game jokers
		self:inject_card(G.P_CENTERS.j_square)
	end,
})