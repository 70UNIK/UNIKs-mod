SMODS.Joker {
    key = 'unik_riif_roof',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { Xmult = 1.3} },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Xmult} }
	end,
    pronouns = "he_him",
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
        if (context.other_joker and card ~= context.other_joker) then
            if context.other_joker.config.center.rarity == 1 then --Common
				return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
				}
            end
        end
    end
}
