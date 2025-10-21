SMODS.Blind{
    key = 'unik_crater',
    config = {},
	boss = {
		min = 4,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 33},
    boss_colour= HEX("1b4a1f"),
    dollars = 5,
    mult = 2,
    pronouns = "it_its",
    press_play = function(self)
        if not G.GAME.blind.disabled then
            local stickers = {'tag_unik_half', 'tag_unik_triggering', 'tag_unik_corrupted'}

            add_tag(Tag(stickers[math.random(#stickers)]))

            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            delay(0.7)
        end
    end,

    in_pool = function(self)
        if (G.GAME.round_resets.ante < self.boss.min) or get_deck_win_stake() < 7 then
            return false
        else
            return true
        end
    end,
}