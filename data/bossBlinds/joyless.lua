SMODS.Blind{
    --Hahahahahah no jolly for you
    key = 'unik_the_jollyless',
    config = {},
	boss = {
		min = 1,
		max = 10,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 5},
    boss_colour= HEX("597a90"),
    dollars = 5 ,
    mult = 2,
    --Only summon if there are jolly jokers, M jokers/cards and its not meck
    in_pool = function()
        if G.GAME.modifiers.cry_force_edition and G.GAME.modifiers.cry_force_edition == "cry_m" then
			return false
		end
        if not G.jokers or not G.jokers.cards then
			return false
		end
        local jollycount = 0
        for i = 1, #G.jokers.cards do
			--How to detect 
            if Find_Jolly(G.jokers.cards[i].config.center.key) or G.jokers.cards[i]:is_jolly() then
                jollycount = jollycount + 1
            end
        end
		return (#advanced_find_joker(nil, nil, "e_cry_m", nil, true) ~= 0 or jollycount > 0)
	end,
	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and (Find_Jolly(card) or card.ability.name == "Jolly Joker"
        or (card.edition and card.edition.key == "e_cry_m")
        or (safe_get(card, "pools", "M"))) then
			return true
		end
        if not G.GAME.blind.disabled and (card.area == G.jokers) and (safe_get(card, "pools", "M") or Find_Jolly(card.config.center.key)) then
            return true   
        end
		return false
	end,
	--also prevent pairs from being made (exactly a pair, not other hands containing pairs)
	debuff_hand = function(self, cards, hand, handname, check)
		if next(hand["Pair"]) then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,
	set_blind = function(self)
		G.GAME.unik_killed_by_joyless = true
	end,
	disable = function(self)
		G.GAME.unikk_killed_by_joyless = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_joyless = nil
	end,
}
--Utility function to check things without erroring???
function safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

function Find_Jolly(card)
	
	local MjokerList = {
		"j_cry_biggestm",
		"j_cry_m",
		"j_cry_M",
		"j_cry_bubblem",
		"j_cry_foodm",
		"j_cry_mstack",
		"j_cry_mneon",
		"j_cry_notebook",
		"j_cry_bonk",
		"j_cry_loopy",
		"j_cry_scrabble",
		"j_cry_sacrifice",
		"j_cry_reverse",
		"j_cry_doodlem",
		"j_cry_virgo",
		"j_cry_smallestm",
		"j_cry_macabre",
		"j_cry_Megg",
		"j_cry_longboi",
		"j_cry_mprime",
	}
	for i = 1, #MjokerList do
		if card == MjokerList[i] then
			return true
		end
	end
	return false
end