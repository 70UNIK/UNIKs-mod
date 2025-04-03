SMODS.Atlas {
	key = "unik_chelsea",
	path = "unik_chelsea.png",
	px = 71,
	py = 95
}

local chelsea_quotes = {
	normal = {
		'k_unik_chelsea_normal1',
		'k_unik_chelsea_normal2',
		'k_unik_chelsea_normal3',
        'k_unik_chelsea_normal4',
	},
    family1 = {
        'k_unik_chelsea_normal_1member'
    },
    family2 = {
        'k_unik_chelsea_normal_family'
    },
    godsmaya = {
        'k_unik_chelsea_normal_maya_god1',
        'k_unik_chelsea_normal_maya_god2'
    },
    godsyokana = {
        'k_unik_chelsea_normal_yokana_god1',
        'k_unik_chelsea_normal_yokana_god2'
    },
    godsorphan = {
        'k_unik_chelsea_normal_family_god1',
        'k_unik_chelsea_normal_family_god2',
        'k_unik_chelsea_normal_family_god3',
        'k_unik_chelsea_normal_family_god4',
    },
	drama = {
		'k_unik_chelsea_scared1',
        'k_unik_chelsea_scared2',
	},
	gods = {
		'k_unik_chelsea_godsmarble1',
		'k_unik_chelsea_godsmarble2',
		'k_unik_chelsea_godsmarble3',
        'k_unik_chelsea_godsmarble4',
        'k_unik_chelsea_godsmarble5',
        'k_unik_chelsea_godsmarble6',
	},
    gods_parents = {
        'k_unik_chelsea_godsmarble_parents',
    },
    gods_orphan = {
        'k_unik_chelsea_godsmarble_parents_gods',
    }
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jsab_chelsea',
    atlas = 'unik_chelsea',
    rarity = 'cry_epic',
    dependencies = {
		items = {
			"set_cry_epic",
		},
	},
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    godsmarble_family_trauma = { x = 1, y = 0 },
    drama = { x = 1, y = 0 }, --WIP: Remains the same
	godsmarbling = {x = 1, y = 0 }, --may remove once a seperate "godsmarbling" sprite function is made (Scared but exclusively when godsmarble is present)
    cost = 12,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    fusable = true,
    config = { extra = {x_chips = 1.0, x_chips_mod = 0.1,family_x_bonus = 1.3,unik_godsmarble_debuff = false} },
    gameset_config = {
		modest = { extra = {x_chips = 1.0, x_chips_mod = 0.05,family_x_bonus = 1.3} },
	},
    pools = {["unik_cube"] = true },
	loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
		if (SMODS.Mods["jen"] or {}).can_load then
			quoteset = Jen.dramatic and 'drama' or Jen.gods() and 'gods' or 'normal'
        end
		return { 
            vars = {center.ability.extra.x_chips,center.ability.extra.x_chips_mod, center.ability.extra.family_x_bonus
            ,localize(chelsea_quotes[quoteset][math.random(#chelsea_quotes[quoteset])] .. "")
        } }
	end,
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) and not card.ability.extra.unik_godsmarble_debuff then
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
        -- ----print("Chips triggered!")
        -- -- Yokana's effect
        -- for _,v in pairs(SMODS.find_card('j_unik_jsab_yokana')) do
        --     --avoid infinite recursion/overflow error by having it not work with other yokanas (otherwise will become infinite)
        --     --Maybe add a method to make it compatible with blueprint, or in other words, create the context
        --      if (v.config.center.key ~= scored_card.config.center.key) then
        --         SMODS.calculate_effect({
        --             message = localize({
        --                 type = "variable",
        --                 key = "a_xchips",
        --                 vars = { number_format(to_big(v.ability.extra.x_chips)) },
        --             }),
        --             Xchip_mod = v.ability.extra.x_chips,
        --             colour = G.C.CHIPS,
        --         }, v)
        --      end
        -- end

        for _, v in pairs(SMODS.find_card('j_unik_jsab_chelsea')) do
            if not v.ability.extra.unik_godsmarble_debuff then
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
        for _, v in pairs(SMODS.find_card('j_unik_mutilated_mess')) do
            v.ability.extra.EEchips = v.ability.extra.EEchips + v.ability.extra.EEchips_mod
            card_eval_status_text(v, "extra", nil, nil, nil, {
                message = localize({
                    type = "variable",
                    key = "a_EEchips",
                    vars = { number_format(to_big(v.ability.extra.EEchips)) },
                }),
                colour = G.C.jen_RGB,
            })
        end
    end
    return ret
end

-- --special function for when family members get godsmarbled
-- function Family_godsmarble_loc(card)
--     local debuffed = false
--     local chelseaBlacklist = {'j_unik_impaled_inferno','j_unik_mutated_monster'}
--     local yokanaBlacklist = {'j_unik_mutilated_mess','j_unik_impaled_inferno'}
--     local mayaBlacklist = {'j_unik_mutilated_mess','j_unik_mutated_monster'}
--     local chelseaWhitelist = {'j_unik_yokana','j_unik_mutated_monster'}
--     local yokanaWhitelist = {'j_unik_mutilated_mess','j_unik_impaled_inferno'}
--     local mayaWhitelist = {'j_unik_mutilated_mess','j_unik_mutated_monster'}
--     local blacklist = nil
--     local whitelist = nil
--     if G.Jokers and G.Jokers.cards then
--         if card.config.center.key == 'j_unik_jsab_yokana' then
--             blacklist = yokanaBlacklist
--         elseif  card.config.center.key == 'j_unik_jsab_chelsea' then
--             blacklist = chelseaBlacklist
--         elseif card.config.center.key == 'j_unik_jsab_maya' then
--             blacklist = mayaBlacklist
--         end
--         if blacklist ~= nil and whitelist ~= nil then
--             for j,w in pairs(blacklist) do
--                 if v.config.center.key == w then
--                     debuffed = true
--                 end
--             end
--         end

--     end
-- 	if debuffed then
--         card.ability.extra.unik_godsmarble_debuff = true
-- 		return card.key .. "_" .. "debuff"
--     else
-- 		return card.key
-- 	end
-- end