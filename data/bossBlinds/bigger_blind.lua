SMODS.Blind{
    key = 'unik_bigger_blind',
    config = {},
    boss = {min = 2, max = 10,}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 2},
    boss_colour= HEX("0a0a0a"),
    dollars = 5,
    mult = 2,
	in_pool = function()
        --return false if the player has rerolled (you cannot get it via rerolling to avoid exploitation of Retcon, it has to generate naturally)
        return true
	end,
}