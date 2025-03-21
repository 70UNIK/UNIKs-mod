SMODS.Joker {
    key = 'unik_riif_roof',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = { Xmult = 1.26} },
    gameset_config = {
		modest = { extra = { Xmult = 1.2} }, --around 2X mult with 4 commons
		madness = { extra = { Xmult = 1.32} }, --around 3X mult with 4 commons
	},
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Xmult} }
	end,
    calculate = function(self, card, context)
        if context.other_joker and card ~= context.other_joker then
            if context.other_joker.config.center.rarity == 1 then --Common
                if not Talisman.config_file.disable_anims then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end,
					}))
				end
				return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
				}
            end
        end
    end
}