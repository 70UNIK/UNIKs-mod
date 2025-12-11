SMODS.Consumable{
    set = "Planet",
   	key = "unik_asteroid_belt",
    atlas = "unik_poker_hand_shit",
	pos = { x = 0, y = 0 },
	config = { hand_type = "unik_bulwark", softlock = true },
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_disc"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	generate_ui = 0,
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = {}
        G.localization.descriptions[self.set][self.key].text = target_text
    end
}