--+X0.1 Mult per reroll in shop.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_artesian',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 1, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult = 1, Xmult_mod = 0.15}},
    cost = 7,
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Xmult_mod, center.ability.extra.Xmult} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and to_big(card.ability.extra.Xmult) > to_big(1) then
			return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
            }
		end
        if context.reroll_shop and not context.blueprint then
           	SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_mod",
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { card.ability.extra.Xmult },
				}),
				message_colour = G.C.MULT,
			})
        end
		if context.forcetrigger then
			return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
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