SMODS.Blind	{
    key = 'unik_epic_nostalgic_pillar_flint',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("48585b"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 19},
    vars = {},
    dollars = 13,
    mult = 2,
	--must be localized
	ignore_showdown_check = true,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	debuff_hand = function(self, cards, hand, handname, check)
		if next(hand["Straight Flush"]) then	
			return false
		end
        G.GAME.blind.triggered = true
		return true
	end,
    in_pool = function(self)
        return CanSpawnEpic()
	end,
}
