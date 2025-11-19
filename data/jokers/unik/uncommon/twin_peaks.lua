--context.using_consumeable
SMODS.Atlas {
	key = "unik_twin_peaks",
	path = "unik_twin_peaks.png",
	px = 95,
	py = 71
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_twin_peaks',
    atlas = 'unik_twin_peaks',
	pos = { x = 0, y = 0 },
    rarity = 2,
    config = { extra = { cards = 2 } },
    cost = 5,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    display_size = { w = 95, h = 71 },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.cards} }
	end,
    calculate = function(self, card, context)
		if (context.using_consumeable and context.consumeable.ability.set == 'Spectral') or context.forcetrigger then
            for i = 1, card.ability.extra.cards do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local n_card = create_card("unik_summit",G.consumeables, nil, nil, nil, nil, nil, 'unik_twin_peaks')
                        n_card:add_to_deck()
                        G.consumeables:emplace(n_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, { 
                        message = localize('unik_plus_summit'),
                            colour = G.C.UNIK_SUMMIT,
                            card = card
                        })
                end
            end
            return {

            }
        end
	end
}