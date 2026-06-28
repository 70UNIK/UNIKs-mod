--The Oligarch!
--Enhance 3 cards to bill cards. Bill cards give $1 when scored, increase by $1 per bill card in scored hand.
SMODS.Consumable{
    set = "Rotarot",
   	key = "unik_rot_oligarch",
	pos = { x = 1, y = 7 },
	mf_rotate_by = math.pi / 4,
	config = { mod_conv = "m_unik_bill", max_highlighted = 2 },
	atlas = "unik_consumables",
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

