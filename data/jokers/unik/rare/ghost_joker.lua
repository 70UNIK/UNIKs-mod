SMODS.Joker {
    key = 'unik_ghost_joker',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.setting_blind or context.forcetrigger) and not (context.blueprint_card or self).getting_sliced then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local n_card = create_card("Spectral",G.consumeables, nil, nil, nil, nil, nil, 'unik_ghost_joker')
                    n_card:add_to_deck()
                    G.consumeables:emplace(n_card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
                card_eval_status_text(card, 'extra', nil, nil, nil, { 
                    message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        card = card
                    })
            end
            return {

            }
         end
    end,
}