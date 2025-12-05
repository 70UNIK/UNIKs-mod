SMODS.Blind	{
    key = 'unik_epic_entanglement',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("147029"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 34},
    vars = {},
    dollars = 13,
    mult = 2,
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
    stay_flipped = function (self, area, card)
        if area == G.hand and G.hand.cards then
            local ranks = {}
            for i, v in ipairs(G.hand.cards) do
                if (v.config and v.config.center and v.config.center.unik_specific_suit) and not SMODS.has_no_suit(v) and v.facing == 'front' then
                    ranks[v.config.center.unik_specific_suit] = true
                elseif v.base and v.base.suit and not SMODS.has_no_suit(v) and v.facing == 'front' then
                    ranks[v.base.suit] = true
                end
            end
            if ((card.base and card.base.suit and ranks[card.base.suit]) or (card.config and card.config.center and card.config.center.unik_specific_suit and ranks[card.config.center.unik_specific_suit])) and not SMODS.has_no_suit(card) then
                return true
            end
        end
        return false
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(cards)
        local always_scores_count = 0
        local facedowns = 0

        for _, card in pairs(cards) do
            if card.facing == 'back' or card.is_face_down_prior  then
                facedowns = facedowns + 1
            end
            if SMODS.always_scores(card) then always_scores_count = always_scores_count + 1 end
        end
        if #cards ~= 4 --no spectrums, no flushes (unless 4 fingers)
        or #scoring_hand + always_scores_count ~= #cards or (facedowns < 2 ) then 
            return true 
        end
        return false
    end,
    defeat = function(self)
		for i,v in pairs(G.playing_cards) do
            --print(1)
            v.is_face_down_prior = nil
        end
	end,
    calculate = function(self, card, context)
        if context.on_select_play
        then
            local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
             for i = 1, #scoring_hand do
                if scoring_hand[i].facing == 'back' then
                    --print(2)
                    scoring_hand[i].is_face_down_prior = true
                end
            end
        end
        if context.after then
            for i,v in pairs(G.playing_cards) do
                --print(1)
                v.is_face_down_prior = nil
            end
        end
    end,

}