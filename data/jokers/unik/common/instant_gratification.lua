--$2 per discard lost this round at 0 discards
SMODS.Joker {
    key = 'unik_instant_gratification',
    atlas = 'unik_common',
	pos = { x = 4, y = 1 },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {cash = 1.5}},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_hands_lost" }
        return { 
            vars = {center.ability.extra.cash},
        }
	end,
    calculate = function(self, card, context)
        if (context.discard_mod and context.discard_mod_val < 0) or context.force_trigger then
            return {
                dollars = card.ability.extra.cash * math.abs(context.discard_mod_val)
            }
            
        end
    end,
}