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
            if G.jokers.cards[i]:is_jolly() or safe_get(G.jokers.cards[i], "pools", "M") then
                jollycount = jollycount + 1
            end
        end
		return (#advanced_find_joker(nil, nil, "e_cry_m", nil, true) ~= 0 or jollycount > 0)
	end,
	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and (card.ability.name == "Jolly Joker"
        or (card.edition and card.edition.key == "e_cry_m")
        or (safe_get(card, "pools", "M"))) then
			return true
		end
        if not G.GAME.blind.disabled and (card.area == G.jokers) and safe_get(card, "pools", "M") then
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

