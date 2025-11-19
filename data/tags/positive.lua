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
					context.card:set_edition({ unik_positive = true }, true)
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

UNIK.unik_detrimental_editions = {
	"e_gb_temporary",
	"e_Bakery_Carbon",
	"e_unik_positive",
	"e_unik_bloated",
	"e_unik_halfjoker",
	"e_unik_fuzzy",
	"e_unik_corrupted",
}

function isDetrimentalEdition2(edition)
	for i = 1, #UNIK.unik_detrimental_editions do
		if edition == UNIK.unik_detrimental_editions[i] then
			return true
		end
	end
	return false
end

function isDetrimentalEdition(card)
	if card.edition then
		if 
		card.edition.unik_positive or
		card.edition.unik_bloated or
		card.edition.unik_halfjoker or
		card.edition.unik_fuzzy or
		card.edition.unik_corrupted then
			return true
		else
			for i = 1, #UNIK.unik_detrimental_editions do
				if card.edition.key == UNIK.unik_detrimental_editions[i] then
					return true
				end
			end
		end
	end
	return false
end