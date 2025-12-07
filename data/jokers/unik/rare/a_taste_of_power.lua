--sell to create an eternal decaying ancient joker (destroyed after 4 rounds)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_a_taste_of_power',
    atlas = 'unik_rare',
    rarity = 3,
	pos = { x = 1, y = 0 },
    cost = 1,
	blueprint_compat = false,
    perishable_compat = true,
    demicoloncompat = true,
	eternal_compat = false,
    loc_vars = function(self, info_queue, center)
        if not center.ability.unik_decaying then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_decaying",vars = { 4, 4 } }
        end
	end,
    calculate = function(self, card, context)
		if (context.selling_self and not (context.retrigger_joker or context.blueprint)) or context.forcetrigger then
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_unik_taste_of_power") ,colour = G.C.DARK_EDITION})
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0,
                func = function()

                    play_sound("timpani")
                    local card2 = create_card("Joker", G.jokers, nil, "unik_ancient", nil, nil, nil, "unik_a_taste_of_power")
                    card2.ability.unik_decaying = true
                    G.GAME.unik_decaying_rounds = G.GAME.unik_decaying_rounds or 4
                    card2.ability.unik_decaying_tally = G.GAME.unik_decaying_rounds
                    unik_set_sell_cost(card2,0)
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            return{
                
            }
		end
	end,
}