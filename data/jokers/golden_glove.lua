-- $2 per hand lost this round.
SMODS.Joker {
    key = 'unik_golden_glove',
    atlas = 'placeholders',
	pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    config = { extra = {cash = 2}},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_hands_lost" }
        return { 
            vars = {center.ability.extra.cash},
        }
	end,
    calculate = function(self, card, context)
        if context.hand_mod and context.hand_mod_val < 0 then
            return {
                 dollars = card.ability.extra.cash * math.abs(context.hand_mod_val)
            }
        end
    end,
}