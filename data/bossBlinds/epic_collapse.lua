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
    pronouns = "it_its",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	--must be localized
	death_message = 'special_lose_unik_epic_collapse',
	
	in_pool = function(self)
		local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards < 1 then
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

