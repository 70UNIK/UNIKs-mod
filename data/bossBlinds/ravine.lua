SMODS.Blind{
    key = 'unik_ravine',
    config = {},
	boss = {
		min = 4,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 32},
    boss_colour= HEX("5e0003"),
    dollars = 5,
    mult = 2,
    pronouns = "it_its",
    press_play = function(self)
        if not G.GAME.blind.disabled then
            local stickers = {'tag_unik_positive', 'tag_unik_disposable', 'tag_unik_fuzzy'}

            add_tag(Tag(stickers[pseudorandom("unik_ravine_blind",1,3)]))

            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            delay(0.7)
        end
    end,

    in_pool = function(self)
        if (G.GAME.round_resets.ante < self.boss.min) or get_deck_win_stake() < 9 then
            return false
        else
            return true
        end
    end,
}