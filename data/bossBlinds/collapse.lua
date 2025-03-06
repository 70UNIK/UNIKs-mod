--All rankless and suitless cards (stone cards) are debuffed
SMODS.Blind{
    key = 'unik_collapse',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 8},
    boss_colour= HEX("666666"),
    dollars = 5,
    mult = 2,
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
        if stoneCards >= 5 then
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
}