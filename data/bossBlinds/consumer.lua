--All consumeables and CCD cards are debuffed
SMODS.Blind{
    key = 'unik_consumer',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 7},
    boss_colour= HEX("dab772"),
    dollars = 5,
    mult = 2,
	--Only appear if you have at least 5 stone cardsSMODS.has_no_suit(v)
	in_pool = function()
        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled and SMODS.has_no_suit(card) then
            return true
        end
        return false
	end,
}