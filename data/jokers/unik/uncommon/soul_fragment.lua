--Sell to create a perishable legendary joker with $0 sell value
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
    calculate = function(self, card, context)
		if (context.selling_self and not (context.retrigger_joker or context.blueprint)) or context.forcetrigger then
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_unik_taste_of_power") ,colour = G.C.PURPLE})
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0,
                func = function()
                    
                    play_sound("timpani")
                    local card2 = create_card("Joker", G.jokers, true, nil, nil, nil, nil, "unik_tech_demo")
                    card2.ability.perishable = true
                    card2.ability.perish_tally = G.GAME.perishable_rounds or 5
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:juice_up(0.3, 0.5)
                    unik_set_sell_cost(card2,0)
                    return true
                end,
            }))
            if context.forcetrigger then
                selfDestruction_noMessage(card)
            end
            return {

            }
        end
	end,
}