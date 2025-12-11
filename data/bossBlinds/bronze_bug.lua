SMODS.Blind{
    key = 'unik_bronze_bug',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 43},
    boss_colour= HEX("754223"),
    dollars = 8,
    mult = 2,
    loc_vars = function(self, blind_on_deck)
        return {vars = {math.min(G.hand.config.card_limit,G.hand.config.highlighted_limit)}}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {vars = {localize("k_unik_brain_placeholder")}}
    end,
    -- unik_exponent = {1,1.03},
    unik_before_play = function(self)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        local always_scores_count = 0
        for i,v in pairs(scoring_hand) do
            v.blacklist_scoring = true
        end
        for _, card in pairs(G.hand.highlighted) do
            if (SMODS.always_scores(card) or next(find_joker('Splash'))) and not card.blacklist_scoring then always_scores_count = always_scores_count + 1 end
        end
        for i,v in pairs(scoring_hand) do
            v.blacklist_scoring = nil
        end
        if #G.hand.highlighted < math.min(G.hand.config.card_limit,G.hand.config.highlighted_limit) 
        or #scoring_hand + always_scores_count ~= #G.hand.highlighted then 
            if #G.jokers.cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local neck_banish = pseudorandom_element(G.jokers.cards, pseudoseed("unik_bug_banish"))
                         G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            neck_banish:gore6_break()
                            -- if not G.GAME.banned_keys then
                            -- G.GAME.banned_keys = {}
                            -- end
                            -- if not G.GAME.cry_banished_keys then
                            --     G.GAME.cry_banished_keys = {}
                            -- end
                            -- G.GAME.cry_banished_keys[neck_banish.config.center.key] = true
                       
                        return true
                    end
                }))
            end
        end
	end
}