--all jokers in the next shop become positive. It will be the only detrimental tag in the pool cause funny
SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_positive',
    pos = { x = 1, y = 1 },
    config = {type = "store_joker_modify",edition = "unik_positive" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
	end,
	in_pool = function()
		if G.GAME.unik_enable_positives then
			return true
		end
		return false
	end,
	apply = function(self, tag, context)
        if context.type == "store_joker_modify" then
			local _applied = nil
			if (SMODS.Mods["Cryptid"] or {}).can_load and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
					context.card:set_edition({ unik_positive = true }, true)
					context.card.ability.couponed = true
					context.card.temp_edition = nil
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				_applied = true
				tag.triggered = true
			end
		end
	end,
}