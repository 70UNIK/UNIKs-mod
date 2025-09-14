SMODS.Blind	{
    key = 'unik_epic_sand',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("544318"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 15},
    vars = {},
    dollars = 13,
    mult = 2,
	pronouns = "he_him",
    loc_vars = function(self)
        local tags = 0
        if #G.HUD_tags ~= 0 then
            tags = #G.HUD_tags
        end
        return {vars = { tostring(tags)} }
	end,
	collection_loc_vars = function(self)
        return {vars = { localize('k_unik_epic_sand_placeholder')} }
		
	end,
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	in_pool = function(self)
        if (G.HUD_tags and #G.HUD_tags < 2) then
            return false
        end
        return CanSpawnEpic()
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind.original_chips = G.GAME.blind.chips
        end
        if not reset and not G.GAME.blind.disabled and #G.HUD_tags ~= 0 then
            for i = 1,#G.HUD_tags do
                G.GAME.blind.chips = G.GAME.blind.chips^2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true
                G.hand_text_area.blind_chips:juice_up()
            end
        end
    end,
}