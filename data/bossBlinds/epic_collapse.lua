SMODS.Blind	{
    key = 'unik_epic_collapse',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("444444"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 8},
    vars = {},
    dollars = 13,
    mult = 2,
	get_loc_debuff_text = function(self)
		return localize("k_unik_only_stone")
	end,
	--must be localized
	death_message = 'special_lose_unik_epic_collapse',
	ignore_showdown_check = true,
	in_pool = function(self)
		local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
                --in cryptid, at least it only spawns if yoy have at least 5 stone cards
        if stoneCards < 4 then
            return false
        end
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        return CanSpawnEpic()
	end,
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
			if not SMODS.has_no_rank(v) and not SMODS.has_no_suit(v) then
				return true
			end
		end
	end
}

