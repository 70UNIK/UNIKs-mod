-- next blind has -2 hand size
SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_manacle',
    pos = { x = 0, y = 1 },
    config = {type = "round_start_bonus", extra = {h_size = -1} },
    loc_vars = function(self, info_queue)
		return { vars = {self.config.extra.h_size } }
	end,
    in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == "round_start_bonus" then
            tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                return true
            end)
            G.hand:change_size(tag.config.extra.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + tag.config.extra.h_size
            tag.triggered = true
			return true
		end
	end,
}