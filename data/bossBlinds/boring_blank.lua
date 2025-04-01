SMODS.Blind{
    key = 'unik_boring_blank',
    config = {},
        ---"""""showdown"""""
    boss = {min = 2, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 15},
    boss_colour= HEX("a9d0d9"),
    dollars = 8,
    mult = 2,
	in_pool = function()
        --stop retcon abuse
        --print(G.GAME.round_resets.boss_rerolled)
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