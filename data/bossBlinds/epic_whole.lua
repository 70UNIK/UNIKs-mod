SMODS.Blind {
    key = 'unik_epic_whole',
    config = {},
    showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true,unskippable_ante = true},
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
        unik_all_unskippable_blinds = true,
    },
    unik_kill_hand = function(self, cards, hand, handname, check)
        if not G.GAME.unik_ranks_scored_this_ante then
            G.GAME.unik_ranks_scored_this_ante = {}
        end
        for i,v in pairs(cards) do
            if G.GAME.unik_ranks_scored_this_ante[v:get_id()] then
                return true
            end
        end
        return false
    end,
    in_pool = function(self)
        return CanSpawnEpic()
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
