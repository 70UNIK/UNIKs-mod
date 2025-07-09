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
    dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	key = 'unik_extra_credit_alice',
    atlas = 'unik_alice',
    rarity = "cry_exotic",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
	eternal_compat = true,
    config = { extra = { Emult = 2.5}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult,center.ability.extra.Echips} }
	end,
    gameset_config = {
		modest = {extra = {Emult = 1.6} }, 
	},
    pools = {},
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                    e_mult = card.ability.extra.Emult,
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
                    e_mult = card.ability.extra.Emult,
                    colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
                }
            end
		end
    end,

}

if JokerDisplay then
	JokerDisplay.Definitions["j_unik_extra_credit_alice"] = {
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        },
        extra = {
            {
                {
                    border_nodes = {
                        { text = "^" },
                        { ref_table = "card.joker_display_values", ref_value = "Emult", retrigger_type = "exp" },
                    },
                    border_colour = G.C.DARK_EDITION,
                },
                {
                    border_nodes = {
                        { text = "^" },
                        { ref_table = "card.joker_display_values", ref_value = "Echips", retrigger_type = "exp" },
                    },
                    border_colour = G.C.DARK_EDITION,
                },
            },
        },
        calc_function = function(card)
            local Emult = 1
            local Echips = 1
            local _, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' and text ~= 'NULL' then
                local _odd, _even = false, false
                for _, scoring_card in pairs(scoring_hand) do
                    if not SMODS.has_no_rank(scoring_card) then
                        if contains({14,3,5,7,9}, scoring_card:get_id()) then
                            _odd = true
                        end
                        if contains({2,4,6,8,10}, scoring_card:get_id()) then
                            _even = true
                        end
                    end
                end
                if _odd and _even then
                    Emult = card.ability.extra.Emult
                    Echips = card.ability.extra.Echips
                end
            end
            card.joker_display_values.Emult = Emult
            card.joker_display_values.Echips = Echips
            card.joker_display_values.localized_text = localize('k_unik_odd_and_even') .. ""
        end
	}
end