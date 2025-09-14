SMODS.Blind {
    key = 'unik_epic_whole',
    config = {},
    showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("555e36"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 24},
    vars = {},
    dollars = 13,
    mult = 2,
    pronouns = "it_its",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    unik_kill_hand = function(self, cards, hand, handname, check)
        if not G.GAME.unik_previously_scored_ranks then
            G.GAME.unik_previously_scored_ranks = {}
        end
        for i,v in pairs(cards) do
            if not G.GAME.unik_previously_scored_ranks[v:get_id()] then
                return true
            end
        end
        return false
    end,
    in_pool = function(self)
        return CanSpawnEpic()
    end,
    set_blind = function(self)
        G.GAME.unik_halt_adding_ranks = true
	end,

	defeat = function(self)
        G.GAME.unik_halt_adding_ranks = nil
	end,
    -- recalc_debuff = function(self, card, from_blind)
    --     if card.area ~= G.jokers then
    --         if not SMODS.has_no_rank(card) then
    --             if G.GAME.paperback.ranks_scored_this_ante[card:get_id()] then
    --             return true
    --             end
    --         end
    --     end
    --     return false
    -- end
}

--hook
local get_prev_ranks = evaluate_play_final_scoring
function evaluate_play_final_scoring(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    G.GAME.unik_previously_scored_ranks = {}
    for i,v in pairs(scoring_hand) do
        G.GAME.unik_previously_scored_ranks[v:get_id()] = true
    end
    get_prev_ranks(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
end