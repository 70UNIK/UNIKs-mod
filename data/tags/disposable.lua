SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_disposable',
    pos = { x = 2, y = 3 },
    config = {type = "store_joker_modify"},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_disposable" }
	end,
	in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == self.config.type then
            if context.card and not context.card.ability.unik_disposable and context.card.ability.set == 'Joker' and not SMODS.is_eternal(context.card,self) then
                local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
					context.card.ability.unik_disposable = true
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
