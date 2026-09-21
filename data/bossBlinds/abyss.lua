SMODS.Blind{
    key = 'unik_abyss',
    config = {},
	boss = {
		min = 4,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 34},
    boss_colour= HEX("411546"),
    dollars = 5,
    mult = 2,
    pronouns = "it_its",
    press_play = function(self)
        if not G.GAME.blind.disabled then
            local stickers = {'tag_unik_limited_edition', 'tag_unik_bloated', 'tag_unik_manacle'}

            add_tag(Tag(stickers[pseudorandom("unik_abyss_blind",1,3)]))

            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            delay(0.7)
        end
    end,
    aij_calculate_counter_score = function()
        --Mainly hampers the shop
        --Max counter:
        -- 1) Double tags or any tag duplication would increase the odds
        -- 2) Vessel Kiln will make it have a tangible effect on score due to the vessel tags
        return 0
    end,
    in_pool = function(self)
        if (G.GAME.round_resets.ante < self.boss.min) then
            return false
        else
            return true
        end
    end,
}