--sell to create an Absolute Rental Niko Exotic Joker
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	-- How the code refers to the joker.
	key = 'unik_a_taste_of_power',
    atlas = 'unik_rare',
    rarity = 3,
	pos = { x = 1, y = 0 },
    cost = 6,
	blueprint_compat = false,
    perishable_compat = false,
    demicoloncompat = true,
	eternal_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_niko" }
	end,
    calculate = function(self, card, context)
		if (context.selling_self and not (context.retrigger_joker or context.blueprint)) or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0,
                func = function()
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_unik_taste_of_power") ,colour = G.C.DARK_EDITION})
                    play_sound("timpani")
                    local card2 = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "unik_a_taste_of_power")
                    card2.ability.rental = true
                    card2.ability.unik_niko = true
                    card2.ability.cry_absolute = true
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:juice_up(0.3, 0.5)
                    return true
                end,
            }))
           -- return true
		end
	end,
}