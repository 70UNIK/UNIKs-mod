--The vice: Defeating this blind will make Finisher Blinds appear every (4 antes, 2 antes, ante)
--cannot be rerolled if appears during rerolls, endless exclusive
SMODS.Blind{
    key = 'unik_vice',
    config = {},
	boss = {
		min = 3,
	},
    atlas = "BlindChips",
    pos = { x = 0, y = 8},
    boss_colour= HEX("666666"),
    dollars = 5,
    mult = 2,
    loc_vars = function(self, info_queue, card)
        local string = ""
        if math.ceil(G.GAME.win_ante/(G.GAME.unik_vice_squeeze*2)) > 1 then
            string = "" .. tostring(math.ceil(G.GAME.win_ante/(G.GAME.unik_vice_squeeze*2))) .. " antes"
        else
            string = "ante"
        end

		return { vars = { string } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_vice_placeholder") } }
	end,
    set_blind = function(self)
		G.GAME.unik_vice_enabled = true
	end,
	disable = function(self)
		G.GAME.unik_vice_enabled = nil
	end,
	defeat = function(self)
		G.GAME.unik_vice_enabled = nil
	end,
}