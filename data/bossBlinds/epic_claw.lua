SMODS.Blind	{
    key = 'unik_epic_claw',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("512219"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 26},
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
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
	set_blind = function(self, reset, silent)
        if not reset then
            for i,v in pairs(G.playing_cards) do
                v.ability.unik_claw_mark = true
                v.ability.unik_claw_counter = 2
            end
        end
    end,
    defeat = function(self)
        for i,v in pairs(G.playing_cards) do
            v.ability.unik_claw_mark = nil
            v.ability.unik_claw_counter = nil
        end
	end,
    debuff_hand = function(self, cards, hand, handname, check)
        for _, card in pairs(cards) do
            if card.ability.unik_claw_mark then
                return true
            end
        end
        return false
    end,
}
