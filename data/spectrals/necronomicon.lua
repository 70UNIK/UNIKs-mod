--create 2 spectral cards (must have room)
--create a random subpar detriment.
SMODS.Consumable {
    key = 'unik_necronomicon',
    set = 'Spectral',
	atlas = "placeholders",
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {cards = 2 },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { card.ability.cards } }
    end,
    can_use = function(self, card)
         return (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit) or
            (G.consumeables and card.area == G.consumeables and #G.consumeables.cards - 1 < G.consumeables.config.card_limit)
    end,
    attributes = {'generation','consumable','spectral','detriment'},
    use = function(self, card, area, copier)
         for i = 1, math.min(card.ability.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Spectral', key_append = "unik_necro_spectral" })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('cancel')
                        UNIK.create_detriment({severity = 1,seed = "unik_necro_detriment" })
                        card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        delay(0.6)
    end,
}
