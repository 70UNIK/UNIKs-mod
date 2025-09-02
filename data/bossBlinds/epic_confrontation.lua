SMODS.Blind	{
    key = 'unik_epic_confrontation',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("5d187a"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 20},
    vars = {},
    dollars = 13,
    mult = 2,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	--must be localized
	
    unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in pairs(G.hand.cards) do
			if not v:is_face(true) then
                local isNotSelected = true
				for l,w in pairs(cards) do
                    if w == v then
                        isNotSelected = false
                    end
                end
                if isNotSelected then
                    return true
                end
			end
		end
        return false
	end,
    in_pool = function(self)
        local faceCards = 0
        if G.playing_cards then
            for i,v in pairs(G.playing_cards) do
                if v:is_face(true) then
                    faceCards = faceCards + 1
                end
            end
        end
        if G.hand and G.hand.config then
                --always be false if face cards are less than hand size - card selection limit (to avoid impossible situations)
            if faceCards < (G.hand.config.card_limit - G.hand.config.highlighted_limit) then
                return false
            end
        end
        
        return CanSpawnEpic()
	end,
}
