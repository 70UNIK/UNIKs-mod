--The Crossdresser!
--Convert 1 selected card into a green card
SMODS.Consumable{
    set = "Rotarot",
   	key = "unik_rot_crossdresser",
	pos = { x = 2, y = 6 },
	mf_rotate_by = math.pi / 4,
	config = { mod_conv = "m_unik_green", max_highlighted = 1 },
	atlas = "unik_consumables",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_green

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	    unlocked = true,
    discovered = true,
	    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = MoreFluff }, badges)
    end,
}

