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
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_riif_roof"] = {
--         --literally copied from baseball card
--         reminder_text = {
--             { text = "(" },
--             { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
--             { text = "x" },
--             { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.BLUE },
--             { text = ")" },
--         },
--         calc_function = function(card)
--             local count = 0
--             if G.jokers then
--                 for _, joker_card in ipairs(G.jokers.cards) do
--                     if joker_card.config.center.rarity and joker_card.config.center.rarity == 1 then
--                         count = count + 1
--                     end
--                 end
--             end
--             card.joker_display_values.count = count
--             card.joker_display_values.localized_text = localize("k_common")
--         end,
--         mod_function = function(card, mod_joker)
--             return { x_mult = (card.config.center.rarity == 1 and mod_joker.ability.extra.Xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
--         end
-- 	}
-- end