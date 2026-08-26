--on first hand, levels up the high poker hand based on held cards (ie:having x5 7s of crosses will level up flush five then five of a kind)
local goob_quotes = {
	normal = {
		'k_unik_goob_normal1',
        'k_unik_goob_normal2',
        'k_unik_goob_normal3',
	},
    levelup = {
        'k_unik_goob_levelup1',
        'k_unik_goob_levelup2',
        'k_unik_goob_levelup3',
    },
}

SMODS.Joker {
    key = "unik_goob",
    atlas = 'unik_character_jokers',
    rarity = 3,
    cost = 8,
    pos = { x = 6, y = 7 },
	soul_pos = { x = 7, y = 7 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {},
    pronouns = "he_him",
     pools = {["character"] = true },
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        local validCards = {}
        local hand = "High Card"
        if G.hand then
            for i,v in pairs(G.hand.cards) do
                if not TableContains(v,G.hand.highlighted) then
                    validCards[#validCards+1] = v
                end
            end
            local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(validCards)
            if text ~= "NULL" then
                for i = #G.handlist,1,-1 do
                    if G.GAME.hands[G.handlist[i]].visible and next(poker_hands[G.handlist[i]]) then
                    --    print(G.handlist[i])
                        hand = G.handlist[i]
                    end
                end
            end
           -- print(G.GAME.hands)
            
        end
       -- print(hand)
        
        return { 
           vars = {localize(hand, 'poker_hands'),localize(goob_quotes[quoteset][math.random(#goob_quotes[quoteset])] .. "")} }
	end,
    calculate = function(self, card, context)
        if context.press_play  then
            if G.GAME.current_round.hands_played == 0 then
                local validCards = {}
                for i,v in pairs(G.hand.cards) do
                    if not TableContains(v,G.hand.highlighted) then
                        validCards[#validCards+1] = v
                    end
                end
                local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(validCards)
                local hand = "High Card"
                for i = #G.handlist,1,-1 do
                    if G.GAME.hands[G.handlist[i]].visible and next(poker_hands[G.handlist[i]]) then
                        print(G.handlist[i])
                        hand = G.handlist[i]
                    end
                end
                local quoteset = 'levelup'
                
                return {
                    card = card,
                    message = localize(goob_quotes[quoteset][math.random(#goob_quotes[quoteset])] .. ""),
                    func = function()
                        SMODS.upgrade_poker_hands({
                            hands = hand,
                            level_up = 1,
                            from = card,
                            instant = nil,
                        })
                    end
                }
            end
        end
        if context.first_hand_drawn then
            if not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
        end
    end
}

function TableContains(value, tbl)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end