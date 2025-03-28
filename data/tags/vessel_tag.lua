--3x blind size. Only obtained if you fail a demon tag

SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_vessel',
    pos = { x = 1, y = 0 },
    config = {type = "round_start_bonus", extra = {size = 3} },
    loc_vars = function(self, info_queue)
		return { vars = {self.config.extra.size } }
	end,
    in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == "round_start_bonus" then
            tag:too_bad("TOO BAD", G.C.BLACK, function()
                return true
            end)
            G.GAME.blind.chips = G.GAME.blind.chips * tag.config.extra.size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate(true)
			tag.triggered = true
			return true
		end
	end,
}
