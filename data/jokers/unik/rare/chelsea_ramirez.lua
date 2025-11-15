SMODS.Atlas {
	key = "unik_chelsea",
	path = "unik_chelsea.png",
	px = 71,
	py = 95
}

local chelsea_quotes = {
	alone = {
		'k_unik_chelsea_normal1',
		'k_unik_chelsea_normal2',
		'k_unik_chelsea_normal3',
        'k_unik_chelsea_normal4',
	},
	with_family = {
		'k_unik_chelsea_normal1',
		'k_unik_chelsea_normal2',
		'k_unik_chelsea_normal3',
        'k_unik_chelsea_normal_1member',
	},
	everyone = {
		'k_unik_chelsea_normal1',
		'k_unik_chelsea_normal2',
		'k_unik_chelsea_normal3',
        'k_unik_chelsea_normal_family',
	},
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_chelsea',
    atlas = 'unik_chelsea',
    rarity = 3,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 8,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    demicoloncompat = true,
    fusable = true,
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.02} },
    pools = {["unik_cube"] = true,["character"] = true },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'alone'
		if next(find_joker('j_unik_jsab_yokana')) and next(find_joker('j_unik_jsab_maya')) then
			quoteset = 'everyone'
		elseif next(find_joker('j_unik_jsab_yokana')) or next(find_joker('j_unik_jsab_maya')) then
			quoteset = 'with_family'
		end
		return { 
            vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod
            ,localize(chelsea_quotes[quoteset][math.random(#chelsea_quotes[quoteset])] .. "")
        } }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
        end
		if (context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1))) and not card.ability.extra.unik_godsmarble_debuff then
			return {

				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
		end
    end,
}
-- Hook is outside her for chelsea's effects
local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = scie(effect, scored_card, key, amount, from_edition)
    --print("TEST")
    if ((key == "x_chips" or key == "xchips" or key == "Xchips" or key == "x_chips_mod" or key == "Xchips_mod" or key == "x_chips"
or key == "Echips_mod" or key == "e_chips_mod" or key == "Echips" or key == "e_chips" or key == "echips" or key == "Echip_mod"
or key == "EEchips_mod" or key == "ee_chips_mod" or key == "EEchips" or key == "ee_chips" or key == "eechips" or key == "EEchip_mod"
or key == "EEEchips_mod" or key == "eee_chips_mod" or key == "EEEchips" or key == "eee_chips" or key == "eeechips" or key == "EEEchip_mod"
or key == "EEEEchips_mod" or key == "eeee_chips_mod" or key == "EEEEchips" or key == "eeee_chips" or key == "eeeechips" or key == "EEEEchip_mod"
or key == "hyper_chips_mod" or key == "hyper_chips_mod" or key == "Hyper_chips" or key == "hyper_chips" or key == "hyperchips" or key == "hyperchip_mod"
or key == "xlog_chips" or key == "xlogchips" or key == "xlog_chips_mod"
) and amount ~= 1) or

    key == "chips" or key == "chip_mod" or key == "chip" or key == "chips_mod" then
        for _, v in pairs(SMODS.find_card('j_unik_jsab_chelsea')) do
            if not v.ability.extra.unik_godsmarble_debuff then
                SMODS.scale_card(v, {
                    ref_table =v.ability.extra,
                    ref_value = "x_chips",
                    scalar_value = "x_chips_mod",
                    message_key = "a_xchips",
                    message_colour = G.C.CHIPS,
                    force_full_val = true,
                })
            end
        end
    end
    return ret
end

-- --Simple XChips display
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_jsab_chelsea"] = {
-- 		text = {
-- 			{
-- 				border_nodes = {
-- 					{ text = "X" },
-- 					{
-- 						ref_table = "card.ability.extra",
-- 						ref_value = "x_chips",
-- 						retrigger_type = "exp"
-- 					},
-- 				},
-- 				border_colour = G.C.CHIPS,
-- 			},
-- 		},
-- 	}
-- end