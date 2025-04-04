--Each scored seven has this joker gain ^^^0.02 Chips
local cube_quotes = {
	normal = {
		'k_unik_cube_of_calamity1',
		'k_unik_cube_of_calamity2',
		'k_unik_cube_of_calamity3',
		'k_unik_cube_of_calamity4',
		'k_unik_cube_of_calamity5',
	},

}

SMODS.Joker {
    dependencies = {
        mods = {
            "jen", 
          }
    },
    gameset_config = {
		modest = {disabled = true},
	},
	key = 'unik_cube_of_calamity',
    atlas = 'placeholders',
    rarity = "unik_transcendent_placeholder",
    
    pos = { x = 1, y = 1 },
	-- -- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	-- soul_pos = { x = 1, y = 0 },
    cost = 1e3,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    no_doe = ((SMODS.Mods["jen"] or {}).can_load or unik_config.unik_almanac_fusions_in_cryptid),
    config = { extra = {EEEchips_mod = 0.02, EEEchips = 1.0} }, --normally he should not be cappted in mainline+
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return {
		vars = {center.ability.extra.EEEchips_mod,center.ability.extra.EEEchips
	,localize(cube_quotes[quoteset][math.random(#cube_quotes[quoteset])] .. "")
	} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.EEEchips) > to_big(1)) then    
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card:juice_up(1.0, 1.0)
                    G.ROOM.jiggle = G.ROOM.jiggle + 7
                    return true
                end,
            }))
			return {
                message = localize({
					type = "variable",
					key = "a_hyper_three_chips",
                    vars = {
                        number_format(card.ability.extra.EEEchips),
                    },
				}),
				EEEchip_mod = card.ability.extra.EEEchips,
                colour = G.C.UNIK_VOID_COLOR,
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and not context.blueprint then
            card.ability.extra.EEEchips = card.ability.extra.EEEchips + card.ability.extra.EEEchips_mod
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card:juice_up(0.7, 0.7)
                    G.ROOM.jiggle = G.ROOM.jiggle + 2
                    return true
                end,
            }))
            return {
                message = localize({
                    type = "variable",
                    key = "a_hyper_three_chips",
                    vars = {
                        number_format(to_big(card.ability.extra.EEEchips)),
                    },
                }),
                colour = G.C.UNIK_VOID_COLOR,
                card = card,
            }
		end
    end,
}