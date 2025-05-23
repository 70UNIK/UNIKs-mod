local mess_quotes = {
	normal = {
		'k_unik_mutilated_mess1',
		'k_unik_mutilated_mess2',
		'k_unik_mutilated_mess3',
        'k_unik_mutilated_mess4',
        'k_unik_mutilated_mess5',
	},

}
SMODS.Joker {
	dependencies = {
        mods = {
            "jen", 
          }
    },
	-- How the code refers to the joker.
    atlas = 'placeholders',
    key = 'unik_mutilated_mess',
    rarity = 'jen_ritualistic',
	gameset_config = {
		modest = {disabled = true},
	},
	pos = { x = 1, y = 1 },
    cost = 700,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    config = { extra = {EEchips = 1.0, EEchips_mod = 0.02} },
    no_doe = true,
	debuff_immune = true,
	loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
		return { 
            vars = {center.ability.extra.EEchips,center.ability.extra.EEchips_mod
            ,localize(mess_quotes[quoteset][math.random(#mess_quotes[quoteset])] .. "")
        } }
	end,
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.EEchips) > to_big(1)) then
			return {
                message = localize({
					type = "variable",
					key = "a_EEchips",
					vars = { number_format(card.ability.extra.EEchips) },
				}),
				EEchip_mod = card.ability.extra.EEchips,
				colour = G.C.DARK_EDITION
			}
		end
    end,
}