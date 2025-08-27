SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_poppy_gb',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 0, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult_mod = 0.5, bad_Xmult_mod = 0.5,Xmult = 1}},
    cost = 6,
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, center)
        local blindsize = 0
        if G.GAME.blind then
            blindsize = G.GAME.blind.chips * 3
        end
		return { vars = {center.ability.extra.Xmult_mod,center.ability.extra.Xmult_mod + center.ability.extra.bad_Xmult_mod,blindsize,center.ability.extra.Xmult} }
	end,
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
            SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_mod",
				scaling_message = {
                    message = localize({
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.Xmult },
                    }),
                    colour = G.C.MULT,
                },
				message_colour = G.C.MULT,
			})
        end
        if context.joker_main and to_big(card.ability.extra.Xmult) > to_big(1) then
			return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
            }
		end
        if context.after and not context.blueprint then
            if to_big(math.floor(SMODS.calculate_round_score())) > to_big(G.GAME.blind.chips * 3) then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "Xmult",
                    scalar_value = "custom_scaler",
                    scalar_table = {
                        custom_scaler = card.ability.extra.Xmult_mod + card.ability.extra.bad_Xmult_mod,
                    },
                    scaling_message = {
                        message = localize({
                            type = "variable",
                            key = "a_xmult",
                            vars = { card.ability.extra.Xmult },
                        }),
                        colour = G.C.MULT,
                    },
                    message_colour = G.C.MULT,
                })
            end
        end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_artesian")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}