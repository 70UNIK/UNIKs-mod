SMODS.Consumable{
    set = "Tarot",
   	key = "crossdresser",
	pos = { x = 1, y = 0 },
	config = { mod_conv = "m_unik_pink", max_highlighted = 1 },
	atlas = "unik_tarots",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_pink

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
}