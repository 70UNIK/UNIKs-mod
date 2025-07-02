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
FinisherBossBlinddecksprites["bl_unik_legendary_crown"] = {"unik_finity_legendary_crown",{ x = 2, y = 0 }}
FinisherBossBlindQuips["bl_unik_legendary_crown"] = {"legendary_crown",4} 

SMODS.Joker {
    key = "unik_legendary_crown",
    atlas = 'unik_finity_legendary_crown',
    config = {
      extra = {Emult = 1.0, Emult_mod = 0.4}
    },
    loc_vars = function(self, info_queue, center)
        local BlindSize = 0
        local quoteset = 'normal'
        if G.GAME.round_scores and G.GAME.round_scores['hand'] and G.GAME.round_scores['hand'].amt then
            BlindSize = G.GAME.round_scores['hand'].amt
        end
        return {
            vars = { center.ability.extra.Emult_mod,BlindSize,center.ability.extra.Emult,localize(madeline_quotes[quoteset][math.random(#madeline_quotes[quoteset])] .. "")}
        }
    end,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,
    blueprint_compat = true,
    rarity = "unik_legendary_blind_finity",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 70, 

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if to_big(G.GAME.round_scores['hand'].amt) > to_big(0) and to_big(math.floor(hand_chips*mult)) >= to_big(G.GAME.round_scores['hand'].amt) then
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                return {
                    message = localize({
                        type = "variable",
                        key = "a_powmult",
                        vars = {
                            number_format(to_big(card.ability.extra.Emult)),
                        },
                    }),
                    colour = G.C.DARK_EDITION,
                    card = card
                }
            end
        end
        
		if (context.joker_main) and to_big(card.ability.extra.Emult) ~= to_big(1) then
            return {
                message = localize({
					type = "variable",
					key = "a_powmult",
                    vars = {
                        number_format(card.ability.extra.Emult),
                    },
				}),
				Emult_mod = card.ability.extra.Emult,
                colour = G.C.DARK_EDITION,
			}
        end

    end,

    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("finity")[1] }, badges)
    end,
}
