--Replace 1 random Joker after each hand (vermillion virus)
SMODS.Challenge{
    key = "unik_rng_2",
	rules = {
		custom = {
			{ id = "all_rnj" },
            { id = "unik_vermillion_pandemic"},
		},
		modifiers = {},
	},
	jokers = {},
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = {
			{ id = "tag_uncommon" },
			{ id = "tag_rare" },
			{ id = "tag_top_up" },
			{ id = "tag_cry_epic" },
		},
		banned_cards = {
			{ id = "j_cry_equilib" },
			{ id = "c_cry_delete" },
			{ id = "p_cry_meme_1", ids = { "p_cry_meme_1", "p_cry_meme_two", "p_cry_meme_three" } },
		},
        banned_other = {
            {id = 'bl_cry_box', type = 'blind'},
            {id = 'bl_cry_striker', type = 'blind'},
            {id = 'bl_cry_windmill', type = 'blind'},
            {id = 'bl_cry_pin', type = 'blind'},
        },
	},

}
--add override for enabling the pandemic
local gfep2 = G.FUNCS.evaluate_play
function G.FUNCS:evaluate_play(e)
	local var = gfep2(self,e)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            if G.GAME.modifiers.unik_vermillion_pandemic then
                if G.jokers.cards[1] then
                    local idx = pseudorandom(pseudoseed("cry_vermillion_virus"), 1, #G.jokers.cards)
                    if G.jokers.cards[idx] then
                        if G.jokers.cards[idx].config.center.immune_to_vermillion then
                            card_eval_status_text(
                                G.jokers.cards[idx],
                                "extra",
                                nil,
                                nil,
                                nil,
                                { message = localize("k_nope_ex"), colour = G.C.JOKER_GREY }
                            )
                        else
                            _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "cry_vermillion_virus_gen")
                            G.jokers.cards[idx]:remove_from_deck()
                            _card:add_to_deck()
                            _card:start_materialize()
                            G.jokers.cards[idx] = _card
                            _card:set_card_area(G.jokers)
                            G.jokers:set_ranks()
                            G.jokers:align_cards()
                        end
                    end
                end
            end
            return true
        end
    }))
    return var
end