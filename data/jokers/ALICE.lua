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
    dependencies = {
		items = {
			"set_cry_exotic",
		},
        mods = {
          "extracredit", --While she *can* work without Average Alice, its more fun to require the mod
        }
    },
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
    config = { extra = { Emult = 1.8, Echips = 1.8}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult,center.ability.extra.Echips} }
	end,
    gameset_config = {
		modest = {extra = {Emult = 1.4, Echips = 1.4} },
	},
    pools = {},
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local _odd, _even = false, false
            for i = 1, #context.scoring_hand do
                if not SMODS.has_no_rank(context.scoring_hand[i]) then
                    if contains({14,3,5,7,9}, context.scoring_hand[i]:get_id()) then
                        _odd = true
                    end
                    if contains({2,4,6,8,10}, context.scoring_hand[i]:get_id()) then
                        _even = true
                    end
                end
            end
            if _odd and _even then
                --This does NOT work with retrigger jokers (chad, for instance) so sadly, it had to be the one from circulus pistoris...
                -- SMODS.calculate_effect({
                --     message = localize({
                --         type = "variable",
                --         key = "a_powchips",
                --         vars = { number_format(to_big(card.ability.extra.Echips)) },
                --     }),
                --     Echip_mod = card.ability.extra.Echips,
                --     colour = G.C.DARK_EDITION,
                -- }, context.blueprint_card or context.retrigger_joker or card)
                -- SMODS.calculate_effect({
                --     message = localize({
                --         type = "variable",
                --         key = "a_powmult",
                --         vars = { number_format(to_big(card.ability.extra.Emult)) },
                --     }),
                --     Emult_mod = card.ability.extra.Emult,
                --     colour = G.C.DARK_EDITION,
                -- }, context.blueprint_card or context.retrigger_joker or card)
                return {
                    Echip_mod = card.ability.extra.Echips,
                    Emult_mod = card.ability.extra.Emult,
                    message = localize({
                        type = "variable",
                        key = "a_powmultchips",
                        vars = { number_format(to_big(card.ability.extra.Echips)) },
                    }),
                    colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
                }
            end
		end
    end,

}