SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_limited_edition',
    pos = { x = 1, y = 4 },
    config = {type = "store_joker_modify"},
    loc_vars = function(self, info_queue)
        -- info_queue[#info_queue + 1] = { set = "Other", key = "unik_limited_edition" }
	end,
	in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == self.config.type then
            if context.card and context.card.edition and not isDetrimentalEdition(context.card) and not context.card.ability.unik_limited_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
					context.card.ability.unik_limited_edition = true
                    context.card:juice_up(1,1)
                    context.card:set_cost()
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				tag.triggered = true
            end
            return true
        end
	end,
}
