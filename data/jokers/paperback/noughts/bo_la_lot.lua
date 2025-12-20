SMODS.Joker {
    key = 'unik_bo_la_lot',
    atlas = 'unik_common',
	pos = { x = 0, y = 3 },
    rarity = 1,
    cost = 6,
	config = {
		extra = {
            mult = 10,
            odds = 4,
            suit = 'unik_Noughts',
            stick_key = 'j_unik_charred_stick'
        }
	},
    eternal_compat = false,
	blueprint_compat = true,
    discovered = true,
    unlocked = true,
	loc_vars = function(self, info_queue, card)
    local numerator, denominator = PB_UTIL.chance_vars(card)
        return {
            vars = {
                card.ability.extra.mult,
                numerator,
                denominator
            }
        }
    end,
	calculate = PB_UTIL.stick_food_joker_logic,
	--do not spawn if no interest
	in_pool = function(self)
		return UNIK.suit_in_deck('unik_Noughts') 
	end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
}