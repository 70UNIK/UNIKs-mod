SMODS.Joker {
    key = 'unik_shibazakura',
    atlas = 'unik_uncommon',
	pos = { x = 0, y = 4 },
    config = {
        extra = {
        xMult = 1.075,
        xMult_gain = 0.075,
        xMult_base = 1.075,
        suit = "unik_Crosses",
        }
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = PB_UTIL.panorama_loc_vars,
    calculate = PB_UTIL.panorama_logic,
	--do not spawn if no interest
	in_pool = function(self)
		return UNIK.suit_in_deck('unik_Crosses') 
	end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
}