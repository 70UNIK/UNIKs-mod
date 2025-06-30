--create a minor arcana card on blind select
--create an rare joker when selecting big or boss blind
if PB_UTIL and PB_UTIL.config.minor_arcana_enabled then
SMODS.Joker {
    key = 'unik_weetomancer',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 8, y = 1 },
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    calculate = function(self, card, context)
        if (context.setting_blind or context.forcetrigger) and not (context.blueprint_card or self).getting_sliced then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local n_card = create_card("paperback_minor_arcana",G.consumeables, nil, nil, nil, nil, nil, 'minor_arcana')
                    n_card:add_to_deck()
                    G.consumeables:emplace(n_card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
                card_eval_status_text(card, 'extra', nil, nil, nil, { 
                    message = localize('paperback_plus_minor_arcana'),
                        colour = G.C.PAPERBACK_MINOR_ARCANA,
                        card = card
                    })
            end
            return {

            }
         end
    end,
}
end