SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_bloated',
    pos = { x = 1, y = 2 },
    config = {type = "store_joker_modify" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_bloated
	end,
	in_pool = function()
		return false
	end,
	apply = function(self, tag, context)
        if context.type == "store_joker_modify" then
			if not isDetrimentalEdition(context.card) and not context.card.unik_temp_detrimental and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				context.card.unik_temp_detrimental = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
					context.card:set_edition({ unik_bloated = true }, true)
					context.card:set_cost()
					context.card.temp_edition = nil
					context.card.unik_temp_detrimental = nil
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				tag.triggered = true
			end
		end
	end,
}