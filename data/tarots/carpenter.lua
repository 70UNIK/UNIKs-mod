SMODS.Consumable{
    set = "Tarot",
   	key = "carpenter",
	pos = { x = 1, y = 2 },
	config = { mod_conv = "m_unik_timber", max_highlighted = 1 },
	atlas = "placeholders",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_timber

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
}