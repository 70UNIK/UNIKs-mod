--Average alice but souped up
--If hand contains a scoring odd or even card, X4 Chips and ^2 mult until the end of the round
--Exotic, fixed 0.6% chance to replace Alice if obtained, only avaliable if Extra Credit is installed
--Code partly taken from ExtraCredit
local function contains(table_, value)
    for _, v in pairs(table_) do
        if v == value then
            return true
        end
    end

    return false
end
SMODS.Atlas {
	key = "unik_alice",
	path = "unik_alice.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	key = 'unik_extra_credit_alice',
    atlas = 'unik_alice',
    rarity = "cry_exotic",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = { Emult = 2, Echips = 2}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult,center.ability.extra.Echips} }
	end,
    pools = {},
    calculate = function(self, card, context)
        if context.joker_main then
            local _odd, _even = false, false
            for i = 1, #context.scoring_hand do
                if contains({14,3,5,7,9}, context.scoring_hand[i]:get_id()) and not SMODS.has_no_suit(context.scoring_hand[i]) then
                    _odd = true
                end
                if contains({2,4,6,8,10}, context.scoring_hand[i]:get_id()) and not SMODS.has_no_suit(context.scoring_hand[i]) then
                    _even = true
                end
            end
            if _odd and _even then
                SMODS.calculate_effect({
                    message = localize({
                        type = "variable",
                        key = "a_powchips",
                        vars = { number_format(to_big(card.ability.extra.Echips)) },
                    }),
                    Echip_mod = card.ability.extra.Echips,
                    colour = G.C.DARK_EDITION,
                }, card)
                SMODS.calculate_effect({
                    message = localize({
                        type = "variable",
                        key = "a_powmult",
                        vars = { number_format(to_big(card.ability.extra.Emult)) },
                    }),
                    Emult_mod = card.ability.extra.Emult,
                    colour = G.C.DARK_EDITION,
                }, card)
            end
            return true
		end
    end,

}