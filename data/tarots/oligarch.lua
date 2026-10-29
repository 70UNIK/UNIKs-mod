SMODS.Consumable{
    set = "Tarot",
   	key = "oligarch",
	pos = { x = 0, y = 5 },
	config = { mod_conv = "m_unik_dollar", max_highlighted = 1 },
	atlas = "unik_consumables",
	attributes = {'modify_card', 'enhancements'},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_dollar

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(
			G.localization.misc.dictionary.bunc_mysterious_tarot,
			get_type_colour(self or card.config, card),
			nil,
			1.2
		)
	end,
}