--The next 6 boss blinds become Epic+ Blinds.
SMODS.Blind	{
    key = 'unik_epic_vice',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("666666"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 18},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 0.25,
    jen_blind_resize = 32,
	--must be localized
	ignore_showdown_check = true,
	in_pool = function(self)
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        if G.GAME.unik_force_epic_plus > 0 then
            return false
        end
        return CanSpawnEpic()
	end,
    loc_vars = function(self)
        return { vars = {G.GAME.unik_old_force_epic_plus or 4} }
	end,
	collection_loc_vars = function(self)
		return { vars = { localize('k_unik_epic_vice_placeholder')} }
	end,
    defeat = function(self, reset, silent)
        G.GAME.unik_old_force_epic_plus = G.GAME.unik_old_force_epic_plus or 4
        G.GAME.unik_force_epic_plus = G.GAME.unik_old_force_epic_plus
        G.GAME.unik_old_force_epic_plus = math.ceil(G.GAME.unik_old_force_epic_plus^1.05)
    end
}
