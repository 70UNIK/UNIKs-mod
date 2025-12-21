SMODS.Joker {
    key = 'unik_meaty_stick',
    atlas = 'unik_common',
	pos = { x = 3, y = 3 },
    rarity = 1,
    cost = 7,
    config = {
        extra = {
            xMult = 1.5
        }
    },
	perishable_compat = true,
    eternal_compat = false,
	blueprint_compat = true,
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, card)
        local xMult = PB_UTIL.calculate_stick_xMult(card)

        return {
            vars = {
                card.ability.extra.xMult,
                xMult
            }
        }
    end,

    calculate = PB_UTIL.stick_joker_logic,
	in_pool = function(self)
		return false
	end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
}