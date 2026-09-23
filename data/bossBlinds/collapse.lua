--All rankless and suitless cards (stone cards) are debuffed
SMODS.Blind{
    key = 'unik_collapse',
    config = {},
	boss = {
		min = -66,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 8},
    boss_colour= HEX("666666"),
    dollars = 5,
    mult = 2,
    pronouns = "it_its",
	--Only appear if you have at least 5 stone cardsSMODS.has_no_suit(v)
	in_pool = function()
        local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards >= 1 then
            return true
        end
        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled and SMODS.has_no_suit(card) then
            return true
        end
        return false
	end,
    aij_calculate_counter_score = function()
        --Max counter:
        -- 1) Jokers that rely on rankless/suitless or stone cards
        -- 2) High roportion of rankless/suitless cards in your deck or in the last 10 played hands
        -- 3) Playing bulwark dramatically increases the chances
        return 0
    end
}