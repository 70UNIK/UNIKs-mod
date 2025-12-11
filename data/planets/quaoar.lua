

if SpectrumAPI then
	SpectrumAPI.add_content({
		priority = 1,
		object_type = "Planet",
		key = "unik_quaoar",
		atlas = "unik_poker_hand_shit",
		pos = { x = 1, y = 0 },
		config = { hand_type = "spa_Spectrum", softlock = true },
		aurinko = true,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge(localize("k_dwarf_planet"), get_type_colour(self or card.config, card), nil, 1.2)
		end,
		generate_ui = 0,
		process_loc_text = function(self)
			local target_text = G.localization.descriptions[self.set]['c_mercury'].text
			SMODS.Consumable.process_loc_text(self)
			G.localization.descriptions[self.set][self.key] = {}
			G.localization.descriptions[self.set][self.key].text = target_text
		end
	}, {hand = "spa_Spectrum"})
else
	SMODS.Consumable{
		set = "Planet",
		key = "unik_quaoar",
		atlas = "unik_poker_hand_shit",
		pos = { x = 1, y = 0 },
		config = { hand_type = "unik_spectrum", softlock = true },
		aurinko = true,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge(localize("k_dwarf_planet"), get_type_colour(self or card.config, card), nil, 1.2)
		end,
		generate_ui = 0,
		process_loc_text = function(self)
			local target_text = G.localization.descriptions[self.set]['c_mercury'].text
			SMODS.Consumable.process_loc_text(self)
			G.localization.descriptions[self.set][self.key] = {}
			G.localization.descriptions[self.set][self.key].text = target_text
		end
	}
end