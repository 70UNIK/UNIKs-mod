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

    in_pool = function(self)
        if (G.GAME.round_resets.ante < self.boss.min) then
            return false
        else
            return true
        end
    end,
}