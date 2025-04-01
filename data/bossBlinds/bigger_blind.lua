SMODS.Blind{
    key = 'unik_bigger_blind',
    config = {},

    boss = {min = 2, }, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 14},
    boss_colour= HEX("c23bdf"),
    dollars = 5,
    mult = 2,
	in_pool = function()
        --stop retcon abuse
        if G.GAME.round_resets.boss_rerolled then
            return false
        end
        --return false if the player has rerolled (you cannot get it via rerolling to avoid exploitation of Retcon, it HAS to generate naturally)
        return true
	end,
    set_blind = function(self)
		G.GAME.unik_killed_by_bigger_blind = true
		--G.GAME.unik_poppy_ceil = true
	end,

	defeat = function(self)
		G.GAME.unik_killed_by_bigger_blind = nil

	end,
}