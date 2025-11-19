--The Oligarch!
--Enhance 3 cards to bill cards. Bill cards give $1 when scored, increase by $1 per bill card in scored hand.
SMODS.Consumable{
    set = "Rotarot",
   	key = "unik_rot_oligarch",
	pos = { x = 0, y = 1 },
	display_size = { w = 106, h = 106 },
	config = { mod_conv = "m_unik_bill", max_highlighted = 2 },
	atlas = "unik_rotarots",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_bill

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
		    unlocked = true,
    discovered = true,
	    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = MoreFluff }, badges)
    end,
}

