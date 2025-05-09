--Sell to create a disposable eternal rental legendary joker
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_soul_fragment',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 2, y = 1 },
    cost = 5,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_disposable" }
	end,
    calculate = function(self, card, context)
		if (context.selling_self and not (context.retrigger_joker or context.blueprint)) or context.forcetrigger then
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_unik_taste_of_power") ,colour = G.C.PURPLE})
            play_sound("timpani")
            local card2 = create_card("Joker", G.jokers, true, nil, nil, nil, nil, "unik_tech_demo")
            card2.ability.rental = true
            card2.ability.unik_disposable = true
            card2.ability.eternal = true
            card2:add_to_deck()
            G.jokers:emplace(card2)
            card2:juice_up(0.3, 0.5)
            return true
		end
	end,
}