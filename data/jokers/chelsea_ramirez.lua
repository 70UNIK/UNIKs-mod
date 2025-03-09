SMODS.Atlas {
	key = "unik_chelsea",
	path = "unik_chelsea.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_chelsea',
    atlas = 'unik_chelsea',
    rarity = 'cry_epic',
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 12,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.08,family_x_bonus = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod, center.ability.extra.family_x_bonus} }
	end,
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
    end,
}
-- Hook is outside her and for yokana and chelsea's effects
local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = scie(effect, scored_card, key, amount, from_edition)
    --print("TEST")
    if ((key == "x_chips" or key == "xchips" or key == "Xchips" or key == "x_chips_mod" or key == "Xchips_mod" or key == "Xchip_mod"
or key == "Echips_mod" or key == "e_chips_mod" or key == "Echips" or key == "e_chips" or key == "echips" or key == "Echip_mod"
or key == "EEchips_mod" or key == "ee_chips_mod" or key == "EEchips" or key == "ee_chips" or key == "eechips" or key == "EEchip_mod"
or key == "EEEchips_mod" or key == "eee_chips_mod" or key == "EEEchips" or key == "eee_chips" or key == "eeechips" or key == "EEEchip_mod"
or key == "EEEEchips_mod" or key == "eeee_chips_mod" or key == "EEEEchips" or key == "eeee_chips" or key == "eeeechips" or key == "EEEEchip_mod"
or key == "hyper_chips_mod" or key == "hyper_chips_mod" or key == "Hyper_chips" or key == "hyper_chips" or key == "hyperchips" or key == "hyperchip_mod"
) and amount ~= 1) or

    key == "chips" or key == "chip_mod" or key == "chip" or key == "chips_mod" then
        --print("Chips triggered!")
        for _,v in pairs(SMODS.find_card('j_unik_jsab_yokana')) do
            --avoid infinite recursion by having it not work with other yokanas (otherwise will become infinite)
            -- if v.config.center.key ~= scored_card.config.center.key then
                card_eval_status_text(v, "extra", nil, nil, nil, {
                    message = localize({
                        type = "variable",
                        key = "a_xchips",
                        vars = { number_format(to_big(v.ability.extra.x_chips)) },
                    }),
                    Xchip_mod = v.ability.extra.x_chips,
                    colour = G.C.CHIPS,
                })
            -- end
        end
        for _, v in pairs(SMODS.find_card('j_unik_jsab_chelsea')) do

            v.ability.extra.x_chips = v.ability.extra.x_chips + v.ability.extra.x_chips_mod
            card_eval_status_text(v, "extra", nil, nil, nil, {
                message = localize({
                    type = "variable",
                    key = "a_xchips",
                    vars = { number_format(to_big(v.ability.extra.x_chips)) },
                }),
                colour = G.C.CHIPS,
            })
    end
    end
    return ret
end