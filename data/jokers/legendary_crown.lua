--Increase Emult by ^1 if scoring above the best hand in this run.
SMODS.Atlas {
		key = "unik_finity_legendary_crown",
		path = "unik_finity_legendary_crown.png",
		px = 71,
		py = 95,
	}
	
local madeline_quotes = {
	normal = {
		'k_legendary_crown_normal1',
		'k_legendary_crown_normal2',
		'k_legendary_crown_normal3',
		'k_legendary_crown_normal4',
	},
}
Cryptid.pointerblistifytype("rarity", "unik_finity_legendary_crown")
if FinisherBossBlinddecksprites then
    FinisherBossBlinddecksprites["bl_unik_legendary_crown"] = {"unik_finity_legendary_crown",{ x = 2, y = 0 }}
end

if FinisherBossBlindQuips then
    FinisherBossBlindQuips["bl_unik_legendary_crown"] = {"legendary_crown",4} 
end


SMODS.Joker {
    key = "unik_legendary_crown",
    atlas = 'unik_finity_legendary_crown',
    config = {
      extra = {Emult = 0.0, Emult_mod = 0.15},
      immutable = {base_emult = 1.0}
    },
    no_pointer = true,
    no_code = true,
    loc_vars = function(self, info_queue, center)
        local BlindSize = 0
        local quoteset = 'normal'
        if G.GAME.round_scores and G.GAME.round_scores['hand'] and G.GAME.round_scores['hand'].amt then
            BlindSize = G.GAME.round_scores['hand'].amt
        end
        return {
            vars = { center.ability.extra.Emult_mod,BlindSize,center.ability.extra.Emult + center.ability.immutable.base_emult,localize(madeline_quotes[quoteset][math.random(#madeline_quotes[quoteset])] .. "")}
        }
    end,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,
    blueprint_compat = true,
    unlocked = true,
    discovered = true, --workaround:
    rarity = "unik_legendary_blind_finity",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 70, 

    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
				e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
			}
        end
        if context.after and not context.blueprint then
            if to_big(G.GAME.round_scores['hand'].amt) > to_big(0) and to_big(SMODS.calculate_round_score()) >= to_big(G.GAME.round_scores['hand'].amt) then
                SMODS.scale_card(card, {
					ref_table =card.ability.extra,
					ref_value = "Emult",
					scalar_value = "Emult_mod",
					scaling_message = {
                        message = localize({
                            type = "variable",
                            key = "a_powmult",
                            vars = {
                                number_format(card.ability.extra.Emult + card.ability.immutable.base_emult),
                            },
                        }),
                        colour = G.C.DARK_EDITION,
                    },
					message_colour = G.C.DARK_EDITION,
				})
            end
        end
        
		if (context.joker_main) and to_big(card.ability.extra.Emult) ~= to_big(1) then
            return {
				e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
			}
        end

    end,

    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("finity")[1] }, badges)
    end,
}
