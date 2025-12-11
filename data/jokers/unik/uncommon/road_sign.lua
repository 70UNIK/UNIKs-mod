--create a summit card if hand contains a straight and a 10.
SMODS.Joker {
    key = 'unik_road_sign',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 6, y = 3 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { } },
    loc_vars = function(self, info_queue, center)
		return { vars = {} }
	end,
    pronouns = "it_its",
    calculate = function(self, card, context)
        if (context.joker_main or context.force_trigger )and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local tens = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 10 then tens = tens + 1 end
            end
            if tens >= 1 and next(context.poker_hands["Straight"]) or context.force_trigger then
                local card_type = 'unik_summit'
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'roadsign')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                return {
                    message = localize('unik_plus_summit'),
                    colour = G.C.UNIK_SUMMIT,
                    card = card
                }
            end
        end
    end
}