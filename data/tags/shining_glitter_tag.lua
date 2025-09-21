SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_shining_glitter',
    pos = { x = 2, y = 1 },
    config = {type = "store_joker_modify",edition = "unik_shining_glitter" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_shining_glitter
	end,
	apply = function(self, tag, context)
        if context.type == "store_joker_modify" then
			local _applied = nil
			if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
                tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition({ unik_shining_glitter = true }, true)
					context.card.ability.couponed = true
					context.card:set_cost()
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