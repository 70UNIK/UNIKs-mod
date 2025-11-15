SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_triggering',
    pos = { x = 0, y = 4 },
    config = {type = "store_joker_modify"},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_triggering_joker" }
	end,
	in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == self.config.type then
            if context.card and not context.card.ability.unik_triggering and context.card.ability.set == 'Joker' and not SMODS.is_eternal(context.card,self) 
            and not context.card.config.center.triggering_blacklist then
                local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
					context.card:set_triggering(true)
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
