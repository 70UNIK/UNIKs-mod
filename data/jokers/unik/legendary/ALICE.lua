--Average alice but souped up

--Alice rework:
--^2.5 Mult if card contains a scoring odd and even card. Why? Becomes an ascensio ascension version of average alice (crossmod).
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
    rarity = 4,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 20,
	blueprint_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
	eternal_compat = true,
    config = { extra = { x_mult = 1, x_mult_mod = 0.6}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult_mod,center.ability.extra.x_mult} }
	end,
    pools = {},
    pronouns = "she_her",
    calculate = function(self, card, context)
        if context.forcetrigger or context.joker_main then
            return {
                    x_mult = card.ability.extra.x_mult
                
                }
        end
        if context.before and not context.blueprint then
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
            if (_odd and _even) then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_mod",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT,
                    force_full_val = true,
                })
                return {

                }
            end
        end
    end,

}
