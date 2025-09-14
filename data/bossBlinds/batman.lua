SMODS.Blind{
    key = 'unik_black_bat',
    config = {},
    boss = {min = 1, max = 10, showdown = true, no_orb = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 2},
    boss_colour= HEX("0a0a0a"),
    dollars = 8,
	pronouns = "he_him",
	--Stop him from appearing in obsidian orb
	no_orb = true,
    mult = 1,
    unik_exponent = {1,0.8},
	loc_vars = function(self, info_queue, card)
		return { vars = { math.floor((#G.jokers.cards * 0.8))  } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_batman_placeholder") } }
	end,
	death_message = 'special_lose_unik_defeated_by_batman',
	-- collection_loc_vars = function (self)
	-- 	local display = "~75% of"
	-- 	if G.jokers then
	-- 		if G.jokers.cards then
	-- 			--print("#G.jokers.cards")
	-- 			display = tostring(math.floor(#G.jokers.cards * 0.75))
	-- 			--print(display)
	-- 		end
	-- 	end
	-- 	return { vars = { "" .. display } }
	-- end,
	--Disable if doing Jokerless or has 1 or less jokers
	   in_pool = function()
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
		if G.jokers then
			if G.jokers.cards then
				if #G.jokers.cards <= 1 then
					return false
				end
			end
		end
        return true
	end,
    recalc_debuff = function(self, card, from_blind)
		if G.jokers then
			local jokerCount = #G.jokers.cards
			if jokerCount > 1 then
				for i = 1, jokerCount do
					if (card.area == G.jokers) and G.jokers.cards[i] == card and i > 1 and i > math.ceil((jokerCount * 0.2)) and not G.GAME.blind.disabled then
						return true
					end
				end
			end

		end
		return false
	end,
	set_blind = function(self)
		G.GAME.unik_arrested_by_batman = true
		local text = localize('k_unik_batman_start')
        attention_text({
            scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
	end,
	disable = function(self)
		G.GAME.unik_arrested_by_batman = nil
	end,
	defeat = function(self)
		G.GAME.unik_arrested_by_batman = nil
	end,
}