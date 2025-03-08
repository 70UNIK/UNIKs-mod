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
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.25} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod, center.ability.extra.max_size} }
	end,
	pixel_size = { w = 71, h = 71 },
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
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
        if context.before and context.cardarea == G.jokers and #context.full_hand == 4 and not context.blueprint then
			card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_mod
			return {
				message = localize({
                    type = "variable",
                    key = "a_xchips",
                    vars = {
                        number_format(to_big(card.ability.extra.x_chips)),
                    },
                }),
				colour = G.C.CHIPS,
				card = card
			}
		end
    end,
}


-- Pool used by "squares/cubes"
--Unik is not part of this to maintain rarity.
-- SMODS.ObjectType({
-- 	key = "cube",
-- 	default = "j_square",
-- 	cards = {
-- 		["j_unik_cube_joker"] = true,
-- 		["j_cry_cube"] = true,
-- 		["j_cry_big_cube"] = true,
-- 		["j_unik_jsab_chelsea"] = true,
-- 	},
-- 	inject = function(self)
-- 		SMODS.ObjectType.inject(self)
-- 		-- insert base game jokers
-- 		self:inject_card(G.P_CENTERS.j_square)
-- 	end,
-- })