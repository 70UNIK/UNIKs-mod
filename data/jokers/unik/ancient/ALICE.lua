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
    rarity = "unik_ancient",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
	eternal_compat = true,
    config = { extra = { Emult = 1},immutable = {base_emult = 1.0}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult + center.ability.immutable.base_emult} }
	end,
    pools = {},
    pronouns = "she_her",
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
                }
        end
        if (context.cardarea == G.jokers and context.joker_main) then
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
                return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
                }
            end
		end
    end,

}
