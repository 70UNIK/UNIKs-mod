--The Crossdresser!
--Convert 1 selected card into a green card
SMODS.Consumable{
    set = "Rotarot",
   	key = "unik_rot_crossdresser",
	pos = { x = 0, y = 0 },
	display_size = { w = 106, h = 106 },
	config = { mod_conv = "m_unik_green", max_highlighted = 1 },
	atlas = "unik_rotarots",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_green

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
}

