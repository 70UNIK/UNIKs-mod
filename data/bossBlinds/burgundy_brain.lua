--Must play math.min(card selection limit,hand size) cards, all cards must score. 

SMODS.Blind{
    key = 'unik_burgundy_brain',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 27},
    boss_colour= HEX("800020"),
    dollars = 8,
    mult = 2,
    config = {},
    debuff_hand = function(self, cards, hand, handname, check)
        local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(cards)
        local always_scores_count = 0
        for _, card in pairs(cards) do
            if SMODS.always_scores(card) then always_scores_count = always_scores_count + 1 end
        end
        if #cards < math.min(G.hand.config.card_limit,G.hand.config.highlighted_limit) 
        or #scoring_hand + always_scores_count ~= #cards then 
            return true 
        end
        return false
    end,
    loc_vars = function(self, blind_on_deck)
        return {vars = {math.min(G.hand.config.card_limit,G.hand.config.highlighted_limit)}}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {vars = {localize("k_unik_brain_placeholder")}}
    end,
}