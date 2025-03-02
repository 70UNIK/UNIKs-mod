SMODS.Blind{
    key = 'unik_black_bat',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 2},
    boss_colour= HEX("0a0a0a"),
    dollars = 8,
    mult = 0.3,
	--Disable if doing Jokerless:
	   in_pool = function()
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
        return true
	end,
    recalc_debuff = function(self, card, from_blind)
		if (card.area == G.jokers) and not G.GAME.blind.disabled then
			return true
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