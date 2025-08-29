SMODS.Blind{
    key = 'unik_persimmon_placard',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 3},
    boss_colour= HEX("EC5800"),
    dollars = 8,
    unik_exponent = {1,0.9},
    --Disable if doing Jokerless: or has no jokers
    in_pool = function()
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
        if G.jokers then
			if G.jokers.cards then
				if #G.jokers.cards <= 0 then
					return false
				end
			end
		end
        return true
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled then
            return true
        end
        return false
    end,
	set_blind = function(self)
		G.GAME.unik_killed_by_placard = true
        local text = localize('k_unik_placard_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
	end,
	disable = function(self)
		G.GAME.unik_killed_by_placard = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_placard = nil
	end,
}

